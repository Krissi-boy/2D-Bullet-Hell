extends KinematicBody2D
const UP = Vector2(0, -1)
signal spawn_laser(location)
onready var timer := $Timer

var SPEED = 7
var FIRE_START = true
var FIRE_STOP = false
var screen_size


var shield_on = false 
var speed_on = true


export var max_health = 5
export var health: int = max_health
export var harm = 2 ## Damage the player does to others on contact (not projectile damage)
export var FRICTION = 50
export var ACCELERATION = 30

var lasertag = preload ("res://LaserTag.tscn")
onready var BULLET_POSITION = $BulletPosition

enum {
	MOVING,
	IDLE
}

var state = MOVING

onready var player = get_node(".")
onready var fire1 = $Fire1
onready var fire2 = $Fire2
onready var fire3 = $Fire3
onready var fire4 = $Fire4

var velocity = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
		

func _physics_process(delta): # delta er standard for 60 FPS
	match state:
		MOVING:
			move_state(delta)
		IDLE:
			pass
		
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	

	if Input.is_action_pressed("fire"):
		if timer.is_stopped(): 
			emit_signal("spawn_laser", BULLET_POSITION.global_position)
			timer.start(0.5)


func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO: # hvis velocity ikke er 0, movement 
		velocity = velocity.move_toward(input_vector * SPEED, ACCELERATION * delta)
	
	else:  # idle
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	if input_vector.x == 1:
		fire2.visible = FIRE_START # Når høyre knapp trykkes, vil AnimatedSprite (Fire2) vises (true) 
		$AnimatedSprite.play("run")
		player.rotation_degrees = 10
		
	elif input_vector.x == -1:
		fire1.visible = FIRE_START # Når venstre knapp trykkes, vil AnimatedSprite (Fire1) vises (true) 
		$AnimatedSprite.play("run")
		player.rotation_degrees = -10
		
	elif input_vector.y == -1:
		player.rotation_degrees = 0
		fire1.visible = FIRE_START # Når spillet kjøres vil AnimatedSprite (Fire3 og Fire4) vises hele tiden (true) 
		fire2.visible = FIRE_START  
		fire3.visible = FIRE_START
		fire4.visible = FIRE_START
		
	elif input_vector.y == 1:
		player.rotation_degrees = 0
		fire1.visible = FIRE_STOP
		fire2.visible = FIRE_STOP
		fire3.visible = FIRE_STOP
		fire4.visible = FIRE_STOP
		
		
	else:
		player.rotation_degrees = 0
		# Når spillet står til "tomgang", vil AnimatedSprite (Fire1 og Fire2) ikke vises (false)
		fire3.visible = FIRE_START
		fire4.visible = FIRE_START
		
		fire1.visible = FIRE_STOP
		fire2.visible = FIRE_STOP
		
	
	
	
	move_and_collide(velocity)
		
	if Input.is_action_just_released("ui_cancel"):
		pass	

		
func timeout(time):		
	yield(get_tree().create_timer(time), "timeout") 
	# Kode for sette timer. Her skrev jeg "timeout", som jeg kan bruke i en if input, for å refere til denne funksjonen.
	
	fire1.visible = FIRE_START
	fire2.visible = FIRE_START
	
	fire1.visible = FIRE_STOP
	fire2.visible = FIRE_STOP
	# Replace with function body.
	
	
## Player getting damaged
func damage(amount: int): # Når bullets eller noe treffes enemies så kjøres denne hitboxen 
	if shield_on == true:
		pass
	if shield_on == false:
		health -= amount
		
	if health <= 0:
		health = 0
		queue_free()
		print(self, " died") # died blir printet ut når man dør

func set_shield():
	if shield_on == true:
		$ShieldTrans.visible = true
		$Shield_timer.start(10)
	else:
		$ShieldTrans.visible = false
		

func set_speed(speed_up_amount):
	$speed_timer.start(10)
	SPEED = speed_up_amount

	



func _on_Shield_timer_timeout():
	shield_on = false
	set_shield()


func _on_speed_timer_timeout():
	SPEED = 7
