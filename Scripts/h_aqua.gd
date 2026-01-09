extends EventableWindow

var rotated: bool = false

func _ready() -> void:
	super()
	
	set_event("t", func():
		$Star.rotation_degrees = 30.0 if rotated else 0.0
		$Star.modulate.a = 1.0
		
		@warning_ignore("narrowing_conversion")
		impulse_position(Vector2i(10 * sin((float(current_step) / 16) * TAU), -10 * cos((float(current_step) / 16) * TAU)))
		
		rotated = !rotated
	)

func _process(delta: float) -> void:
	$Star.modulate.a -= 4.0 * delta
