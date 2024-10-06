extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0
@export var crosshair : Node2D

@export var spread = 0.5
@export var num_bullets = 10

var bullet = preload("res://bullet.tscn")

var GunSound = preload("res://shoot.wav")

func playNomSound() -> void:
	get_node("NomSoundPlayer").play()
	
func playDedSound() -> void:
	get_node("DedSoundPlayer").play()

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("player_left", "player_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = direction * -SPEED
		
	var updown_direction := Input.get_axis("player_up", "player_down")
	if updown_direction:
		velocity.y = updown_direction * SPEED
	else:
		velocity.y = updown_direction * -SPEED

	if Input.is_key_label_pressed(KEY_ESCAPE):
		get_tree().quit()
	
	$shotgun.look_at(crosshair.global_position)
	
	if Input.is_action_just_pressed("player_shoot"):
		for i in num_bullets:
			var b = bullet.instantiate()
			get_node("/root").add_child(b)
			b.global_transform = $shotgun/tip.global_transform
			b.global_transform = b.global_transform * Transform2D((randf() * spread - spread/2) , Vector2(0, 0 ))
			
			$AudioStreamPlayer2D.play()

	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider() is Enemy:
			get_node("/root/game").AddOopsie(1)
	
