extends Node

var level

var safePath: String = "user://level.save"

func _ready():
	level = $"../LevelData"

func save() -> void:
	var file = FileAccess.open(safePath,FileAccess.WRITE)
	var data = {
		"Level": []
	}

	# Convert levelData to a serializable format
	for row in level.levelData:
		var serialized_row = []
		for vec3 in row:
			serialized_row.append([vec3.x, vec3.y, vec3.z])
		data["Level"].append(serialized_row)
	
	var jstr = JSON.stringify(data)
	
	file.store_line(jstr)

func load_data() -> void:
	var file = FileAccess.open(safePath,FileAccess.READ)
	if not file:
		return
	if file == null:
		return
	if FileAccess.file_exists(safePath) == true:
		if not file.eof_reached():
			var currentLine = JSON.parse_string(file.get_line())
			if (currentLine):
				var serialized_data = currentLine["Level"]
				level.levelData = []
				for serialized_row in serialized_data:
					var row = []
					for vec_data in serialized_row:
						var x = int(vec_data[0])
						var y = int(vec_data[1])
						var z = int(vec_data[2])
						row.append(Vector3i(x, y, z))
					level.levelData.append(row)
				
				level._load_full_level()

func _input(event):
	if(Input.is_action_just_pressed("Load")):
		load_data()
	if(Input.is_action_just_pressed("Save")):
		save()
