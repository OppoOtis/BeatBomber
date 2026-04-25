@tool
extends Control

@export var worldIndex: int = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = "Level " + str(worldIndex)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.is_editor_hint():
		$Label.text = "Level " + str(worldIndex)
