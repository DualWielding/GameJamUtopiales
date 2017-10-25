extends Control

onready var sound = get_node("SamplePlayer")

func _ready():
	get_node("Popup1").show()

func _on_Popup1_confirmed():
	sound.play("ok")
	get_node("Popup1").hide()
	get_node("Popup2").show()


func _on_Popup2_confirmed():
	sound.play("ok")
	get_node("Popup2").hide()
	get_node("Popup3").show()


func _on_Popup3_confirmed():
	sound.play("ok")
	get_tree().change_scene("res://Game.tscn")