extends Node

var rate : float = 100 * randf() - 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().global_rotation_degrees = randf() * deg_to_rad(360)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	get_parent().global_rotation_degrees += rate * delta
	pass
