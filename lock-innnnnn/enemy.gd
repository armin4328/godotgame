extends CharacterBody2D


@export var health = 10
@export var damage = 1
@export var speed: float = 100.0
@export var player_path: NodePath
@export var gravity: float = 200.0
@onready var anim = $AnimationPlayer
var isAttacking = false
var cooldown = 2

func _ready():
	pass

func _physics_process(delta):
	var player_position = $"../player".global_position
	var enemy_position = global_position
	var difference = player_position.x - enemy_position.x
	
	if player_position.x > enemy_position.x and isAttacking == false:
		velocity.x = 100
		$Sprite2D.flip_h = false
		anim.play("idle")
	elif player_position.x < enemy_position.x and isAttacking == false:
		velocity.x = -100
		$Sprite2D.flip_h = true
		anim.play("idle")
		print("Enemy position", enemy_position)

	else:
		velocity.x = 0
		if isAttacking == false:
			anim.play("idle")
	
	if abs(difference) < 120 and cooldown <= 0:
		anim.play("attack")
		isAttacking = true
		if cooldown < 0:
			cooldown = 2
	cooldown -= delta
	
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0.0
	
	# Move the enemy using move_and_slide
	move_and_slide()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack":
		isAttacking = false
