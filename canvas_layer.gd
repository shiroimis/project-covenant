extends CanvasLayer
var cameraInstance: Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.camera:
		cameraInstance = Global.camera
		#print(cameraInstance, cameraInstance.position)
		
	else:
		push_error("Error: No camera instantiated")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass
