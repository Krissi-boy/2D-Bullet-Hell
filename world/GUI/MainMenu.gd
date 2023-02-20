extends Node2D

func _ready():
	$BackgroundMusic.play()

func _on_QuitButton_pressed():
	get_tree().quit()


func _on_NewButton_pressed():
	ButtonPlayerSound.play()
	get_tree().change_scene("res://world/World.tscn")
	
	
func _on_ShopButton_pressed():
	ButtonPlayerSound.play()
	get_tree().change_scene("res://world/GUI/Shop.tscn")
