extends Area2D

@export var dir : Vector2 = Vector2(0,0)
@export var SPEED : float = 800

var splat = preload("res://splat.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	var dir = self.global_transform.basis_xform(Vector2(1, 0))
	self.global_position = self.global_position + dir * delta * SPEED
	
	var radius = get_viewport().size.x
	var player = get_node("/root/game/Player")
	if global_position.distance_to(player.global_position) > radius:
		self.queue_free()
	
func _on_body_entered(body: Node2D) -> void:
	
	for c in body.get_children():
		if c is HP_Tracker:
			var HP = c
			HP.take_damage(1)
			var s = splat.instantiate()
			get_node("/root/game/SplatLayer").add_child(s)
			s.get_node("Sprite2D").material.set_shader_parameter("uv", Vector2(0.5 + randf() * 0.2, 0.5 + randf() * 0.2))
			s.get_node("Sprite2D").material.set_shader_parameter("splatsource", body.get_node("./Sprite2D").texture)
			s.global_position = self.global_position
			s.get_node("VelocityMover").velocity = -self.dir * 100
			self.queue_free()
