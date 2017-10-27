extends WindowDialog

var _crisis = null setget set_crisis, get_crisis

func _ready():
	randomize()
	set_pos(get_pos() + Vector2(rand_range(-50, 50), rand_range(-30, 30)))
	if _crisis != null:
		init()

func init():
	set_title(_crisis.name)
	var txt = _crisis.text
	if _crisis.has("follows"):
		txt = str("(Suite de ", _crisis.follows.name, ")\n\n", txt)
	get_node("Text").set_bbcode(txt)
	
	var file2Check = File.new()
	var path = str("res:////Sprites/", _crisis.name, "_crisis.png")
	if file2Check.file_exists(path):
		get_node("Picture").set_texture(load(path))
	else:
		get_node("Picture").set_texture(load(str("res://Sprites/", _crisis.sector.get_name(), "_crisis.png")))
	
	var effect_text = "[b]Effets[/b] :\n"
	if _crisis.has("effects"):
		for effect in _crisis.effects:
			var thing_to_decrease
			if effect.has("gauge"):
				thing_to_decrease = effect.gauge
			else:
				thing_to_decrease = effect.ressource
			effect_text = str(effect_text, "    ", effect.apply, " ", Global.translate(thing_to_decrease), " / tour\n")
	
	get_node("Effects").set_bbcode(effect_text)
	
	var cost_text = "[b]Coûts de résolution[/b] :\n"
	if _crisis.has("resolution"):
		for cost in _crisis.resolution:
			cost_text = str(cost_text, "    ", cost.apply, " ", Global.translate(cost.ressource), "\n")
	get_node("ResolutionCosts").set_bbcode(cost_text)
	
	if _crisis.has("is_consequence") and _crisis.is_consequence:
		get_node("Procrastinate").set_text(["J'ai dit : PLUS TARD", "Mh mh...", "Je suis déjà assez occupé"][randi()%3])

func update_ui():
	if !Global.ship.has_resources_to_resolve(_crisis):
		get_node("Resolve").set_text("Pas assez de ressources...")
		get_node("Resolve").set_disabled(true)
	else:
		get_node("Resolve").set_text("Résoudre la crise")
		get_node("Resolve").set_disabled(false)

func set_crisis(crisis):
	_crisis = crisis
	init()

func get_crisis():
	return _crisis

func resolve():
	Global.ship.resolve_crisis(_crisis)

func _on_Resolve_pressed():
	Global.ui.get_node("SamplePlayer").play("solve_crisis")
	resolve()

func _on_Procrastinate_pressed():
	Global.ui.get_node("SamplePlayer").play("see_later")
	hide()

func pop():
	if !is_visible():
		for popup in get_parent().get_children():
			popup.set_as_toplevel(false)
		set_as_toplevel(true)
		get_node("AnimationPlayer").play("Pop")
		show()

func _on_CrisisPopup_about_to_show():
	update_ui()