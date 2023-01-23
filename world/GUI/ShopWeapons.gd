extends Node2D



func _on_CloseButton_pressed():
	get_tree().change_scene("res://world/GUI/MainMenu.tscn")


func _on_Rockets_pressed():
	get_tree().change_scene("res://world/GUI/ShopRockets.tscn")
