extends CharacterBody2D

var active:= false
var speed:= 300
var can_be_damaged:= true
var player_nearby:= false
var direction: Vector2
var health:= 20

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_timer: Timer = $Timers/AttackTimer
@onready var hit_timer: Timer = $Timers/HitTimer

func hit():
	if can_be_damaged:
		can_be_damaged = false
		hit_timer.start()
		health -= 10
		animated_sprite_2d.material.set_shader_parameter("progress", 0.8)
	if health <= 0:
		queue_free()

func _process(_delta: float) -> void:
	direction = (Globals.player_position - position).normalized()
	velocity = direction * speed
	if active:
		move_and_slide()
		look_at(Globals.player_position)

func _on_attack_area_2d_body_entered(_body: Node2D) -> void:
	player_nearby = true
	animated_sprite_2d.play("attack")
func _on_attack_area_2d_body_exited(_body: Node2D) -> void:
	player_nearby = false
func _on_notice_area_2d_body_entered(_body: Node2D) -> void:
	active = true
	animated_sprite_2d.play("walk")
func _on_notice_area_2d_body_exited(_body: Node2D) -> void:
	active = false
	animated_sprite_2d.stop()

func _on_animated_sprite_2d_animation_finished() -> void:
	if player_nearby:
		Globals.health -= 10
		attack_timer.start()

func _on_attack_timer_timeout() -> void:
	animated_sprite_2d.play("attack")
	
func _on_hit_timer_timeout() -> void:
	can_be_damaged = true
	animated_sprite_2d.material.set_shader_parameter("progress", 0)
