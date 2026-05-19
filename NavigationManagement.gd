extends Node


signal request_dialogue(text: String)
signal level_change_requested(level_path: String, spawn_point_id: String)



func go_to_level(level_path: String, spawn_point_id: String) -> void:
	level_change_requested.emit(level_path, spawn_point_id)
