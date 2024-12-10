extends CharacterBody2D

# Movement speed
@export var speed: float = 200.0

# Gravity and Jump force
@export var gravity: float = 600.0
@export var jump_force: float = 400.0

# Reference to the Sprite node
@onready var sprite = $Sprite2D  # Adjust this to match your Sprite node name

# Textures for left and right movement
@export var left_texture : Texture2D
@export var right_texture : Texture2D
@export var idle_texture : Texture2D  # Optional, for idle state

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

	# Reset horizontal velocity
	velocity.x = 0

	# Handle input for left and right movement
	if Input.is_action_pressed("left"):
		velocity.x -= speed
		sprite.texture = left_texture  # Change sprite to left texture
	elif Input.is_action_pressed("right"):
		velocity.x += speed
		sprite.texture = right_texture  # Change sprite to right texture
	else:
		# Optionally, set to idle texture if no movement
		sprite.texture = idle_texture

	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_force

	# Move the player and handle collisions
	move_and_slide()
