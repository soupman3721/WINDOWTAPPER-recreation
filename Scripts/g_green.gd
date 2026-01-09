extends EventableWindow


func _ready() -> void:
	super()
	
	set_event("u", func():
		impulse_position(Vector2i(0, 5))
		$AnimationPlayer.stop()
		$Bars.modulate.a = 0
		$Square.visible = true
	)
	
	var rolls = "kK"
	for i in rolls:
		set_event(i, func():
			impulse_position(Vector2i(0, -5))
			$AnimationPlayer.stop()
			$AnimationPlayer.play(i)
			$Square.visible = false
		)

func dot_event():
	$Square.visible = false
