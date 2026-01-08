extends EventableWindow

var left_side: String = "1qaz"
var both_side: String = "2wsx"
var right_side: String = "3edc"

# 0 - left, 1 - right, 2 - both
func note_push(side: int, row: int):
	if previous_event == current_event: return
	
	if side == 0 || side == 2:
		@warning_ignore("narrowing_conversion")
		move_to_offset(Vector2i(0, 15 * float(row + 1) / float(4)))
		$NoteContainer/LeftSide.get_child(row).visible = true
	elif left_side.contains(previous_event) || both_side.contains(previous_event):
		move_to_offset(Vector2i(0, 0))
		$NoteContainer/LeftSide.get_child(row).visible = false
	
	if side == 1 || side == 2:
		$NoteContainer/RightSide.get_child(row).visible = true
	else:
		$NoteContainer/RightSide.get_child(row).visible = false

func dot_event():
	if previous_event == current_event: return
	for i in $NoteContainer/LeftSide.get_children():
		i.visible = false
	for i in $NoteContainer/RightSide.get_children():
		i.visible = false
	move_to_offset(Vector2i(0, 0))

func _ready():
	super()
	
	for i in range(4):
		set_event(left_side[i], note_push.bind(0, i))
		set_event(both_side[i], note_push.bind(2, i))
		set_event(right_side[i], note_push.bind(1, i))
