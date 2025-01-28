extends CharacterBody2D

signal take_thorns_damage

func _physics_process(delta: float) -> void:
	for i in get_slide_collision_count():
		print(i)
		var collision = get_slide_collision(i)
		print(collision)
		if collision:
			var collider = collision.get_collider()
			var damage = collider.get_meta("thorns")
			if damage:
				emit_signal("take_thorns_damage", damage)
	move_and_slide()
