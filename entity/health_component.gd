extends Node
class_name HealthComponent

@export var max_hp : int

var current_hp : int

signal hp_updated
signal hp_expended

func modify_hp(modifier : int) -> void:
	current_hp = clamp(current_hp + modifier, 0, max_hp)
	hp_updated.emit()
	if !current_hp > 0:
		hp_expended.emit()
		print("Dead")
	print(current_hp)
