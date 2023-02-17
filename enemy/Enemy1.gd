extends Area2D

const death_effect_scene = preload("res://effect/EnemyDeathEffect.tscn")
const bullet_scene = preload("res://bullet/Bullet1.tscn")
onready var world = $".."

export var speed = 300
export var max_health: int = 5
export var health: int = max_health
export var harm = 2 ## Damage the enemy does to others on contact (not projectile damage)

## Bullet shooting related variables
onready var shoot_positions = $ShootPositions
onready var shoot_timer = $ShootTimer
export var shoot_timer_wait = 0.5
export var bullet_speed = 100

func _ready():
	$ProgressBar.value = health
	
	shoot_timer.wait_time = shoot_timer_wait
	shoot_timer.start()

func _physics_process(delta):
	position += transform.y * speed * delta

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

## Shoot timer
func _on_ShootTimer_timeout():
	for s in shoot_positions.get_children():
		var bullet = bullet_scene.instance()
		get_tree().root.add_child(bullet)
		bullet.global_position = s.global_position
		bullet.speed = speed + bullet_speed

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
