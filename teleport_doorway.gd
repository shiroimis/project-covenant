extends Area2D

@export_file("*.tscn") var target_scene: String
@export var target_spawn_id: String = "Entrance_Marker"


# Called when the node enters the scene tree for the first time.
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") or body.name == "Player":
		print("DEBUG: Entering: ", target_scene, " With spawn id: ", target_spawn_id)
		if target_scene != "":
			print("Success")
			NavigationManagement.go_to_level(target_scene, target_spawn_id)
		
