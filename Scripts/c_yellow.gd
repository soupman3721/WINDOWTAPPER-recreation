extends EventableWindow

func _ready():
	super()
	
	var event_string = "uet"
	for i in event_string:
		set_event(i, func():
			$AnimationPlayer.stop()
			$AnimationPlayer.play(i)
		)
