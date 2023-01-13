extends KinematicBody2D
var motion = Vector2()
const UP = Vector2(0, -1)

var SPEED = 180
var FIRE_START = true
var FIRE_STOP = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta): # delta er standard for 60 FPS
	if Input.is_action_pressed("play"):
		$Fire.visibilty = FIRE_START
		
	elif Input.is_action_just_released("cancel"):
		$Fire.visibilty = FIRE_STOP
		
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
	

		
				

	

