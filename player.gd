
	
extends CharacterBody2D

@export var speed: float = 300.0
@export var speedMax: float = 300.0
@export var speedSprint: float = 450.0
var health: float = 100.0
@export var healthMax: float = 100.0
@export var staminaMax: float = 100.0
var stamina: float = 100.0
var running: bool = false
var regen: bool = false
var regenPercent: float = 10
signal stamina_changed(current_value, max_value)
signal health_changed(current, max)
var isDead: bool = false 
var current_interactable = null



signal regen_state_changed(is_regenerating: bool)
var was_regenerating: bool = false

func _ready() -> void:
	health_changed.emit(health, healthMax)
	print("sent")

func take_damage(damage: float) -> void:
	health -= damage
	health_changed.emit(health, healthMax)
	if health <= 0:
		isDead = true
		#Handle death !!!! IMPORTANT !!!!


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		if current_interactable:
			current_interactable.interact()

func _on_interaction_area_area_entered(area: Area2D) -> void:
	print(area)
	if area.has_method("interact"):
		print("Succeed ", area)
		current_interactable = area
		
func _on_interaction_area_area_exited(area: Area2D) -> void:
	if current_interactable == area:
		current_interactable = null

func _physics_process(_delta: float) -> void:
	#health_changed.emit(health, healthMax)

	if stamina < regenPercent:
		regen = true
	if stamina < 0:
		speed = speedMax
		running = false
	
	if running:
		
		stamina -= 0.5
		stamina_changed.emit(stamina, staminaMax)
	if not running:
		if (stamina + 0.5) <= staminaMax:
			
			stamina += 0.5
			stamina_changed.emit(stamina, staminaMax)

	if stamina >= staminaMax:
		regen = false
	#var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := Input.get_vector("movement_left", "movement_right", "movement_up", "movement_down")
	
	if direction != Vector2.ZERO:
		velocity = direction * speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, speed * 0.2)
		
	if regen != was_regenerating:
		regen_state_changed.emit(regen)
		was_regenerating = regen
	move_and_slide()
	
	



func _input(event: InputEvent) -> void:
	if event.is_action_pressed("sprint"):
		if not regen:
			if stamina > 0:
				speed += 150.0
				running = true
			
			
	
	if event.is_action_released("sprint"):
		speed = speedMax
		running = false
		
