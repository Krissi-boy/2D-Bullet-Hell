extends Node2D


var Laser = preload("res://LaserTag.tscn")
var Health = preload("res://Health.tscn")

func _on_Player1_spawn_laser(location):
	var l = Laser.instance()
	l.global_position = location
	add_child(l)
	



func _on_Power_Ups_spawn_timeout():
	var health_instance = Health.instance()
	health_instance.global_position = Vector2(100, 400)#Gjør denne Vectoren random (skal komme nedover)
	add_child(health_instance)
