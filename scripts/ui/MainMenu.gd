extends CanvasLayer

# MainMenu - Menu principal do jogo
class_name MainMenu

var menu_container: VBoxContainer
var title_label: Label
var continue_button: Button
var new_game_button: Button
var settings_button: Button
var quit_button: Button

func _ready():
	_create_ui()
	AudioManager.play_music("res://assets/audio/music/menu.mp3")

func _create_ui() -> void:
	# Criar container principal
	menu_container = VBoxContainer.new()
	menu_container.anchor_left = 0.5
	menu_container.anchor_top = 0.5
	menu_container.offset_left = -100
	menu_container.offset_top = -150
	set_anchors_preset(Control.PRESET_CENTER)
	add_child(menu_container)
	
	# Título
	title_label = Label.new()
	title_label.text = "BrainTots"
	title_label.add_theme_font_size_override("font_size", 64)
	menu_container.add_child(title_label)
	
	# Espaço
	var spacer = Control.new()
	spacer.custom_minimum_size = Vector2(0, 30)
	menu_container.add_child(spacer)
	
	# Botão Novo Jogo
	new_game_button = Button.new()
	new_game_button.text = "Novo Jogo"
	new_game_button.custom_minimum_size = Vector2(200, 50)
	new_game_button.pressed.connect(_on_new_game_pressed)
	menu_container.add_child(new_game_button)
	
	# Botão Continuar
	continue_button = Button.new()
	continue_button.text = "Continuar"
	continue_button.custom_minimum_size = Vector2(200, 50)
	continue_button.pressed.connect(_on_continue_pressed)
	
	# Ativar apenas se existir save
	if SaveManager.save_slot_exists(1):
		menu_container.add_child(continue_button)
	else:
		continue_button.disabled = true
	
	# Botão Configurações
	settings_button = Button.new()
	settings_button.text = "Configurações"
	settings_button.custom_minimum_size = Vector2(200, 50)
	settings_button.pressed.connect(_on_settings_pressed)
	menu_container.add_child(settings_button)
	
	# Botão Sair
	quit_button = Button.new()
	quit_button.text = "Sair"
	quit_button.custom_minimum_size = Vector2(200, 50)
	quit_button.pressed.connect(_on_quit_pressed)
	menu_container.add_child(quit_button)

func _on_new_game_pressed() -> void:
	GameManager.change_scene("res://scenes/world/OverworldMap.tscn")

func _on_continue_pressed() -> void:
	var save_data = SaveManager.load_game(1)
	if not save_data.is_empty():
		GameManager.change_scene(save_data.get("player_scene", "res://scenes/world/OverworldMap.tscn"))

func _on_settings_pressed() -> void:
	GameManager.change_scene("res://scenes/ui/SettingsMenu.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
