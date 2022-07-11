extends KinematicBody
class_name Player

const MAX_SPEED = 7
const JUMP_SPEED = 10
const ACCELERATION = 7
const DECELERATION = 6.5

onready var gravity : float = -ProjectSettings.get_setting("physics/3d/default_gravity")
onready var next_jump : float = OS.get_ticks_msec()

var velocity : Vector3
var input_direction : Vector3
var should_jump : bool

func _physics_process(delta) -> void:
	var camera_basis = Game.CameraManager.MainCamera.global_transform.basis
	var basis = camera_basis.rotated(camera_basis.x, -camera_basis.get_euler().x)
	
	input_direction = basis.xform(input_direction)

	if input_direction.length_squared() > 1:
		input_direction /= input_direction.length()

	velocity.y += delta * gravity

	var hvel = velocity
	hvel.y = 0

	var target = input_direction * MAX_SPEED
	var acceleration = 0
	
	if input_direction.dot(hvel) > 0:
		acceleration = ACCELERATION
	else:
		acceleration = DECELERATION

	hvel = hvel.linear_interpolate(target, acceleration * delta)

	velocity.x = hvel.x
	velocity.z = hvel.z
	velocity = move_and_slide(velocity, Vector3.UP)

	if is_on_floor() and should_jump:
		if next_jump <= OS.get_ticks_msec():
			next_jump = OS.get_ticks_msec() + 1000
			velocity.y = JUMP_SPEED
	
	should_jump = false
	input_direction = Vector3()

func jump() -> void:
	should_jump = true

func add_movement(vector : Vector3) -> void:
	input_direction = vector
