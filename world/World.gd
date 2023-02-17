extends Node2D


var Laser = preload("res://LaserTag.tscn")
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
	
	
func _paused():
	pass
	#$GameWorld/ScoreTimer.stop()
