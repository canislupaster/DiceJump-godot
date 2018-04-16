extends Area

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

signal level_done

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Area_body_entered(body):
	if global.get_game().is_player_rb(body):
		global.get_game().emit_signal("level_done")