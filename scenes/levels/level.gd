class_name LevelParent extends Node2D

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")

@onready var projectiles: Node2D = $Projectiles
@onready var player: CharacterBody2D = $Player
@onready var camera_2d: Camera2D = $Player/Camera2D
@onready var ui: CanvasLayer = $UI

func _on_player_grenade(pos, dir) -> void:
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = dir * grenade.SPEED
	projectiles.add_child(grenade)
	ui.update_grenade_text()

func _on_player_laser(pos, dir) -> void:
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(dir.angle()) + 90
	laser.direction = dir
	projectiles.add_child(laser)
	ui.update_laser_text()

func _on_house_player_in_house(arg: bool) -> void:
	var tween = get_tree().create_tween()
	var value: float = 1.0 if arg else 0.6
	tween.tween_property(camera_2d, "zoom", Vector2(value,value), 1)


func _on_player_update_stats() -> void:
	ui.update_laser_text()
	ui.update_grenade_text()
