extends EventableWindow

func number_button(index: int, impulse: Vector2i):
	for nuttons: Control in $NumberButtons.get_children():
		nuttons.modulate = Color(1,1,1,0)
	
	$NumberButtons.get_child(index).modulate = Color.WHITE
	impulse_position(impulse)

func _ready() -> void:
	super()
	var number_button_impulses = [
		Vector2i(-10, -10),
		Vector2i(0, -10),
		Vector2i(10, -10),
		Vector2i(-10, 0),
		Vector2i(0, 0),
		Vector2i(10, 0),
		Vector2i(-10, 10),
		Vector2i(0, 10),
		Vector2i(10, 10),
	]
	
	for button_number in len($NumberButtons.get_children()):
		set_event(str(button_number + 1), number_button.bind(button_number, number_button_impulses[button_number]))

func _process(delta: float) -> void:
	for nuttons: Control in $NumberButtons.get_children():
		nuttons.modulate.a -= delta * 4
