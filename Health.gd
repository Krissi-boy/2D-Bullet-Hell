extends Area2D
const UP = Vector2(0, -1)



var screen_size = get_viewport_rect().size
#var player = get_parent().get_node("Player1")

 


func _ready():
	pass
	
	
func _physics_process(delta): # delta er standard for 60 FPS
	pass
	#beveg nedover (position.y)
	
	
func _on_Health_up_body_entered(body):
	body.health = body.max_health 
	print(body.health)
	queue_free()
