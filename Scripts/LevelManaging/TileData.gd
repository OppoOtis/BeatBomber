extends Node2D

#Environment Tile Table
func _environment_tile_table(value):
	match value:
		0:
			return {"tileID": 0, 
					"terrainTile": true}
		1:
			return {"tileID": 1, 
					"terrainTile": true}
		2:
			return {"tileID": 2, 
					"terrainTile": true}

#Object Tile Table
func _object_tile_table(value):
	match value:
		0:
			return {"tileID": 0}
		1:
			return {"tileID": 1}
		2:
			return {"tileID": 2}

#Item Tile Table
func _item_tile_table(value):
	match value:
		0:
			return {"tileID": 0}
		1:
			return {"tileID": 1}
		2:
			return {"tileID": 2}
