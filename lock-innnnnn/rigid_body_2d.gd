extends RigidBody2D

@export var speed: float = 200.0
var player_pos
var target_pos
@onready var anim = $AnimationPlayer
@onready var player = get_parent().getParent().get_node("player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	player_pos = player.position 
	target_pos = (player_pos - position).normalized()
	
	if position.distance_to(player_pos) > 3:
		position += target_pos * speed * delta
	
	
