class_name LevelParent extends Node2D

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")
var item_scene: PackedScene = preload("res://scenes/items/item.tscn")

@onready var projectiles: Node2D = $Projectiles
@onready var player: CharacterBody2D = $Player
@onready var camera_2d: Camera2D = $Player/Camera2D
@onready var ui: CanvasLayer = $UI
@onready var items: Node2D = $Items

func _ready() -> void:
	for container in get_tree().get_nodes_in_group("Container"):
		container.connect("open", _on_container_opened)
	for scout in get_tree().get_nodes_in_group("Scouts"):
		scout.connect("laser", _on_scout_laser)

func _on_scout_laser(pos, dir):
	create_laser(pos, dir)

func _on_container_opened(pos, dir):
	var item = item_scene.instantiate()
	item.position = pos
	item.direction = dir
	items.call_deferred("add_child", item)

func _on_player_grenade(pos, dir) -> void:
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = dir * grenade.SPEED
	projectiles.add_child(grenade)
	ui.update_grenade_text()

func _on_player_laser(pos, dir) -> void:
	create_laser(pos, dir)

func create_laser(pos, dir) -> void:
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(dir.angle()) + 90
	laser.direction = dir
	projectiles.add_child(laser)
