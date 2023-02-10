extends Node2D

var score = 0


func _ready():
	new_game()
	
func _process(delta):
	pass
	
func update_score(score):
	$ScoreLabel.text = str(score)

func new_game():
	$Midnight.visible = false
	$Space.visible = false
	score = 0
	$ScoreTimer.start()

func game_over():
	$ScoreTimer.stop()

func _on_ScoreTimer_timeout():
	score += 1
	update_score(score)
	if score == 500:
		$Clouds/CloudLayer/AnimationPlayer.play("fade_out")
		$Midnight/MidnightLayer/AnimationPlayer.play("fade_in")
		
		$Midnight.visible = true
	
