extends Area2D
const UP = Vector2(0, -1)

var screen_size = get_viewport_rect().size
var rng_x = RandomNumberGenerator.new()

func _ready():
	pass
	
func _physics_process(delta): # delta er standard for 60 FPS
	position.y += 1 #beveg nedover (position.y)
	
	var x = rng_x.randi_range(-1, 1)
	position.x 
	

func _on_Shield_up_body_entered(body):
	if body.is_in_group("player"):
		body.shield_on = true
		body.set_shield()
		queue_free()
		
		
		
