extends Area2D

export var speed: float = 500
export var harm = 2

func _physics_process(delta):
	position.y -= speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
