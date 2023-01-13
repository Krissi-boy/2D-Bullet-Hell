extends Area2D

export var vertical_speed := 100
export var health: int = 5

func _physics_process(delta):
	position.y += vertical_speed * delta

## Enemy gets damaged
#func damage(amount: int):
#	health -= amount
#	if health <= 0:
#		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

## When enemy is hit by a bullet
#func _on_Bullet_area_entered(area):
#	if area.is_in_group("enemy"):
#		## Eventual effect base
#		#var bulletEffect := pBulletEffect.instance()
#		#bulletEffect.position = position
#		#get_parent().add_child(bulletEffect)
#
#		area.damage(1)
#		queue_free()
