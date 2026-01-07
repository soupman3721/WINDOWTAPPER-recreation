extends EventableWindow

# 0 - left, 1 - right, 2 - both
func note_push(side: int, row: int):
	pass

func _ready():
	super()
	
	var left_side: String = "1qaz"
	var both_side: String = "2wsx"
	var right_side: String = "3edc"
	
	for i in range(4):
		set_event(left_side[i], note_push.bind(0, i))
		set_event(both_side[i], note_push.bind(2, i))
		set_event(right_side[i], note_push.bind(1, i))
