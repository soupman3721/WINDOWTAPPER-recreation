extends EventableWindow


func _ready() -> void:
	super()
	
	for i in range(3, 8):
		set_event(str(i), func():
			$Shapes.get_child(i - 3).modulate.a = 1.0
			impulse_position(Vector2i(0, -10) * (i - 5) - Vector2i(0, 3))
		)

func _process(delta: float) -> void:
	for shape in $Shapes.get_children():
		shape.modulate.a -= 4 * delta
