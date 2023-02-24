extends Control



func _on_PauseButton_pressed():
	ButtonPlayerSound.play()
	$PauseWindow.visible = true
	

func _on_RetryButton_pressed():
	ButtonPlayerSound.play()
	get_tree().change_scene("res://world/Game.tscn")


func _on_MenuButton_pressed():
	ButtonPlayerSound.play()
	get_tree().change_scene("res://world/GUI/MainMenu.tscn")


func _on_CloseButton_pressed():
	ButtonPlayerSound.play()
	$PauseWindow.visible = false


func _on_ShopButton_pressed():
	ButtonPlayerSound.play()
	get_tree().change_scene("res://world/GUI/Shop.tscn")
