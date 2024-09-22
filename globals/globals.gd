extends Node

signal stat_change

var laser_amount = 20:
	set(value):
		laser_amount = value
		stat_change.emit()
var grenade_amount = 5:
	set(value):
		grenade_amount = value
		stat_change.emit()
var can_be_damaged:= true
var health = 60:
	set(value):
		if value > health:
			health = min(value, 100)
		else:
			if can_be_damaged:
				health = value
				can_be_damaged = false
				player_damage_timer()
		stat_change.emit()
var player_position: Vector2

func player_damage_timer():
	await get_tree().create_timer(0.5).timeout
	can_be_damaged = true
