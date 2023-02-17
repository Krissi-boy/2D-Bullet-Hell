extends Label

var score = 0

func update_score(score):
	$ScoreLabel.text = str(score)
	
	
	
#func new_game():
#	score = 0
#	$ScoreTimer.start()
#
#func game_over():
#	$ScoreTimer.stop()
#
#func _on_ScoreTimer_timeout():
#	score += 1
#	$UserInterface.update_score(score)
#
