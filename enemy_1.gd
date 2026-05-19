extends CharacterBody2D


@export var speed: float = 150.0
@export var attack_range: float = 40.0
@export var attack_cooldown: float = 1.0
@export var monster_damage: float = 10.0

var can_attack: bool = true
var player: CharacterBody2D = null


func _physics_process(delta: float) -> void:
	if player != null:
		var distance_to_character = global_position.distance_to(player.global_position)
		if distance_to_character > attack_range:
			#follow
			var direction = global_position.direction_to(player.global_position)
			velocity = direction * speed
		else:
			#attack
			velocity = Vector2.ZERO
			if can_attack:
				_attack()
	else:
		velocity = velocity.move_toward(Vector2.ZERO, speed * 0.1)
		
	move_and_slide()
	
func _attack() -> void:
	can_attack = false
	print("attacking ", player, " with ", self)
	#Play animation
	player.take_damage(monster_damage)
	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true
	
func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		
func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player = null
