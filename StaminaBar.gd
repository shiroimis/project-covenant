extends CanvasLayer
#FOR ALL NOT JUST STAMINA

@onready var stamina_bar: TextureProgressBar = $StaminaBar
@onready var health_bar: TextureProgressBar = $HealthBar

var flash_tween: Tween

func _ready() -> void:
	stamina_bar.tint_progress = Color.WHITE
	NavigationManagement.request_dialogue.connect(_on_request_dialogue)

func _on_request_dialogue(text: String) -> void:
	$DialogueBox.text = text
	$DialogueBox.visible = true
	
func _exit_dialogue() -> void:
	$DialogueBox.visable = false
	

func update_stamina(current: float, max_stamina: float) -> void:
	stamina_bar.max_value = max_stamina
	stamina_bar.value = current

func update_health(current: float, max_health: float) -> void:
	print("received")
	health_bar.max_value = max_health
	health_bar.value = current
	
func regen_state_changed(is_regen: bool) -> void:
	if is_regen:
		start_flashing()
	else:
		stop_flashing()
func start_flashing() -> void:
	if flash_tween: flash_tween.kill()
	flash_tween = create_tween().set_loops()
	flash_tween.tween_property(stamina_bar, "tint_progress", Color.DARK_RED, 0.2)
	flash_tween.tween_property(stamina_bar, "tint_progress", Color.WHITE, 0.2)



func stop_flashing() -> void:
	if flash_tween:
		flash_tween.kill()
	stamina_bar.tint_progress = Color.WHITE
