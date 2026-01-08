extends EventableWindow


func _ready() -> void:
	super()
	
	set_event("j", func():
		$AnimationPlayer.stop()
		$AnimationPlayer.play("j")
	)
