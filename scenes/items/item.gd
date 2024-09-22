extends Area2D

var rotation_speed: int = 4
var available_options = ["laser", "laser", "laser", "grenade", "health"]
var type = available_options.pick_random()

var direction: Vector2
var distance: int = randi_range(150, 250)

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	match type:
		"laser":
			sprite_2d.modulate = Color(0, 0, 0.6)
		"grenade":
			sprite_2d.modulate = Color(0.6, 0, 0)
		"health":
			sprite_2d.modulate = Color(0, 0.8, 0)
		_:
			pass
			
	var target_pos = position + direction * distance
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", target_pos, 0.5)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.3).from(Vector2.ZERO)

func _process(delta: float) -> void:
	rotation += rotation_speed * delta


func _on_body_entered(_body: Node2D) -> void:
	match type:
		"laser":
			Globals.laser_amount += 5
		"grenade":
			Globals.grenade_amount += 3
		"health":
			Globals.health += 10
	queue_free()
