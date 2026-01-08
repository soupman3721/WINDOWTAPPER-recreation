extends EventableWindow

func _ready() -> void:
	super()
	
	for i in range(1, 6):
		set_event(str(i), func():
			$AnimationPlayer.stop()
			$AnimationPlayer.play(str(i))
			position_offset = Vector2i(0, 15)
			move_to_offset(Vector2i.ZERO, 1, Tween.EASE_OUT, Tween.TRANS_ELASTIC)
		)
