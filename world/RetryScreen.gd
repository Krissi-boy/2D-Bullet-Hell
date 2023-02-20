extends Control


func _on_RetryButton_pressed():
	ButtonPlayerSound.play()
	get_tree().change_scene("res://world/World.tscn")


func _on_ShopButton_pressed():
	ButtonPlayerSound.play()
	get_tree().change_scene("res://world/GUI/Shop.tscn")


func _on_MenuButton_pressed():
	ButtonPlayerSound.play()
	get_tree().change_scene("res://world/GUI/MainMenu.tscn")
