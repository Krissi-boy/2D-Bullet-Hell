extends Area2D

signal shooting

const death_effect_scene = preload("res://effect/EnemyDeathEffect.tscn")
const bullet_scene = preload("res://bullet/Bullet1.tscn")

export var vertical_speed := 100
export var max_health: int = 5
export var health: int = max_health
export var harm = 2 ## Damage the enemy does to others on contact (not projectile damage)
onready var world = $".."
onready var shoot_vector = Vector2(1,1)
export var shoot_interval = 0.1
var timer = Timer.new()

func _ready():
	$ProgressBar.value = health
	## Timer wip
	timer.wait_time = shoot_interval
	timer.start()

func _physics_process(delta):
	position.y += vertical_speed * delta
	$Aiming.rotation_degrees += 1
	shoot()
	
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

func shoot():
	var bullet_instance = bullet_scene.instance()
	shoot_vector = $Aiming/Position2D.global_position - global_position
	shoot_vector.normalized()
	bullet_instance.global_position = $Aiming/Position2D.global_position
	world.add_child(bullet_instance)
	bullet_instance.set_vector(shoot_vector)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

## Enemy collisions
func _on_Enemy_area_entered(area):
	print("Enemy_area_entered: ", area, ", groups: ", area.get_groups())
	
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
