extends KinematicBody2D
var motion = Vector2()
const UP = Vector2(0, -1)

var SPEED = 15
var FIRE_START = true
var FIRE_STOP = false
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
		

func _physics_process(delta): # delta er standard for 60 FPS
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if Input.is_action_pressed("ui_up"):
		yield(get_tree().create_timer(0.15), "timeout")
		$Fire3.visible = FIRE_START
		$Fire4.visible = FIRE_START
		

	
	if Input.is_action_pressed("ui_right"):
		position.x+=SPEED
		$Fire2.visible = FIRE_START
		
	if Input.is_action_pressed("ui_left"):
		position.x-=SPEED
		$Fire1.visible = FIRE_START
		
	
	
		
	elif Input.is_action_just_released("ui_cancel"):
		pass
		
	if Input.is_action_pressed("ui_right"):
		motion.x =+ SPEED
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = false
		
		
	elif Input.is_action_pressed("ui_left"):
		motion.x =- SPEED
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = true 
		
	else:
		$AnimatedSprite.play("idle")
		$Fire1.visible = FIRE_STOP
		$Fire2.visible = FIRE_STOP

	

		
func timeout(time):
	yield(get_tree().create_timer(time), "timeout")
	
	$Fire1.visible = FIRE_START
	$Fire2.visible = FIRE_START
	
	$Fire1.visible = FIRE_STOP
	$Fire2.visible = FIRE_STOP
	pass # Replace with function body.
