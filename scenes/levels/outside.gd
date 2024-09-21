extends LevelParent


func _on_gate_player_entered_gate(_body) -> void:
	var tween = create_tween()
	tween.tween_property(player, "speed", 0, 0.5)
	TransitionLayer.change_scene("res://scenes/levels/inside.tscn")
