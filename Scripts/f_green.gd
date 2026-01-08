extends EventableWindow

func _ready() -> void:
	super()
	set_event("l", func():
		$Left.modulate.a = 1
		$Right.modulate.a = 0
		impulse_position(Vector2i(-10, 0))
	)
	set_event("r", func():
		$Right.modulate.a = 1
		$Left.modulate.a = 0
		impulse_position(Vector2i(10, 0))
	)

func dot_event():
	$Left.modulate.a = 0
	$Right.modulate.a = 0
