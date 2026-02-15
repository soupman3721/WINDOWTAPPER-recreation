extends EventableWindow

func _ready() -> void:
	super()
	set_event("i", func():
		$AnimationPlayer.stop()
		$AnimationPlayer.play("ready")
	)
	set_event("g", func():
		$AnimationPlayer.stop()
		$AnimationPlayer.play("spin")
	)
	set_event("s", func():
		$AnimationPlayer.play("RESET")
	)
