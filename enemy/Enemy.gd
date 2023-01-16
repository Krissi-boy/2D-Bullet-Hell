extends Area2D

export var vertical_speed := 100
export var health: int = 5

func _physics_process(delta):
	position.y += vertical_speed * delta

## Enemy gets damaged
func damage(amount: int):
	health -= amount
	if health <= 0:
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

## Enemy is hit by a bullet
#func _on_Bullet_area_entered(area):
#	if area.is_in_group("enemy"):
#		## Eventual effect base
#		#var bulletEffect := pBulletEffect.instance()
#		#bulletEffect.position = position
#		#get_parent().add_child(bulletEffect)
#
#		area.damage(1)
#		queue_free()

## Player collides with enemy
func _on_Enemy_area_entered(area):
	print("Enemy_area_entered")
	if area.is_in_group("player"):
		queue_free()
		
	if area.is_in_group("bullet"):
		## Plan: When hit by bullet have enemy be damaged based on a damage amount for the bullet
		queue_free()
