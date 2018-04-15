extends Area

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var game = global.get_game()

func _body_exited(body):
	if game.is_player_rb(body):
		game.emit_signal("death","You went too far. Outta bounds.")

func _ready():
	self.connect("body_exited",self,"_body_exited")