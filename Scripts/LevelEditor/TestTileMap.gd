extends TileMap

@export var gridSize = 10
var levelData = []

# Called when the node enters the scene tree for the first time.
func _ready():
	#var cells: PackedVector2Array
	#for x in gridSize:
		#for y in gridSize:
			#dic[str(Vector2(x,y))] = {
				#"Type": "Cell"
			#}
			#cells.append(Vector2(x,y))
	#set_cells_terrain_connect(0,cells,0,0)
	_make_5d_array()

func _make_5d_array():
	for i in range(gridSize):
		var row = []
		for j in range(gridSize):
			row.append(Vector3())
		levelData.append(row)
