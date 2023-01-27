extends Node2D
var motion = Vector2()
const UP = Vector2(0, -1)

var SPEED = 10
var LASER_OFF = false 
var LASER_ON = true

func _ready():
	pass

func _physics_process(delta): # delta er standard for 60 FPS

	
	if Input.is_action_pressed("ui_up"):
		yield(get_tree().create_timer(0.15), "timeout") 
		$BulletsLaser/laser1.visible = LASER_ON
		
		
	
func timeout(time):pass
# yield(get_tree().create_timer(time), "timeout")
# Kode for sette timer. Her skrev jeg "timeout", som jeg kan bruke i en if input, for å refere til denne funksjonen.
