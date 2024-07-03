extends Node

var locked: bool

func _ready():
	locked = false

func _move_anchor(position):
	if(!locked):
		$".".position = position
