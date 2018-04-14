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
	if body is preload("res://Scripts/Player/RigidBodyPlayer.gd"):
		global.get_game().emit_signal("death", "Spikes killed you real bad.")