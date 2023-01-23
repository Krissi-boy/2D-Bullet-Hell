extends Node2D



func _on_QuitButton_pressed():
	get_tree().quit()


func _on_NewButton_pressed():
	get_tree().change_scene("res://world/World.tscn")
	

func _on_ShopButton_pressed():
	get_tree().change_scene("res://world/GUI/ShopWeapons.tscn")
