extends Area2D
const UP = Vector2(0, -1)


var screen_size = get_viewport_rect().size
var rng_x = RandomNumberGenerator.new()
onready var timer := $Timer




func _ready():
	pass # Replace with function body.

func _physics_process(delta): # delta er standard for 60 FPS
	position.y += 3 #beveg nedover (position.y)
	
	var x = rng_x.randi_range(-1, 1)
	position.x = x
	
	
func _on_Speed_up_body_entered(body):
	timer.start(10)
	if body.is_in_group("player"):
		body.SPEED = 15



func _on_Timer_timeout(body):
	body.SPEED = body.set_speed
