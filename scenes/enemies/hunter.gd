extends CharacterBody2D

var active:= false
var speed:= 200
var direction: Vector2 = Vector2.ZERO
var next_path_pos

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D

func _ready() -> void:
	navigation_agent_2d.target_position = Globals.player_position

func _physics_process(_delta: float) -> void:
	if active:
		next_path_pos = navigation_agent_2d.get_next_path_position()
		direction = (next_path_pos - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		look_at(Globals.player_position)

func _on_notice_area_body_entered(_body: Node2D) -> void:
	active = true

func _on_notice_area_body_exited(_body: Node2D) -> void:
	active = false


func _on_navigation_timer_timeout() -> void:
	if active:
		navigation_agent_2d.target_position = Globals.player_position
