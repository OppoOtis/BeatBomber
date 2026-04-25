extends Control

@onready var levels: Array = [$LevelIcon, $LevelIcon2, $LevelIcon3, $LevelIcon4, $LevelIcon5, $LevelIcon6, $LevelIcon7, $LevelIcon8, $LevelIcon9]
var currentLevel: int = 0

func _ready():
	_set_icon_position()

func _input(event):
	if event.is_action_pressed("ui_left") and currentLevel > 0:
		currentLevel -= 1
		_set_icon_position()
	
	if event.is_action_pressed("ui_right") and currentLevel < levels.size() - 1:
		currentLevel += 1
		_set_icon_position()

func _set_icon_position():
	$PlayerIcon.global_position = levels[currentLevel].global_position
