extends Item_Container

func hit():
	super.hit()
	if not opened:
		for i in range(5):
			var pos = spawn_positions.get_children().pick_random().global_position
			open.emit(pos, current_direction)
		opened = true
