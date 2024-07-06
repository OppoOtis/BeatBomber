extends Node

var tileData

var environmentTilemap
var objectTilemap
var itemTilemap

func _ready():
	tileData = $"../../TileData"
	environmentTilemap = $"../Environment"

func _draw_cell(x, y, value, type):
	var tile
	match type:
		0:
			tile = tileData._environment_tile_table(value)
			if(tile["terrainTile"]):
				var cells = []
				cells.append(Vector2i(x,y))
				environmentTilemap.set_cells_terrain_connect(0,cells,tile["tileID"],0)
			else:
				environmentTilemap.set_cell(0,Vector2i(x,y),tile["tileID"],Vector2i(0,0))
		1:
			print("nothing yet")
		2:
			print("nothing yet also")

func _draw_region(positionList,value):
	var tile
	tile = tileData._environment_tile_table(value)
	if(tile["terrainTile"]):
		environmentTilemap.set_cells_terrain_connect(0,positionList,tile["tileID"],0)
	else:
		for position in positionList:
			environmentTilemap.set_cell(0,position,tile["tileID"],Vector2i(0,0))
