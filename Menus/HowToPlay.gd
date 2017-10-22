extends Control


func _ready():
	get_node("Popup1").show()


func _on_Popup1_confirmed():
	get_node("Popup1").hide()
	get_node("Popup2").show()


func _on_Popup2_confirmed():
	get_node("Popup2").hide()
	get_node("Popup3").show()


func _on_Popup3_confirmed():
	get_tree().change_scene("res://Game.tscn")