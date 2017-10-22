extends WindowDialog

var _crisis = null setget set_crisis, get_crisis

func _ready():
	randomize()
	set_pos(Vector2(rand_range(20, 40), rand_range(20,40)))
	if _crisis != null:
		init()

func init():
	set_title(_crisis.name.capitalize())
	get_node("Text").set_bbcode(_crisis.text)
	get_node("Picture").set_texture(load(str("res://Sprites/", _crisis.name, ".png")))
	
	var effect_text = "Sans effet"
	if _crisis.has("effects"):
		effect_text = "[b]Effets[/b] :\n"
		for effect in _crisis.effects:
			var thing_to_decrease
			if effect.has("gauge"):
				thing_to_decrease = effect.gauge
			else:
				thing_to_decrease = effect.ressource
			effect_text = str(effect_text, "    ", effect.apply, " ", Global.translate(thing_to_decrease), " / tour\n")
	
	get_node("Effects").set_bbcode(effect_text)
	
	var cost_text = "Aucun coût"
	if _crisis.has("resolution"):
		cost_text = "[b]Coûts de résolution[/b] :\n"
		for cost in _crisis.resolution:
			cost_text = str(cost_text, "    ", cost.apply, " ", Global.translate(cost.ressource), "\n")
	get_node("ResolutionCosts").set_bbcode(cost_text)
	
	if _crisis.has("is_consequence") and _crisis.is_consequence:
		get_node("Procrastinate").set_text(["J'ai dit : PLUS TARD", "Mh mh...", "Je suis déjà assez occupé"][randi()%3])
	
	update()

func update_ui():
	if !Global.ship.has_resources_to_resolve(_crisis):
		get_node("Resolve").set_text("Pas assez de ressources...")
		get_node("Resolve").set_disabled(true)

func set_crisis(crisis):
	_crisis = crisis
	init()
	update_ui()

func get_crisis():
	return _crisis

func resolve():
	Global.ship.resolve_crisis(_crisis)
	queue_free()

func _on_Resolve_pressed():
	resolve()

func _on_Procrastinate_pressed():
	hide()

func pop():
	get_node("AnimationPlayer").play("Pop")
	show()