extends Node2D

@export var moveDistance: int
@export var moveSpeed: int
@export var waitTimeBetweenMovement: float
var time: float

var readyToMove: bool
var currPos: Vector2i
var oldPos: Vector2i
var newPos: Vector2i

var input = Vector2i.ZERO
var priorityDirection: int

@export var width: int
@export var height: int
@export var xStart: int
@export var yStart: int
@export var offset: int

var collisionMap = []

func _ready():
	currPos = Vector2i.ZERO
	oldPos = Vector2i.ZERO
	collisionMap = _make_2d_array()
	_fill_collision_map()
	readyToMove = false

func _process(delta):
	_get_input()
	if(!readyToMove):
		_move_target()
	if(readyToMove):
		_handle_movement(delta)

func _make_2d_array():
	var array = []
	for x in height:
		array.append([])
		for y in width:
			array[x].append(null)
	return array

func _fill_collision_map():
	for x in height:
		for y in width:
			if(x % 2 == 0):
				collisionMap[x][y] = 1
			else:
				if(y % 2 == 0):
					collisionMap[x][y] = 1
				else:
					collisionMap[x][y] = 0

func _move_target():
	newPos = currPos
	if(priorityDirection == 0):
		newPos.x += input.x
		if(newPos.x < 0 || newPos.x > width-1 || collisionMap[newPos.y][newPos.x] == 0):
			newPos.x = currPos.x
			if(input.y != 0):
				newPos.y += input.y
				if(newPos.y < 0 || newPos.y > height-1 || collisionMap[newPos.y][newPos.x] == 0):
					newPos.y = currPos.y
	else:
		newPos.y += input.y
		if(newPos.y < 0 || newPos.y > height-1 || collisionMap[newPos.y][newPos.x] == 0):
			newPos.y = currPos.y
			if(input.x != 0):
				newPos.x += input.x
				if(newPos.x < 0 || newPos.x > width-1 || collisionMap[newPos.y][newPos.x] == 0):
					newPos.x = currPos.x
	if(newPos == currPos):
		readyToMove = false
	else:
		if(collisionMap[newPos.y][newPos.x] == 1):
			currPos = newPos
			readyToMove = true

func _handle_movement(delta):
	_check_if_moved_back()
	$"..".global_position = $"..".global_position.move_toward(currPos*moveDistance, delta*moveSpeed)
	if($"..".global_position == Vector2(currPos.x*moveDistance, currPos.y*moveDistance)):
		if(oldPos != currPos): 
			oldPos = currPos
		time += delta
	if time>=waitTimeBetweenMovement:
		time = 0.0
		readyToMove = false

func _check_if_moved_back():
	if(Input.is_action_just_pressed("Left")):
		if(oldPos.x - newPos.x == -1):
			_move_back()
	if(Input.is_action_just_pressed("Right")):
		if(oldPos.x - newPos.x == 1):
			_move_back()
	if(Input.is_action_just_pressed("Up")):
		if(oldPos.y - newPos.y == -1):
			_move_back()
	if(Input.is_action_just_pressed("Down")):
		if(oldPos.y - newPos.y == 1):
			_move_back()

func _move_back():
	currPos = oldPos
	oldPos = newPos
	newPos = currPos

func _get_input():
	input.x = int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left"))
	input.y = int(Input.is_action_pressed("Down")) - int(Input.is_action_pressed("Up"))
	if(input.x == 0 && input.y != 0):
		priorityDirection = 1
	if(input.y == 0 && input.x != 0):
		priorityDirection = 0
	if(Input.is_action_just_pressed("Right") || Input.is_action_just_pressed("Left")):
		priorityDirection = 0
	if(Input.is_action_just_pressed("Down") || Input.is_action_just_pressed("Up")):	
		priorityDirection = 1
