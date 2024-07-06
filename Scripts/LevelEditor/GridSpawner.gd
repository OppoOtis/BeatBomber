extends Node

@export var gridSize = 10
var dic = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in gridSize:
		for y in gridSize:
			$TileMap.set_cell(0,Vector2i(x,y),0,Vector2i(0,0))
