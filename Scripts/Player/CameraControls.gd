extends InterpolatedCamera

var cameravel = Vector2(0,0)
var sensitivity = 1

func _ready():
	set_process_input(true)

func _process(delta):
	rotation_degrees.x += -cameravel.y
	rotation_degrees.y += cameravel.x
	
func _input(event):
	if event is InputEventMouseMotion:
		var res = get_viewport().size
		cameravel = (event.relative/10)*sensitivity