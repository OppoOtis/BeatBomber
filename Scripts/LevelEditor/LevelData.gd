extends Node

var levelData = []

func _ready():
	_make_5d_array()

func _make_5d_array():
	for i in range(100):
		var row = []
		for j in range(100):
			row.append(Vector3())
		levelData.append(row)

#functions for updating levelData
#like, fil cell, fill region, remove region
