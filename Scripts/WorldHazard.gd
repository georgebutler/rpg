extends Area
class_name WorldHazard

func _on_WorldHazard_body_entered(_body) -> void:
	Game.spawn()
