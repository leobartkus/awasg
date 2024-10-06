extends Node
class_name HP_Tracker

@export var HP = 10
@export var noms = 2

var flash = 0.0;
var flash_fade = 5;
var ded = false;

var nom = preload("res://nom.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var flashColor = Color(Color.WHITE, flash);
	get_parent().get_node("Sprite2D").material.set_shader_parameter("solid_color", flashColor)


func take_damage(damage: int) -> void:
	HP = HP - damage
	
	flash = 1.0;
	var flashColor = Color(Color.WHITE, flash);
	
	get_parent().get_node("Sprite2D").material.set_shader_parameter("solid_color", flashColor)
	
	if HP < 0:
		if !ded:
			get_node("/root/game").AddKill(1)
			for i in noms:
				var n = nom.instantiate()
				get_node("/root/game/NomLayer").add_child(n)
				n.global_position = get_parent().global_position;
				n.get_node("VelocityMover").velocity = Vector2(randf() * 10, randf() * 10)
			for c in get_parent().get_children():
				if c is NomSpawner:
					var n = nom.instantiate()
					get_node("/root/game/NomLayer").add_child(n)
					n.global_position = c.global_position;
					n.get_node("VelocityMover").velocity = Vector2(randf() * 10, randf() * 10)
		ded = true
		get_parent().queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if flash > 0.0:
		flash = flash - flash_fade * delta
		flash = max(flash, 0.0)
		var flashColor = Color(Color.WHITE, flash);
		get_parent().get_node("Sprite2D").material.set_shader_parameter("solid_color", flashColor)
