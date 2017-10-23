extends Label

var target = null
var crisis setget set_crisis
var hovered = false

func _draw():
	var start = Vector2(0, 0)
	var end = target.get_global_pos() - get_global_pos()
	if end.x > 0:
		start += get_size()
	if target != null:
		draw_line(end, start, Color8(255, 60, 60, 255/9), 1)
		draw_line(end, start, Color8(255, 60, 60, 255/12), 2)
		draw_line(end, start, Color8(255, 60, 60, 255/15), 3)


func set_crisis(cr):
	set_text(cr.name)
	target =(cr.sector)
	crisis = cr

func _ready():
	set_global_pos(target.get_global_pos() + Vector2(50, 50))
	set_process(true)
	set_process_input(true)

func _input(event):
	if hovered\
	and event.type == InputEvent.MOUSE_BUTTON\
	and event.button_index == BUTTON_LEFT\
	and event.pressed:
		hovered = false
		Global.activate_crisis_popup(crisis)

func _process(delta):
	update()

func _on_IndicativeText_mouse_enter():
	hovered = true


func _on_IndicativeText_mouse_exit():
	hovered = false
