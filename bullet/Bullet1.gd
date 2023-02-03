extends Area2D

export var speed: float = 500
export var harm = 2

onready var move_vector = Vector2(0,0)

func set_vector(vector):
	move_vector = vector

func _physics_process(delta):
	position += move_vector * speed * delta
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Bullet_body_entered(body):
	print("Bullet_body_entered: ", body, ", groups: ", body.get_groups())
	if body.is_in_group("player"): ## Collision with player
		queue_free()

func _on_Bullet_area_entered(_area):
	pass
