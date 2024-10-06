extends Node

var target : CharacterBody2D
var para : CharacterBody2D

var state = "IDLE"
var progress = 0
var turn_speed = 0.01
var max_move = 1
var SPEED = 100

var look_dir = Vector2(1, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target = get_node("/root/game/Player")
	para = get_parent()


func _physics_process(delta: float) -> void:
	if state == "IDLE":
		progress = progress + delta
		if progress > max_move:
			var myDir = para.transform.basis_xform( Vector2(1, 0));
			var tan = para.transform.basis_xform(Vector2(0, 1));
			var lookDir = para.global_position.direction_to(target.global_position)
			
			var dot = tan.dot(lookDir.normalized())
			
			if dot > 0.5:
				state = "PIVOT_LEFT"
				progress = randf() * max_move
			elif dot < -0.5:
				state = "PIVOT_RIGHT"
				progress = randf() * max_move
			elif dot > 0 :
				state = "LEFT"
				progress = randf() * max_move
			else:
				state = "RIGHT"
				progress = randf() * max_move
		
	if state == "PIVOT_LEFT":
		para.transform = para.transform * Transform2D(turn_speed * 2, Vector2(1, 0))
		progress = progress + delta
		if progress > max_move:
			state = "IDLE"
			progress = 0
	if state == "PIVOT_RIGHT":
		para.transform = para.transform * Transform2D(-turn_speed * 2, Vector2(1, 0))
		progress = progress + delta
		if progress > max_move:
			state = "IDLE"
			progress = 0
	if state == "LEFT":
		para.transform = para.transform * Transform2D(turn_speed, Vector2(1, 0))
		para.velocity = para.transform.basis_xform(Vector2(1, 0) * SPEED) 
		para.move_and_slide()
		progress = progress + delta
		if progress > max_move:
			state = "IDLE"
			progress = 0
		
	if state == "RIGHT":
		para.transform = para.transform * Transform2D(-turn_speed, Vector2(1, 0))
		para.velocity = para.transform.basis_xform(Vector2(1, 0) * SPEED) 
		para.move_and_slide()
		progress = progress + delta
		if progress > max_move:
			state = "IDLE"
			progress = 0
		
