extends EventableWindow

func _ready() -> void:
	super()
	var offsets: Array[Vector2i] = [
		Vector2i(-10, 0),
		Vector2i(0, 10),
		Vector2i(0, -10),
		Vector2i(10, 0)
	]
	for i in range(1, 5):
		set_event(str(i), func():
			$Directions.get_child(i-1).modulate.a = 1
			impulse_position(offsets[i-1])
		)

func _process(delta: float) -> void:
	for shiturself in $Directions.get_children():
		shiturself.modulate.a -= delta * 4
