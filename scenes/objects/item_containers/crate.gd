extends Item_Container

func hit():
	super.hit()
	var pos = spawn_positions.get_children().pick_random().global_position
	open.emit(pos, current_direction)
