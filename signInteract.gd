extends Area2D

@export_multiline var interaction_text: String = "Text Default"
@export var interact_id: String = "id"

func interact() -> void:
	print("Displaying ", self)
	#UI
	NavigationManagement.request_dialogue.emit(interaction_text)
