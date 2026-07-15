# GameManager.gd
# Sistema principal do jogo - gerencia estado global, transições de cenas e dados do jogador

extends Node

class_name GameManager

# Sinais
signal scene_changed(scene_name: String)
signal game_paused(paused: bool)
signal player_updated

# Estado do jogo
var is_paused: bool = false
var current_scene: String = ""
var player_data: Dictionary = {}

# Dados do jogador
var player_name: String = "Jogador"
var player_level: int = 1
var player_experience: int = 0
var player_money: int = 500
var player_position: Vector2 = Vector2.ZERO
var player_braintots: Array = []
var player_inventory: Array = []
var player_completed_missions: Array = []
var player_defeated_gyms: Array = []

func _ready() -> void:
	set_process_unhandled_input(true)
	add_to_group("persistent")
	print("[GameManager] Inicializado")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause() -> void:
	"""Alterna o estado de pausa do jogo"""
	if current_scene == "MainMenu" or current_scene == "Battle":
		return
	
	is_paused = !is_paused
	get_tree().paused = is_paused
	game_paused.emit(is_paused)

func change_scene(scene_path: String) -> void:
	"""Muda para uma nova cena"""
	current_scene = scene_path.get_file().trim_suffix(".tscn")
	get_tree().change_scene_to_file(scene_path)
	scene_changed.emit(current_scene)

func add_braintot(braintot: Dictionary) -> void:
	"""Adiciona um BrainTot ao time do jogador"""
	if player_braintots.size() < 6:
		player_braintots.append(braintot)
		player_updated.emit()


func add_experience(amount: int) -> void:
	"""Adiciona experiência ao jogador"""
	player_experience += amount
	
	# Calcula novo nível (100 XP por nível)
	var new_level = int(player_experience / 100) + 1
	if new_level > player_level:
		player_level = new_level
		print("[GameManager] Nível aumentado para: ", player_level)
	
	player_updated.emit()

func add_money(amount: int) -> void:
	"""Adiciona dinheiro ao jogador"""
	player_money += amount
	player_updated.emit()

func remove_money(amount: int) -> bool:
	"""Remove dinheiro do jogador se tiver suficiente"""
	if player_money >= amount:
		player_money -= amount
		player_updated.emit()
		return true
	return false

func get_player_data() -> Dictionary:
	"""Retorna todos os dados do jogador"""
	return {
		"name": player_name,
		"level": player_level,
		"experience": player_experience,
		"money": player_money,
		"position": player_position,
		"braintots": player_braintots,
		"inventory": player_inventory,
		"completed_missions": player_completed_missions,
		"defeated_gyms": player_defeated_gyms
	}

func load_player_data(data: Dictionary) -> void:
	"""Carrega dados do jogador de um dicionário"""
	player_name = data.get("name", "Jogador")
	player_level = data.get("level", 1)
	player_experience = data.get("experience", 0)
	player_money = data.get("money", 500)
	player_position = data.get("position", Vector2.ZERO)
	player_braintots = data.get("braintots", [])
	player_inventory = data.get("inventory", [])
	player_completed_missions = data.get("completed_missions", [])
	player_defeated_gyms = data.get("defeated_gyms", [])
	player_updated.emit()
