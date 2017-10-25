extends Control

func _on_CreditsButton_pressed():
	get_node("Credits").show()

func _on_Play_pressed():
	get_tree().change_scene("res://Menus/HowToPlay.tscn")
