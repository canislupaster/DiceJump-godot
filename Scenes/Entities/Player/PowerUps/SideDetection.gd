extends Area

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Area_area_shape_entered(area_id, area, area_shape, self_shape):
	print("selfshape is "+str(self_shape))

func _on_Area_area_entered(area):
	print("they has entered")

func _on_Area_body_shape_entered(body_id, body, body_shape, area_shape):
	print("selfshape2 is "+str(area_shape))
