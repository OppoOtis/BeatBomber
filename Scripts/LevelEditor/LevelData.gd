extends Node

var levelData = []

var levelVisualizer

func _ready():
	levelVisualizer = $LevelVisualizer
	_prepare_level_data()

func _prepare_level_data():
	for i in range(10):
		var row = []
		for j in range(10):
			row.append(Vector3i())
		levelData.append(row)

#functions for updating levelData
#like, fil cell, fill region, remove region
func _fill_cell(x, y, value, type):
	var vec = levelData[x][y]
	match type:
		0:
			vec.x = value
		1:
			vec.y = value
		2:
			vec.z = value
	levelData[x][y] = vec
	
	levelVisualizer._draw_cell(x,y,value,type)

func _fill_region(positionList,value):
	var vec = Vector3i.ZERO
	for position in positionList:
		vec = levelData[position.x][position.y]
		vec.x = value
		levelData[position.x][position.y] = vec
	
	levelVisualizer._draw_region(positionList,value)

func _load_full_level():
	for x in range(levelData.size()):
		for y in range(levelData[x].size()):
			var vec = levelData[x][y]
			if vec.x != 0:
				_fill_cell(x, y, vec.x, 0)
			if vec.y != 0:
				_fill_cell(x, y, vec.y, 1)
			if vec.z != 0:
				_fill_cell(x, y, vec.z, 2)
