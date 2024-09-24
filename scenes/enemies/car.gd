extends PathFollow2D

var player_near:= false

@onready var turret: Node2D = $Turret
@onready var raycast2: RayCast2D = $Turret/RayCast2D2
@onready var line1: Line2D = $Turret/RayCast2D/Line2D
@onready var line2: Line2D = $Turret/RayCast2D2/Line2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var gun_fire: Sprite2D = $Turret/GunFire
@onready var gun_fire_2: Sprite2D = $Turret/GunFire2

func _ready() -> void:
	line2.add_point(raycast2.target_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_ratio += 0.03 * delta
	if player_near:
		turret.look_at(Globals.player_position)

func _on_notice_area_body_entered(_body: Node2D) -> void:
	player_near = true
	animation_player.play("laser_load")

func _on_notice_area_body_exited(_body: Node2D) -> void:
	player_near = false
	animation_player.pause()
	
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(line1, "width", 0, randf_range(0.1, 0.5))
	tween.tween_property(line2, "width", 0, randf_range(0.1, 0.5))
	await tween.finished 
	animation_player.stop()

func fire():
	Globals.health -= 20
	gun_fire.modulate.a = 1
	gun_fire_2.modulate.a = 1
	
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(gun_fire, "modulate:a", 0, randf_range(0.1, 0.5))
	tween.tween_property(gun_fire_2, "modulate:a", 0, randf_range(0.1, 0.5))
