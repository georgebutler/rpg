extends Node
class_name CameraManager

const CAMERA_FOLLOW_SPEED = 30

onready var CameraRoot : Spatial = get_node("CameraRoot")
onready var CameraPivot : Spatial = get_node("CameraRoot/CameraPivot")
onready var MainCamera : Camera = get_node("CameraRoot/CameraPivot/SpringArm/Camera")

func _physics_process(delta) -> void:
	if Game.character:
		CameraRoot.global_transform.origin = CameraRoot.global_transform.origin.linear_interpolate(Game.character.global_transform.origin + Vector3(0, 0.5, 0), CAMERA_FOLLOW_SPEED * delta)

func add_pitch(amount: float) -> void:
		CameraPivot.set_rotation(Vector3.RIGHT * clamp(CameraPivot.get_rotation().x + amount * get_process_delta_time(), deg2rad(-70), deg2rad(70)))

func add_yaw(amount: float) -> void:
		CameraRoot.rotate_object_local(Vector3.UP, amount * get_process_delta_time())
