extends Control


#if event.is_action_pressed("ui_cancel"):
#	$PauseWindow.visible = true

func _on_PauseButton_pressed():
	$PauseWindow.visible = true
	

func _on_RetryButton_pressed():
	get_tree().change_scene("res://world/World.tscn")


func _on_MenuButton_pressed():
	get_tree().change_scene("res://world/GUI/MainMenu.tscn")


func _on_CloseButton_pressed():
	$PauseWindow.visible = false


func _on_ShopButton_pressed():
	get_tree().change_scene("res://world/GUI/Shop.tscn")
