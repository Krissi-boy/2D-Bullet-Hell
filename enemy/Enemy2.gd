extends Area2D

const death_effect_scene = preload("res://effect/EnemyDeathEffect.tscn")
const bullet_scene = preload("res://bullet/Bullet2.tscn")
onready var world = $".."

export var vertical_speed := 100
export var max_health: int = 5
export var health: int = max_health
export var harm = 2 # Damage the enemy does to others on contact (not projectile damage)

## Bullet shooting related variables
onready var shoot_timer = $ShootTimer
onready var shot_rotator = $Rotator
export var shot_rotate_speed = 300
export var shoot_timer_wait = 0.13
export var shot_spawn_count = 4 # Does not work; always only spawns 1 (?)
export var shoot_radius = 40
export var shoot_interval = 0.1

func _ready():
	$ProgressBar.value = health
	var step = 2 * PI / shot_spawn_count
	
	## Spawn point for bullet shots
	for i in range(shot_spawn_count):
		var spawn_point = Node2D.new()
		var pos = Vector2(shoot_radius, 0).rotated(step * 1)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		shot_rotator.add_child(spawn_point)
	
	shoot_timer.wait_time = shoot_timer_wait
	shoot_timer.start()

## When shoot_interval for the shoot_timer is up this runs
func _on_ShootTimer_timeout():
	for s in shot_rotator.get_children():
		var bullet = bullet_scene.instance()
		get_tree().root.add_child(bullet)
		bullet.position = s.global_position
		bullet.rotation = s.global_rotation # Rotates to match angle

func _physics_process(delta):
#	position.y += vertical_speed * delta
	var new_rotation = shot_rotator.rotation_degrees + shot_rotate_speed * delta
	shot_rotator.rotation_degrees = fmod(new_rotation, 360)

## Enemy getting damaged
func damage(amount: int):
	health -= amount
	$ProgressBar.value = health
	if health <= 0:
		health = 0
		print(self, " died")
		## Enemy death effect animation
		var death_effect = death_effect_scene.instance()
		get_parent().add_child(death_effect)
		death_effect.global_position = global_position
		queue_free()

#func shoot():
#	var bullet_instance = bullet_scene.instance()
#	bullet_instance.global_position = global_position
#	world.add_child(bullet_instance)
##	bullet_instance.set_vector(shoot_vector)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

## Enemy collisions
func _on_Enemy_area_entered(area):
	print("Enemy_area_entered: ", area)
	
	if area.is_in_group("player_bullet"): ## Collision with players bullet
		damage(area.harm) ## Damages enemy (self) with bullets (area) harm
		print("enemy hit by player bullet")
		print("bullet harm: ", area.harm, ", enemy health: ", health)
		area.queue_free()

func _on_Enemy_body_entered(body):
	print("Enemy_body_entered: ", body)
	
	if body.is_in_group("player"): ## Collision with player
		body.damage(harm) ## Damages player (body) with enemys harm
		self.damage(body.harm) ## Damages enemy (self) with players (body) harm
		print("collision with player")
		print("enemy harm: ", harm, ", player health: ", body.health)
		print("player harm: ", body.harm, ", enemy health: ", health)
