extends Camera2D

@export var camMovementRange: Vector2i
@export var camMoveSpeed = 0.5
@export var camZoomRange: Vector2i
var camZoom: int

var input = Vector2.ZERO

func _ready():
	camZoom = 8

func _process(delta):
	_get_input()
	_move_camera()
	_check_camera_position()

func _move_camera():
	position.x += input.x*(9-camZoom)*camMoveSpeed
	position.y += input.y*(9-camZoom)*camMoveSpeed

func _check_camera_position():
	if(position.x < 0):
		position.x = 0
	if(position.x > camMovementRange.x*16):
		position.x = camMovementRange.x*16
	if(position.y < 0):
		position.y = 0
	if(position.y > camMovementRange.y*16):
		position.y = camMovementRange.y*16

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _get_input():
	input.x = int(Input.is_action_pressed("EditorRight")) - int(Input.is_action_pressed("EditorLeft"))
	input.y = int(Input.is_action_pressed("EditorDown")) - int(Input.is_action_pressed("EditorUp"))
	input.normalized()

func _input(event):
	if (Input.is_action_just_pressed("EditorZoomIn")):
		print("zoomed")
		_zoom_camera(1)
	if (Input.is_action_just_pressed("EditorZoomOut")):
		_zoom_camera(-1)
	if(Input.is_action_just_pressed("EditorBoost")):
		camMoveSpeed = 1.5
	if(Input.is_action_just_released("EditorBoost")):
		camMoveSpeed = 0.5

func _zoom_camera(value):
	camZoom += value
	if(camZoom < camZoomRange.x):
		camZoom = camZoomRange.x
	elif(camZoom > camZoomRange.y):
		camZoom = camZoomRange.y
	
	zoom.x = camZoom
	zoom.y = camZoom
