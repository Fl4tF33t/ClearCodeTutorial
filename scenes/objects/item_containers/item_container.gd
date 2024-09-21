class_name Item_Container extends StaticBody2D

signal open(pos, dir)

@onready var current_direction: Vector2 = Vector2.DOWN.rotated(rotation)
@onready var lid_sprite: Sprite2D = $LidSprite
@onready var spawn_positions: Node2D = $SpawnPositions

func hit():
	lid_sprite.hide()
