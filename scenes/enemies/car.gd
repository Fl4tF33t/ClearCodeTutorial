extends PathFollow2D

var player_near:= false

@onready var turret: Node2D = $Turret

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_ratio += 0.1 * delta
	if player_near:
		turret.look_at(Globals.player_position)



func _on_notice_area_body_entered(_body: Node2D) -> void:
	player_near = true


func _on_notice_area_body_exited(_body: Node2D) -> void:
	player_near = false
