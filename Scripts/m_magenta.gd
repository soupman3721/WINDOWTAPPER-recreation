extends EventableWindow

# magenta and pink have the same script, cuz they basically do the same thing

var bass_rect_sizes: PackedVector2Array = [Vector2(200,0),Vector2(130,30),Vector2(100,60),Vector2(60,100),Vector2(30,130)]

func _ready() -> void:
	super()
	for i in range(bass_rect_sizes.size()):
		set_event(str(i), func():
			if current_tween:
				current_tween.kill()
			current_tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
			current_tween.set_parallel().tween_property($Center/Rect, "custom_minimum_size:y", bass_rect_sizes[i].y, 0.125)
			if chart_name == "magenta":
				current_tween.set_parallel().tween_property($Center/Rect, "custom_minimum_size:x", bass_rect_sizes[i].x, 0.125)
		)
	set_event("!", func():
		execute_event("1")
		$Center/Rect/RectM.modulate.a = 1.0
	)
