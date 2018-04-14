extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process_input(true)
	
func _input(x):
	if x.is_action_pressed("game_respawn"):
		var game = global.get_game()
		game.emit_signal("death","Noobs like to restart from the beginning.")

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
