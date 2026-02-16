extends EventableWindow

func _ready() -> void:
	super()
	var event_string = "123qwertyuiopasdfg"
	var callback := func(anim:String):
			$AnimationPlayer.stop()
			$AnimationPlayer.play(anim)
	for ev in event_string:
		set_event(ev, callback.bind(ev))
	
	set_event("R", $AnimationPlayer.play.bind("RESET"))
	set_event("C", $AnimationPlayer.play.bind("fadeOut"))
