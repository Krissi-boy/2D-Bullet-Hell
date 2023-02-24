extends Node2D


var Laser = preload("res://LaserTag.tscn")
var EnemyFighter = preload("res://enemy/Fighter.tscn")
var EnemyUfo = preload("res://enemy/Ufo.tscn")
var Health = preload("res://Health.tscn")
var Shield = preload("res://Shield.tscn")
var Speed = preload("res://Speed.tscn")

var rng_x = RandomNumberGenerator.new()

var score = 0
var money = 0

func _on_Player1_spawn_laser(location):
	var l = Laser.instance()
	l.global_position = location
	add_child(l)
	print("laserspawn")
	

func _ready():
	new_game()
	
func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		$GameUI/GUI/PauseMode/PauseWindow.visible = true
	
func update_score(score):
	$ScoreLabel.text = str(score)

func new_game():
	$GameWorld/Midnight.visible = false
	$GameWorld/Space.visible = false
	score = 0
	$GameWorld/ScoreTimer.start()

func game_over():
	$GameWorld/ScoreTimer.stop()

func _on_ScoreTimer_timeout():
	score += 1
	update_score(score)
	if score == 500:
		$GameWorld/Clouds/CloudLayer/AnimationPlayer.play("fade_out")
		$GameWorld/Midnight/MidnightLayer/AnimationPlayer.play("fade_in")
		
		$GameWorld/Midnight.visible = true
		
	if score == 1500:
		$GameWorld/Midnight/MidnightLayer/AnimationPlayer.play("fade_out")
		$GameWorld/Space/SpaceLayer/AnimationPlayer.play("fade_in")
		
		$GameWorld/Space.visible = true
	
	

func _on_Power_Ups_spawn_timeout():
	var health_instance = Health.instance()
	var x = rng_x.randi_range(200, 700)
	health_instance.global_position = Vector2(x, -2000)#Gjør denne Vectoren random (skal komme nedover)
	add_child(health_instance)
	
	var shield_instance = Shield.instance()
	var xx = rng_x.randi_range(500, 600)
	shield_instance.global_position = Vector2(xx, -1000)
	add_child(shield_instance)
	
	var speed_instance = Speed.instance()
	var xxx = rng_x.randi_range(300, 100)
	speed_instance.global_position = Vector2(xxx, -2500)
	add_child(speed_instance)

