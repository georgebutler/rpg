extends Node
class_name InputManager

const MOUSE_SENSITIVITY = 0.2

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _physics_process(_delta) -> void:
	if not Game.character == null:
		var movement_input = Vector3()
		
		movement_input.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		movement_input.z = Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
		
		Game.character.add_movement(movement_input)
		
		if Input.is_action_just_pressed("jump"):
			Game.character.jump()

func _input(event) -> void:
	if event is InputEventMouseMotion:
		Game.CameraManager.add_yaw(-event.relative.x * MOUSE_SENSITIVITY)
		Game.CameraManager.add_pitch(-event.relative.y * MOUSE_SENSITIVITY)
	
	if Input.is_action_just_pressed("ui_end"):
		Game.spawn()
		
	if Input.is_action_just_pressed("ui_cancel"):
		Game.quit()
