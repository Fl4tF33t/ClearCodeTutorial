extends CharacterBody2D

signal laser(pos, dir)

var player_nearby:= false
var can_laser:= true
var marker_pos:= false
var health:= 30
var can_be_damaged:= true

@onready var laser_spawn_positions: Node2D = $LaserSpawnPositions
@onready var laser_cooldown: Timer = $Timer/LaserCooldown
@onready var damage_timer: Timer = $Timer/DamageTimer
@onready var sprite_2d: Sprite2D = $Sprite2D

func _process(_delta: float) -> void:
	if player_nearby:
		look_at(Globals.player_position)
		if can_laser:
			var pos: Vector2 = laser_spawn_positions.get_child(marker_pos).global_position
			marker_pos = not marker_pos
			var dir: Vector2 = (Globals.player_position - position).normalized()
			laser.emit(pos, dir)
			can_laser = false
			laser_cooldown.start()

func _on_attack_area_body_entered(_body: Node2D) -> void:
	player_nearby = true

func _on_attack_area_body_exited(_body: Node2D) -> void:
	player_nearby = false

func _on_laser_cooldown_timeout() -> void:
	can_laser = true

func hit():
	if can_be_damaged:
		health -= 10
		can_be_damaged = false
		damage_timer.start()
		sprite_2d.material.set_shader_parameter("progress", 1)
	if health <= 0:
		queue_free()

func _on_damage_timer_timeout() -> void:
	can_be_damaged = true
	sprite_2d.material.set_shader_parameter("progress", 0)
