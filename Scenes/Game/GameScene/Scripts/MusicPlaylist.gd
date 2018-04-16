extends AudioStreamPlayer

var playlistlen = 20
var playlistpos
var currentstream

func musicpath(x):
	return "res://Assets/Music/ogg/audio ("+str(x)+").ogg"

func _ready():
	randomize()
	playlistpos = round(rand_range(0,19))
	set_process(true)

func _process(delta):
	if not self.is_playing():
		if playlistpos+1 > playlistlen:
			playlistpos=1
		else: playlistpos+=1
		
		currentstream = load(musicpath(playlistpos))
		self.set_stream(currentstream)
		self.play()
	else:
		pass