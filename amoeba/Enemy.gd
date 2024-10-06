extends CharacterBody2D
class_name Enemy

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	var dist = self.global_position.distance_to(get_node("/root/game/Player").global_position)
	var radius = get_viewport().size.x
	if dist > radius * 1.5:
		var angle = randf() * 360
		var dir = Vector2.from_angle(angle)
		var spawnLocation = get_node("/root/game/Player/Camera2D").global_position + dir * radius
		self.global_position = spawnLocation
