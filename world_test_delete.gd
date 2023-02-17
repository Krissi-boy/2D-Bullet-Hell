extends Node2D


var Laser = preload("res://LaserTag.tscn")
var Health = preload("res://Health.tscn")
var Shield = preload("res://Shield.tscn")
var Speed = preload("res://Speed.tscn")

var rng_x = RandomNumberGenerator.new()



func _on_Player1_spawn_laser(location):
	var l = Laser.instance()
	l.global_position = location
	add_child(l)
	



func _on_Power_Ups_spawn_timeout():
	var health_instance = Health.instance()
	var x = rng_x.randi_range(100, 400)
	health_instance.global_position = Vector2(x, -100)#Gjør denne Vectoren random (skal komme nedover)
	add_child(health_instance)
	
	var shield_instance = Shield.instance()
	shield_instance.global_position = Vector2(x, -100)
	add_child(shield_instance)
	
	

	


