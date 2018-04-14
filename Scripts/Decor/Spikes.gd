extends StaticBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var moving = false
var time_speed = 1

func _ready():
	# Called every time the node is added to the scene.
	if get_parent().is_in_group("updown_spikes"):
		moving = true
		$AnimationPlayer.play("UpDown",1,time_speed)

func _on_DeathArea_body_entered(body):
	global.get_game().try_kill_player_rb(body, "Why did you do that? Do you know that spikes are death?")