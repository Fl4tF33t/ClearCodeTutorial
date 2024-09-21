extends Area2D

signal player_in_house(arg: bool)

func _on_body_entered(_body: Node2D) -> void:
	player_in_house.emit(true)


func _on_body_exited(_body: Node2D) -> void:
	player_in_house.emit(false)
