extends CharacterBody2D



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var direction = Vector2.RIGHT
	velocity = direction * 100
	move_and_slide()
