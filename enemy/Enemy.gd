extends Area2D

const death_effect = preload("res://effect/EnemyDeathEffect.tscn")

export var vertical_speed := 100
export var max_health: int = 5
export var health: int = max_health
export var harm = 2 ## Damage the enemy does to others on contact (not projectile damage)

func _ready():
	$ProgressBar.value = health

func _physics_process(delta):
	position.y += vertical_speed * delta

## Enemy getting damaged
func damage(amount: int):
	health -= amount
	$ProgressBar.value = health
	if health <= 0:
		health = 0
		print(self, " died")
		var enemyDeathEffect = death_effect.instance()
		get_parent().add_child(enemyDeathEffect)
		enemyDeathEffect.global_position = global_position

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

## Enemy collisions
func _on_Enemy_area_entered(area):
	print("Enemy_area_entered: ", area)
	
	if area.is_in_group("player_bullet"): ## Collision with players bullet
		self.damage(area.harm) ## Damages enemy (self) with bullets (area) harm
		print("enemy hit by player bullet")
		print("bullet harm: ", area.harm, ", enemy health: ", health)
		
		## Possible effect base
#		var bulletEffect := BulletEffect.instance()
#		bulletEffect.position = position
#		get_parent().add_child(bulletEffect)

func _on_Enemy_body_entered(body):
	print("Enemy_body_entered: ", body)
	
	if body.is_in_group("player"): ## Collision with player
		body.damage(self.harm) ## Damages player (body) with enemys harm
		self.damage(body.harm) ## Damages enemy (self) with players (body) harm
		print("collision with player")
		print("enemy harm: ", self.harm, ", player health: ", body.health)
		print("player harm: ", body.harm, ", enemy health: ", self.health)
