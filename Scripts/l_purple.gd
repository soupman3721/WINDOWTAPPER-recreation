extends EventableWindow

func hide_symbols() -> void:
	for sym in $Symbols.get_children():
		sym.modulate.a = 0.0

func show_symbol(which: int) -> void:
	hide_symbols()
	$Symbols.get_child(which).modulate.a = 1.0

func dot_event():
	if previous_event == "b" || previous_event == "r":
		move_to_offset(Vector2.ZERO, 0.125, Tween.EASE_IN, Tween.TRANS_CUBIC)

func number_button(index: int, impulse: Vector2i):
	for nuttons: Control in $NumberButtons.get_children():
		nuttons.modulate.a = 0.0
	
	$NumberButtons.get_child(index).modulate = Color.WHITE
	hide_symbols()
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
	
	var boing_func = func(child):
		if current_tween:
			current_tween.kill()
		position_offset = Vector2i(0, -10)
		show_symbol(child)
	set_event("r", boing_func.bind(1))
	set_event("b", boing_func.bind(2))
	set_event("d", show_symbol.bind(0))
	set_event("!", show_symbol.bind(3))
	set_event("H", $AnimationPlayer.play.bind("doNotHangup"))

func _physics_process(delta: float) -> void:
	for nuttons: Control in $NumberButtons.get_children():
		nuttons.modulate.a -= delta * 4
