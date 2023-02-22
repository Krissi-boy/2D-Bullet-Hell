extends Area2D
const UP = Vector2(0, -1)


var screen_size = get_viewport_rect().size
var rng_x = RandomNumberGenerator.new()
onready var timer := $Timer




func _ready():
	pass # Replace with function body.

func _physics_process(delta): # delta er standard for 60 FPS
	position.y += 1 #beveg nedover (position.y)
	
	var x = rng_x.randi_range(-10, 1)
	position.x += 1
	
	
func _on_Speed_up_body_entered(body):
	queue_free()
	if body.is_in_group("player"):
		$speed_sound_effect.play()
		body.speed_on = true 
		body.set_speed(20)
		
