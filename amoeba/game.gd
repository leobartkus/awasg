extends Node2D

var v  = preload("res://virus.tscn")
var a = preload("res://algae.tscn")
var p = preload("res://para.tscn")

var total_seconds = 300


var timeline = []
var total_noms = 0;
var total_kills =0;
var total_oopsies = 0;

func AddOopsie(i:int):
	total_oopsies +=1
	%OopsLabel.text = str(total_oopsies)

func AddKill(i:int):
	total_kills += i
	get_node("/root/game/Player").playDedSound()

func UpdateNom(i:int):
	total_noms += i
	%NomCountLabel.text = "%d" % total_noms
	get_node("/root/game/Player").playNomSound()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_random(v, 5)

	timeline = [
		[300,p,5],
		[295,a,3],
		[290,p,20],
		[285,v,5],
		[280,v,5],
		[275,a,5],
		[270,p,20],
		[265,v,10],
		[260,v,1],
		[259,v,1],
		[258,v,1],
		[257,v,1],
		[256,v,1],
		[255,v,1],
		[254,v,1],
		[253,v,1],
		[252,v,1],
		[252,v,1],
		[240,p,50],
		[230,a,20],
		[220,v,30],
		[210,a,20],
		[200,v,30],
		[190,p,30],
		[180,p,30],
		[170,p,30],
		[150,v,20],
		[140,v,5],
		[130,a,10],
		[120,v,5],
		[110,p,30],
		[100,a,50],
		[70,v,100],
		[50,p,100]
		
	]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var original_seconds = total_seconds
	total_seconds = total_seconds - delta
	
	var minutes : int = floor(total_seconds / 60);
	var seconds : int = total_seconds - minutes * 60
	
	var secstr= "%02d" % seconds
	
	%TimeLabel.text = "{min}:{secstr}".format({"min":minutes, "secstr":secstr})
	
	if timeline.size() > 0 && timeline[0][0] > total_seconds:
		spawn_random(timeline[0][1], timeline[0][2])
		timeline.remove_at(0)
	
	if total_seconds < 0:
		%winlabel.visible = true
		%winlabel.text = %winlabel.text.format({"k":str(total_kills), "n":str(total_noms), "o":str(total_oopsies)})

func spawn_random( enemy_rsc: Resource, count: int):
	var radius = get_viewport().size.y + 200
	for i in count:
		var angle = randf() * 360
		var dir = Vector2.from_angle(angle)
		var spawnLocation = %Camera2D.global_position + dir * radius
		var e = enemy_rsc.instantiate()
		get_node("/root/game").add_child(e)
		e.global_position = spawnLocation
