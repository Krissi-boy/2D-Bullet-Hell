extends Area2D
const UP = Vector2(0, -1)


var screen_size = get_viewport_rect().size
var rng_x = RandomNumberGenerator.new()





func _ready():
	pass # Replace with function body.

func _physics_process(delta): # delta er standard for 60 FPS
	position.y += 2 #beveg nedover (position.y)
	
	var x = rng_x.randi_range(-1, 1)
	position.x 
	

	
func _on_Speed_up_body_entered(body):
	if body.is_in_group("player"):
		body.speed_on = true 
		body.set_speed(10)
		queue_free()
		
		
		


func _on_Timer_timeout():
	pass # Replace with function body.
