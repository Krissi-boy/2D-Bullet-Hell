extends Node2D


var Laser = preload("res://LaserTag.tscn")


func _on_Player1_spawn_laser(location):
	var l = Laser.instance()
	l.global_position = location
	add_child(l)
	
