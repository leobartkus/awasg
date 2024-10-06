extends Sprite2D

var original_pos : Vector2
var v : Vector2 = Vector2(randf() * 2 - 1, randf() * 2 - 1)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	original_pos = self.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += v * delta * 10
	if position.distance_to(original_pos) > 10:
		v = Vector2(randf() * 2 - 1, randf() * 2 - 1)
