extends Node2D



func _on_CloseButton_pressed():
	ButtonPlayerSound.play()
	get_tree().change_scene("res://world/GUI/MainMenu.tscn")
	


func _on_Rockets_pressed():
	$Shop_UI/ShopRockets.visible = true
	$Shop_UI/ShopWeapons.visible = false
	$Shop_UI/Rockets.modulate = "#C5A8DF"
	$Shop_UI/Weapons.modulate = "#ffffff"
	_play_button_sound()
	

func _on_Weapons_pressed():
	$Shop_UI/ShopRockets.visible = false
	$Shop_UI/ShopWeapons.visible = true
	$Shop_UI/Weapons.modulate = "#C5A8DF"
	$Shop_UI/Rockets.modulate = "#ffffff"
	_play_button_sound()
	


func _play_button_sound():
	$Shop_UI/ButtonSound.play()
	
