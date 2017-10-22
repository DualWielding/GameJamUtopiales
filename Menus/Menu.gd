extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_CreditsButton_pressed():
	get_node("Credits").show()

func _on_Play_pressed():
	get_tree().change_scene("res://Menus/HowToPlay.tscn")
