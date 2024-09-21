extends CharacterBody2D

signal laser(pos, dir)
signal grenade(pos, dir)

const MOVE_SPEED:= 500

var speed = MOVE_SPEED
var can_laser: bool = true
var can_grenade: bool = true

@onready var laser_timer: Timer = $LaserTimer
@onready var grenade_timer: Timer = $GrenadeTimer

@onready var laser_start_positions: Node2D = $LaserStartPositions
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Inputs
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction  * speed
	
	look_at(get_global_mouse_position())
	var dir = (get_global_mouse_position() - position).normalized()
	
	# Shooting
	if Input.is_action_pressed("primary action") and can_laser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		gpu_particles_2d.emitting = true
		can_laser = false
		laser_timer.start()
		var laser_markers = laser_start_positions.get_children()
		var selected_marker = laser_markers.pick_random()
		laser.emit(selected_marker.global_position, dir)
	
	# Grenade
	if Input.is_action_pressed("secondary action") and can_grenade and Globals.grenade_amount > 0:
		Globals.grenade_amount -= 1
		can_grenade = false
		grenade_timer.start()
		var pos = laser_start_positions.get_child(0).global_position
		grenade.emit(pos, dir)
	
	move_and_slide()

func _on_laser_timer_timeout() -> void:
	can_laser = true

func _on_grenade_timer_timeout() -> void:
	can_grenade = true
