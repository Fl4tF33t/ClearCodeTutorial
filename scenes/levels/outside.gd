extends LevelParent


func _on_gate_player_entered_gate(_body) -> void:
	var tween = create_tween()
	tween.tween_property(player, "speed", 0, 0.5)
	TransitionLayer.change_scene("res://scenes/levels/inside.tscn")


func _on_house_player_in_house(arg: bool) -> void:
	var tween = get_tree().create_tween()
	var value: float = 1.0 if arg else 0.6
	tween.tween_property(camera_2d, "zoom", Vector2(value,value), 1)
