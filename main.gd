@warning_ignore_start("integer_division")
extends Node

signal step_hit(step:int, section:int)

var section: int = 0
var step: int = 0:
	set(value):
		if int(value) % 16 == step: return
		step = int(value) % 16
		section = int(value) / 16
		step_hit.emit(step, section)
		
		$Debug/StepLabel.text = str(step)
		$Debug/SectionLabel.text = str(section)

#func _unhandled_input(event: InputEvent) -> void:
	#if !event.is_pressed(): return
	#$Windows/Magenta.execute_event(event.as_text())

func _ready() -> void:
	step_hit.emit(step, section)
	$Positions.position = Vector2(DisplayServer.screen_get_size(DisplayServer.window_get_current_screen())) / 2 - $Positions.size / 2
	
	for i in range(3):
		await get_tree().physics_frame # for some reason, the windows won't align properly if this isn't here
	
	var windows = $Windows.get_children()
	for i in windows.size():
		if (windows[i] is not EventableWindow): continue
		windows[i].origin_position = $Positions.get_children()[i].global_position

func _process(_delta: float) -> void:
	step = $Wavetapper.get_playback_position() / (0.25 / ($Wavetapper.stream.bpm / 60))
	if $Wavetapper.playing:
		$Debug/SongPosition.value = $Wavetapper.get_playback_position() / $Wavetapper.stream.get_length()

func _on_song_position_drag_started() -> void:
	$Wavetapper.stream_paused = true

func _on_song_position_drag_ended(_value_changed: bool) -> void:
	$Wavetapper.stream_paused = false
	$Wavetapper.seek($Debug/SongPosition.value * $Wavetapper.stream.get_length())


#func _on_step_hit(_step: int, _section: int) -> void:
	#print(Engine.get_frames_per_second())
