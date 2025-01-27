extends CharacterBody2D
class_name Sword

@export var attack : float = 1
@export var move_speed : float = 300
@export var move_acceleration : float = .3
@export var rotate_speed : float = 3
@export var rotate_acceleration : float = .3

var rotation_velocity : float = 0
var rotate_direction : float = 1

func _ready() -> void:
	self.set_meta("attack", attack)

func _physics_process(delta: float) -> void:
	_handle_movement()
	_rotate()
	move_and_slide()

func _handle_movement() -> void:
	var x_input = Input.get_axis("move_left", "move_right")
	var y_input = Input.get_axis("move_up", "move_down")
	var movement_vector : Vector2 = Vector2(x_input, y_input).normalized()
	velocity = velocity.lerp(movement_vector * move_speed, move_acceleration)

func _rotate() -> void:
	var rotation_input = Input.get_axis("rotate_ccw", "rotate_cw")
	rotation_velocity = lerp(rotation_velocity, rotate_speed * rotation_input, rotate_acceleration)
	rotate(deg_to_rad(rotation_velocity))
