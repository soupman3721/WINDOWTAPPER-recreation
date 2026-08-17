extends EventableWindow

@onready var symbols := $Symbols
@onready var pulse_player := $PulsePlayer

func show_symbol(which: int) -> void:
	if which+1 > symbols.get_child_count(): return
	for i: Node2D in symbols.get_children():
		i.visible = false
	symbols.get_child(which).visible = true
	
	pulse_player.stop()
	pulse_player.play("pulse")

func _ready() -> void:
	super()
	for i in range(1, 10):
		set_event(str(i), $SequencePlayer.play.bind(str(i)))
