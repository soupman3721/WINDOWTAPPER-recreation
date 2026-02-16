extends EventableWindow


func show_symbol(which: int) -> void:
	print(which)

func _ready() -> void:
	super()
	for i in range(1, 10):
		set_event(str(i), $SequencePlayer.play.bind(str(i)))
