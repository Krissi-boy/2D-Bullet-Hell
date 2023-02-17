extends Area2D

export var LASER_SPEED = 500
export var harm = 5

func _process(delta):
	position.y -= LASER_SPEED * delta
	print("moving")

func _on_LaserTag_area_entered(area):
	if area.is_in_group("enemy"):
		area.damage(harm)
		queue_free()
		
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
