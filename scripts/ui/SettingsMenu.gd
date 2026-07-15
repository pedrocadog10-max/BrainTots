extends CanvasLayer

# SettingsMenu - Menu de configurações
class_name SettingsMenu

var settings_container: VBoxContainer
var music_toggle: CheckButton
var sfx_toggle: CheckButton
var volume_slider: HSlider
var back_button: Button

func _ready():
	_create_ui()

func _create_ui() -> void:
	settings_container = VBoxContainer.new()
	settings_container.anchor_left = 0.5
	settings_container.anchor_top = 0.5
	settings_container.offset_left = -150
	settings_container.offset_top = -100
	add_child(settings_container)
	
	# Título
	var title = Label.new()
	title.text = "Configurações"
	title.add_theme_font_size_override("font_size", 48)
	settings_container.add_child(title)
	
	# Música
	music_toggle = CheckButton.new()
	music_toggle.text = "Música"
	music_toggle.button_pressed = GameManager.music_enabled
	music_toggle.pressed.connect(_on_music_toggled)
	settings_container.add_child(music_toggle)
	
	# SFX
	sfx_toggle = CheckButton.new()
	sfx_toggle.text = "Efeitos Sonoros"
	sfx_toggle.button_pressed = GameManager.sfx_enabled
	sfx_toggle.pressed.connect(_on_sfx_toggled)
	settings_container.add_child(sfx_toggle)
	
	# Volume
	var volume_label = Label.new()
	volume_label.text = "Volume: %.0f%%" % (GameManager.volume_level * 100)
	settings_container.add_child(volume_label)
	
	volume_slider = HSlider.new()
	volume_slider.min_value = 0
	volume_slider.max_value = 1
	volume_slider.step = 0.1
	volume_slider.value = GameManager.volume_level
	volume_slider.value_changed.connect(_on_volume_changed.bindv([volume_label]))
	settings_container.add_child(volume_slider)
	
	# Espaço
	var spacer = Control.new()
	spacer.custom_minimum_size = Vector2(0, 30)
	settings_container.add_child(spacer)
	
	# Botão Voltar
	back_button = Button.new()
	back_button.text = "Voltar"
	back_button.custom_minimum_size = Vector2(200, 50)
	back_button.pressed.connect(_on_back_pressed)
	settings_container.add_child(back_button)

func _on_music_toggled() -> void:
	GameManager.set_music_enabled(music_toggle.button_pressed)

func _on_sfx_toggled() -> void:
	GameManager.set_sfx_enabled(sfx_toggle.button_pressed)

func _on_volume_changed(value: float, label: Label) -> void:
	GameManager.set_volume_level(value)
	label.text = "Volume: %.0f%%" % (value * 100)

func _on_back_pressed() -> void:
	GameManager.change_scene("res://scenes/ui/MainMenu.tscn")
