extends MarginContainer

@onready var main_menu_layout: HBoxContainer = $HBoxContainer
@onready var options_panel: Panel = $Panel
@onready var volume_slider: HSlider = $Panel/VBoxContainer/HBoxContainer/HSlider
var bus_index: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_menu_layout.show()
	options_panel.hide()
	bus_index = AudioServer.get_bus_index("Master")
	var current_db = AudioServer.get_bus_volume_db(bus_index)
	volume_slider.value = db_to_linear(current_db)

func _on_options_button_pressed() -> void:
	main_menu_layout.hide()
	options_panel.show()
	
func _on_back_button_pressed() -> void:
	main_menu_layout.show()
	options_panel.hide()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_h_slider_value_changed(value: float) -> void:
	print("Slider Value: ", value)
	var db_value = linear_to_db(value)
	AudioServer.set_bus_volume_db(bus_index, db_value)


func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_file("res://master.tscn")
	
