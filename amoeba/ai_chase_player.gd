extends Node2D

@export var SPEED: float = 100

var node : CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	node = self.get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	var dir = get_parent().position.direction_to(get_node("/root/game/Player").position)
	node.velocity = dir * SPEED;
	node.move_and_slide()
