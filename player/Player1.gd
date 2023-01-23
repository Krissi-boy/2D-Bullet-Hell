extends KinematicBody2D
var motion = Vector2()
const UP = Vector2(0, -1)

var SPEED = 1
var FIRE_START = true
var FIRE_STOP = false
var screen_size

export var health = 5
export var harm = 2 ## Damage the player does to others on contact (not projectile damage)
var velocity = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
		

func _physics_process(delta): # delta er standard for 60 FPS
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	
	
		
	if Input.is_action_pressed("ui_up"):
		yield(get_tree().create_timer(0.15), "timeout") 
		$Fire3.visible = FIRE_START # Når spillet kjøres vil AnimatedSprite (Fire3 og Fire4) vises hele tiden (true) 
		$Fire4.visible = FIRE_START  
		

	
	if Input.is_action_pressed("ui_right"):
		velocity.x+=SPEED
		$Fire2.visible = FIRE_START # Når høyre knapp trykkes, vil AnimatedSprite (Fire2) vises (true) 
		
	if Input.is_action_pressed("ui_left"):
		velocity.x-=SPEED
		$Fire1.visible = FIRE_START # Når høyre knapp trykkes, vil AnimatedSprite (Fire1) vises (true) 
	elif Input.is_action_just_released("ui_cancel"):
		pass	
	
	var collision = move_and_collide(velocity)
		
	if collision.get_collider():
		pass
		
	if Input.is_action_pressed("ui_right"):
		motion.x =+ SPEED # Når høyre knapp trykkes, vil hastigheten på høyre sving være satt til det jeg har valgt i variabelen SPEED
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = false
		
		
	elif Input.is_action_pressed("ui_left"): 
		motion.x =- SPEED # Når venstre knapp trykkes, vil hastigheten på venstre sving være satt til det jeg har valgt i variabelen SPEED
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = true 
		
	else:
		$AnimatedSprite.play("idle")
	
		# Når spillet står til "tomgang", vil AnimatedSprite (Fire1 og Fire2) ikke vises (false)
		$Fire1.visible = FIRE_STOP 
		$Fire2.visible = FIRE_STOP
	
	

		
func timeout(time):		
	yield(get_tree().create_timer(time), "timeout") 
	# Kode for sette timer. Her skrev jeg "timeout", som jeg kan bruke i en if input, for å refere til denne funksjonen.
	
	$Fire1.visible = FIRE_START
	$Fire2.visible = FIRE_START
	
	$Fire1.visible = FIRE_STOP
	$Fire2.visible = FIRE_STOP
	pass # Replace with function body.
	
	
## Player getting damaged
func damage(amount: int): # Når bullets eller noe treffes enemies så kjøres denne hitboxen 
	health -= amount
	if health <= 0:
		health = 0
		queue_free()
		print(self, " died") # died blir printet ut når man dør
