extends Node

@export var rate = randf() * 0.3 - 0.15;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	get_parent().transform = get_parent().transform * Transform2D(rate * delta, Vector2(0, 0))
