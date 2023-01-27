extends KinematicBody2D
const UP = Vector2(0, -1)

var SPEED = 7
var FIRE_START = true
var FIRE_STOP = false
var screen_size

export var max_health = 5
export var health: int = max_health
export var harm = 2 ## Damage the player does to others on contact (not projectile damage)

enum {
	MOVING,
	IDLE
}

var state = IDLE

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
			pass
		IDLE:
			pass
		
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
			
	if Input.is_action_pressed("ui_up"):
		#yield(get_tree().create_timer(0.15), "timeout") 
		velocity.y -= SPEED
		player.rotation_degrees = 0
		fire1.visible = FIRE_START # Når spillet kjøres vil AnimatedSprite (Fire3 og Fire4) vises hele tiden (true) 
		fire2.visible = FIRE_START  
		fire3.visible = FIRE_START
		fire4.visible = FIRE_START		
		
	elif Input.is_action_pressed("ui_down"):
		#yield(get_tree().create_timer(0.15), "timeout") 
		velocity.y += SPEED
		player.rotation_degrees = 0
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += SPEED
		fire2.visible = FIRE_START # Når høyre knapp trykkes, vil AnimatedSprite (Fire2) vises (true) 
		$AnimatedSprite.play("run")
		player.rotation_degrees = 10
		
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= SPEED # Når venstre knapp trykkes, vil hastigheten på venstre sving være satt til det jeg har valgt i variabelen SPEED
		fire1.visible = FIRE_START # Når venstre knapp trykkes, vil AnimatedSprite (Fire1) vises (true) 
		$AnimatedSprite.play("run")
		player.rotation_degrees = -10


	if STATE.IDLE:
		$AnimatedSprite.play("idle")
		player.rotation_degrees = 0
	
		# Når spillet står til "tomgang", vil AnimatedSprite (Fire1 og Fire2) ikke vises (false)
		fire1.visible = FIRE_STOP 
		fire2.visible = FIRE_STOP
	
	
	move_and_collide(velocity*delta)
		
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
	health -= amount
	if health <= 0:
		health = 0
		queue_free()
		print(self, " died") # died blir printet ut når man dør
