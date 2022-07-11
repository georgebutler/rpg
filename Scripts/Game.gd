extends Node

export var CharacterScene : PackedScene

onready var CameraManager : CameraManager = get_node("CameraManager")
onready var InputManager : InputManager = get_node("InputManager")

var character : Node

func _ready() -> void:
	call_deferred("spawn")

func spawn() -> void:
	if not character == null:
		character.queue_free()

	character = CharacterScene.instance()
	add_child(character)
	character.global_transform.origin = Vector3(0, 3, 0)
	
func quit() -> void:
	get_tree().quit()
