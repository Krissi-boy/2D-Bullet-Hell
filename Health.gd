extends Area2D
const UP = Vector2(0, -1)



var screen_size = get_viewport_rect().size
#var player = get_parent().get_node("Player1")
var rng_x = RandomNumberGenerator.new()



func _ready():
	pass
	
	
func _physics_process(delta): # delta er standard for 60 FPS
	position.y += 1 #beveg nedover (position.y)
	
	var x = rng_x.randi_range(-1, 1)
	position.x -= 1

	
	
func _on_Health_up_body_entered(body):
	$health_pickup_effect.play()
	body.health = body.max_health 
	print(body.health)
	queue_free()
