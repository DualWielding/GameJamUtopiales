extends Control

var crisis_popup_class = preload("res://UI/CrisisPopup.tscn")
var indicative_text_class = preload("res://UI/IndicativeText.tscn")

func _ready():
	Global.ui = self

func reset():
	for popup in get_node("crisis popup").get_children():
		popup.queue_free()

func pop_crisis(crisis):
	var cp = crisis_popup_class.instance()
	cp.set_name(str(crisis.id))
	cp.add_to_group("crisis popup")
	cp.set_crisis(crisis)
	get_node("CrisisPopups").add_child(cp)
	cp.pop()

func add_indicative_text(crisis):
	var node_name = str(crisis.sector.get_name(), "IndicativeTexts")
	var it = indicative_text_class.instance()
	it.set_crisis(crisis)
	get_node(node_name).add_child(it)
	return it

func hide_popups():
	for popup in get_node("CrisisPopups").get_children():
		popup.hide()

func delete_popup(crisis):
	get_node(str("CrisisPopups/", crisis.id)).queue_free()

func update_popups():
	for popup in get_node("CrisisPopups").get_children():
		popup.update_ui()

func _on_NextDayButton_pressed():
	Global.next_day()

func next_day():
	var ball = get_node("TurnCounter/TextureFrame")
	ball.set_pos(Vector2(Global.current_day * (ball.get_parent().get_size().x/12), ball.get_pos().y))