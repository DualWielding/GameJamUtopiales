extends Node

var times

func _ready():
	times = 0
	get_node("StreamPlayer").connect("finished", self, "next")

func next():
	times += 1
	if times == 2: #Second soundtrack is on loop
		get_node("StreamPlayer 2").play()
	else:
		get_node("StreamPlayer").play()