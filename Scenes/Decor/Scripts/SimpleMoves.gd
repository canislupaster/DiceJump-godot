extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var time_speed = 1
var step = 0

export var enabled = true
export var getfuncname = "get_translation"
export var setfuncname = "set_translation"
export var timeoffset = 0
export(float) var speed = 1.0
export var randomtimeoffset = false

var getfunc
var setfunc
var initial
export var axis = Vector3(0,5,0)

func _ready():
	if randomtimeoffset:
		randomize()
		timeoffset = rand_range(0,timeoffset)
	
	getfunc = funcref(self,getfuncname)
	setfunc = funcref(self,setfuncname)
	
	initial = getfunc.call_func()

func _process(delta):
	if enabled:
		var val = sin(step+timeoffset)
		var vec = initial+Vector3(val,val,val)*axis
		
		setfunc.call_func(vec)
		step+=delta*speed*time_speed
	else: pass