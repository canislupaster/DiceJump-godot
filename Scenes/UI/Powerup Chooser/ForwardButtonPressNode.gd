extends BaseButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

signal pressed_node(x)

func _pressed():
	emit_signal("pressed_node")

func _ready():
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass