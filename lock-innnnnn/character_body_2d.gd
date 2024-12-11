extends CharacterBody2D

# Movement speed
@export var speed: float = 200.0

# Gravity and Jump force
@export var gravity: float = 600.0
@export var jump_force: float = 400.0
var isAttacking = false
var facing = "right"
@onready var anim = $AnimationPlayer


func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

	# Reset horizontal velocity
	velocity.x = 0

	# Handle input for left and right movement
	if Input.is_action_pressed("left") and isAttacking == false:
		velocity.x -= speed # Change sprite to left texture
		anim.play("walk_right")
		$Sprite2D.flip_h = true
		
	elif Input.is_action_pressed("right")and isAttacking == false:
		velocity.x += speed
		anim.play("walk_right")
		$Sprite2D.flip_h = false

		
	else:
		velocity.x = 0
		if isAttacking == false:
			anim.play("idle")
	
	if Input.is_action_pressed("attack"):
		anim.play("attack_right")
		isAttacking = true
			
	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_force
	
	move_and_slide()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack_right":
		isAttacking = false
