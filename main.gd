extends Node

signal step_hit(step:int, section:int)

var section: int = 0
var step: int = 0:
	set(value):
		if int(value) % 16 == step: return
		step = int(value) % 16
		@warning_ignore("integer_division")
		section = int(value) / 16
		step_hit.emit(step, section)

func _unhandled_input(event: InputEvent) -> void:
	if !event.is_pressed(): return
	#$Windows/Red.execute_event(event.as_text())
	$Windows/Purple.execute_event(event.as_text())

func _ready() -> void:
	step_hit.emit(step, section)
	$Positions.position = Vector2(DisplayServer.screen_get_size(DisplayServer.window_get_current_screen())) / 2 - $Positions.size / 2
	var windows = $Windows.get_children()
	
	for i in range(3):
		await get_tree().physics_frame # for some reason, the windows won't align properly if this isn't here
	
	for i in $Windows.get_children().size():
		if (windows[i] is not EventableWindow): return
		windows[i].origin_position = $Positions.get_children()[i].global_position

func _physics_process(_delta: float) -> void:
	step = $Wavetapper.get_playback_position() / (0.25 / ($Wavetapper.stream.bpm / 60))
