extends Node

var levelData

#cursor data
var cursorPosition: Vector2i
var inputPosition: Vector2i
var positionList = []

#anchor and stretcher
var cursorAnchor
var cursorStretcher

#tile data
var selectedTileID = 1

func _ready():
	levelData = $"../../LevelData"
	cursorAnchor = $"../CursorAnchor"
	cursorStretcher = $"../CursorStretcher"

func _fill_cell():
	levelData._fill_cell(cursorPosition.x,cursorPosition.y, selectedTileID, 0)

func _fill_region():
	_fill_position_list()
	levelData._fill_region(positionList, selectedTileID)
	positionList.clear()

func _fill_position_list():
	var x_step = 1 if cursorPosition.x > inputPosition.x else -1
	var y_step = 1 if cursorPosition.y > inputPosition.y else -1

	for x in range(inputPosition.x, cursorPosition.x + x_step, x_step):
		for y in range(inputPosition.y, cursorPosition.y + y_step, y_step):
			positionList.append(Vector2i(x, y))

func _input(event):
	if(Input.is_action_just_pressed("EditorPlace")):
		inputPosition = cursorPosition
		cursorAnchor.locked = true
		cursorStretcher.locked = true
	if(Input.is_action_just_released("EditorPlace")):
		cursorAnchor.locked = false
		cursorStretcher._stretch()
		cursorStretcher.locked = false
		if(cursorPosition == inputPosition):
			_fill_cell()
		else:
			_fill_region()
