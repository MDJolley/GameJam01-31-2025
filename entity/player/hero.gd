extends Node2D
class_name Hero

@export var damage : float = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for segment : PlayerWeapon in get_children():
		segment.set_meta("damage", damage)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
