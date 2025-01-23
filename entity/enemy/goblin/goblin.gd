extends CharacterBody2D

@onready var health_component: HealthComponent = $HealthComponent
@onready var nav : NavigationAgent2D = $NavigationAgent

@export var speed : float = 1
@export var acceleration : float = .3


var player : Sword
var agro : bool = false

func _ready() -> void:
	var health_comp : HealthComponent = find_child("HealthComponent")
	health_comp.connect("hp_updated", _hp_changed)
	health_comp.connect("hp_expended", _die)

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity)
	if collision:
		var collider = collision.get_collider()
		var damage = collider.get_meta("damage")
		if damage != null:
			health_component.modify_hp(-damage)
	if agro:
		look_at(player.global_position)
		var direction = (_chase_player() - global_position).normalized()
		velocity = velocity.lerp(direction * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2(0,0), acceleration)
	
	move_and_slide()

func _hp_changed() -> void:
	pass

func _die() -> void:
	queue_free()

func _on_detection_radius_body_entered(body: Node2D) -> void:
	print(body)
	if body.is_in_group("player"):
		print("player found")
		player = body
		agro = true

func _on_detection_radius_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = null
		agro = false

func _chase_player() -> Vector2:
	var pos_goal = player.global_position
	nav.target_position = pos_goal
	return nav.get_next_path_position()
