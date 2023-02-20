extends Node2D

var fighter_scene = preload("res://enemy/Fighter.tscn")
var ufo_scene = preload("res://enemy/Ufo.tscn")

onready var spawn_timer = $EnemySpawnTimer

var enemy_preload = fighter_scene # The enemy that will be spawned # Should be based on something
var next_spawn_time = 5.0

func _ready():
	randomize()
	spawn_timer.start(next_spawn_time)

func _on_EnemySpawnTimer_timeout():
	# Spawn the enemy
	var view_rect = get_viewport_rect()
	var x_pos = rand_range(view_rect.position.x, view_rect.end.x)
	var enemy = enemy_preload.instance()
	enemy.position = Vector2(x_pos, position.y)
	get_tree().current_scene.add_child(enemy)
	
	# Restart the timer
	spawn_timer.start(next_spawn_time)
