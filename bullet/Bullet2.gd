extends Area2D

export var speed = 100
export var harm = 5

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Bullet_body_entered(body):
	print("Bullet_body_entered: ", body, ", groups: ", body.get_groups())
	if body.is_in_group("player"): # Collision with player
		body.damage(harm)
		queue_free()

func _on_Bullet_area_entered(_area):
	pass

func _on_KillTimer_timeout():
	queue_free()
