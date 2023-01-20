extends CanvasLayer

signal transitioned

func transition():
	$AnimationPlayer.play("fade_black")
	print("Fading to black")
	

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_black":
		print("Emit signal transitioned")
		emit_signal("transitioned")
		$AnimationPlayer.play("RESET")
		
	if anim_name == "RESET":
		print("Finished fading")
		
