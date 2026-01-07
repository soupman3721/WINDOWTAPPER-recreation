extends Window
class_name EventableWindow

var chart: Dictionary = {}
@export var chart_name: String = "format":
	set(value):
		chart_name = value
		if !FileAccess.file_exists("res://Charts/%s.json" % value):
			printerr("Chart of name %s doesn't exist" % value)
			return
		chart = JSON.parse_string(FileAccess.get_file_as_string("res://Charts/%s.json" % value))
@export var stop_chart_execution: bool = false

var current_tween: Tween = null

var origin_position: Vector2i:
	set(value):
		origin_position = value
		position = value
var position_offset: Vector2i:
	set(value):
		position = origin_position + value
		position_offset = value

func impulse_position(impulse: Vector2i, length: float = 0.25):
	position_offset = impulse
	if current_tween:
		current_tween.kill()
	current_tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	current_tween.tween_property(self, "position", origin_position, length)
	current_tween.play()
	current_tween.tween_callback(func(): position_offset = Vector2i.ZERO)

var events: Dictionary[String, Callable] = {}

func set_event(ev_name: String, ev_callback: Callable):
	events.set(ev_name, ev_callback)

func dot_event():
	pass

func execute_event(ev_name: String):
	if ev_name == ".":
		dot_event()
	if !events.has(ev_name):
		printerr("No event of tag: %s" % ev_name)
		return
	
	events[ev_name].call()

func _on_step_hit(step: int, section: int):
	if stop_chart_execution: return
	if !is_node_ready(): await ready
	if chart["sections"][section] == -2:
		return
	if chart["sections"][section] == -1:
		if step == 0:
			execute_event("V")
		return
	
	execute_event(chart["section_charts"][chart["sections"][section]][step])

func _ready() -> void:
	set_event("V", func(): visible = !visible)
	
	var scene = get_tree().current_scene
	if scene.has_signal("step_hit"):
		scene.step_hit.connect(_on_step_hit)
