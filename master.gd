extends Node2D

@onready var level_container: Node2D = $LevelContainer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player: CharacterBody2D = $Player
@onready var hud: CanvasLayer = $HUD
var current_level: Node2D = null
var cameraInstance: Camera2D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.stamina_changed.connect(hud.update_stamina)
	hud.update_stamina(player.stamina, player.staminaMax)
	player.regen_state_changed.connect(hud.regen_state_changed)
	player.health_changed.connect(hud.update_health)
	hud.update_health(player.health, player.healthMax)
	
	
	
	NavigationManagement.level_change_requested.connect(_on_level_change_requested)
	_on_level_change_requested("res://levels/main_world.tscn", "Spawn_Start")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_level_change_requested(level_path: String, spawn_point_id: String) -> void:
	if Global.camera:
		cameraInstance = Global.camera
	if animation_player.has_animation("fade_out"):
		animation_player.play("fade_out")
		await animation_player.animation_finished
	if current_level:
		current_level.queue_free()
	var new_level_packed = load(level_path)
	#print(new_level_packed)
	if new_level_packed:
		current_level = new_level_packed.instantiate()
		level_container.add_child(current_level)
		
			
	var spawn_node = current_level.find_child(spawn_point_id)
	if spawn_node:
		#cameraInstance.position = spawn_node.global_position
		cameraInstance.position_smoothing_enabled = false
		player.global_position = spawn_node.global_position
		cameraInstance.position_smoothing_enabled = true

		

	else: 
		print("No spawn point ", spawn_point_id, spawn_node)
		cameraInstance.position_smoothing_enabled = false

		#cameraInstance.position = Vector2.ZERO
		player.global_position = Vector2.ZERO
		cameraInstance.position_smoothing_enabled = true

	animation_player.play("fade_in")
