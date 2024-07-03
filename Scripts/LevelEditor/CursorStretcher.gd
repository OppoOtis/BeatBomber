extends NinePatchRect

var cursor
var cursorAnchor
var cursorStretcher
var locked: bool

func _ready():
	cursor = $"../Movement"
	cursorAnchor = $"../CursorAnchor"
	cursorStretcher = $"."
	locked = false

func _stretch():
	if(cursor.position != cursorAnchor.position && locked):
		var posX = cursorAnchor.position.x if cursor.position.x > cursorAnchor.position.x else cursor.position.x
		var posY = cursorAnchor.position.y if cursor.position.y > cursorAnchor.position.y else cursor.position.y
		
		var sizeX = cursor.position.x-cursorAnchor.position.x if cursor.position.x > cursorAnchor.position.x else cursorAnchor.position.x-cursor.position.x
		var sizeY = cursor.position.y-cursorAnchor.position.y if cursor.position.y > cursorAnchor.position.y else cursorAnchor.position.y-cursor.position.y
		
		set_position(Vector2i(posX, posY))
		set_size(Vector2i(sizeX+16, sizeY+16))
	if(!locked):
		set_size(Vector2i(16, 16))

func _move_stretcher(position):
	if(!locked):
		set_position(position)
