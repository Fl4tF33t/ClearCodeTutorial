extends CharacterBody2D

var can_be_damaged:= true
var active:= false
var max_speed:= 600
var health:= 40
var speed: int
var speed_multiplier:= 1
var explosion_active:= false

@onready var hit_timer: Timer = $HitTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var explosion: Sprite2D = $Explosion
@onready var drone_sprite: Sprite2D = $DroneSprite

func _ready() -> void:
	explosion.hide()
	drone_sprite.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if active:
		look_at(Globals.player_position)
		var direction = (Globals.player_position - position).normalized()
		velocity = direction * speed * speed_multiplier
		var collision = move_and_collide(velocity * delta)
		if collision:
			animation_player.play("explosion")
			explosion_active = true
	if explosion_active:
		var targets = get_tree().get_nodes_in_group("Container") + get_tree().get_nodes_in_group("Entity")
		for target in targets:
			var in_range = target.global_position.distance_to(global_position) < 400
			if "hit" in target and in_range:
				target.hit()

func hit():
	if can_be_damaged:
		health -= 10
		can_be_damaged = false
		hit_timer.start()
		drone_sprite.material.set_shader_parameter("progress", 1)
	if health <= 0:
		animation_player.play("explosion")
		explosion_active = true

func stop_movement():
	speed_multiplier = 0

func _on_notice_area_body_entered(_body: Node2D) -> void:
	active = true
	var tween = create_tween()
	tween.tween_property(self, "speed", max_speed, 6)

func _on_hit_timer_timeout() -> void:
	can_be_damaged = true
	drone_sprite.material.set_shader_parameter("progress", 0)
