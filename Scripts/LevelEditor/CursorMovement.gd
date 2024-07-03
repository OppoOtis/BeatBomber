extends Node

#grid data
var positionGrid
@export var gridSize: Vector2i

#mouse
var mousePos

#controller
var input = Vector2i.ZERO
@export var waitTime: float
var time = 0.0

#cursor
var cursor
var cursorPosition: Vector2i
var oldCursorPosition: Vector2i
var cursorBoost = 1.0
var cursorAnchor
var cursorStretcher

#placement
var placement

func _ready():
	positionGrid = $"../../UnderlayGridSpawner/TileMap"
	cursor = $"."
	placement = $"../Placement"
	cursorAnchor = $"../CursorAnchor"
	cursorStretcher = $"../CursorStretcher"

func _process(delta):
	_get_input()
	if(input != Vector2i.ZERO):
		if(time < waitTime*cursorBoost):
				time += delta
		else:
			_move_cursor(1)
			_update_old_cursor()
			time = 0.0

func _move_cursor(type):
	if(type == 0):
		cursorPosition = mousePos
	elif(type == 1):
		cursorPosition += input
	if(cursorPosition.x < 0):
		cursorPosition.x = 0
	if(cursorPosition.x > gridSize.x-1):
		cursorPosition.x = gridSize.x-1
	if(cursorPosition.y < 0):
		cursorPosition.y = 0
	if(cursorPosition.y > gridSize.y-1):
		cursorPosition.y = gridSize.y-1
	cursor.position = Vector2(cursorPosition.x*16, cursorPosition.y*16)
	cursorAnchor._move_anchor(Vector2(cursorPosition.x*16, cursorPosition.y*16))
	cursorStretcher._move_stretcher(Vector2(cursorPosition.x*16, cursorPosition.y*16))
	cursorStretcher._stretch()

func _update_old_cursor():
	if(cursorPosition != oldCursorPosition):
			placement.cursorPosition = cursorPosition
			oldCursorPosition = cursorPosition

func _input(event):
	if event is InputEventMouseMotion:
		mousePos = positionGrid.local_to_map(positionGrid.get_global_mouse_position())
		_move_cursor(0)
		_update_old_cursor()
	if(Input.is_action_just_pressed("EditorCursorBoost")):
		cursorBoost = .2
	if(Input.is_action_just_released("EditorCursorBoost")):
		cursorBoost = 1.0

func _get_input():
	input.x = int(Input.is_action_pressed("EditorCursorRight")) - int(Input.is_action_pressed("EditorCursorLeft"))
	input.y = int(Input.is_action_pressed("EditorCursorDown")) - int(Input.is_action_pressed("EditorCursorUp"))
