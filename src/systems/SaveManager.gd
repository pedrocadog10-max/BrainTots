# SaveManager.gd
# Gerencia salvamento e carregamento do progresso do jogo

extends Node

class_name SaveManager

const SAVE_PATH: String = "user://braintots_saves/"
const AUTO_SAVE_FILE: String = "autosave.json"
const SAVE_INTERVAL: float = 120.0  # Salva a cada 2 minutos

var save_timer: float = 0.0
var is_saving: bool = false

func _ready() -> void:
	# Cria o diretório de saves se não existir
	if not DirAccess.dir_exists_absolute(SAVE_PATH):
		DirAccess.make_abs_absolute(SAVE_PATH)
	
	set_process(true)
	print("[SaveManager] Inicializado")

func _process(delta: float) -> void:
	# Auto-save a cada SAVE_INTERVAL segundos
	save_timer += delta
	if save_timer >= SAVE_INTERVAL:
		auto_save()
		save_timer = 0.0

func auto_save() -> void:
	"""Salva o jogo automaticamente"""
	if is_saving:
		return
	
	is_saving = true
	save_game("autosave")
	is_saving = false

func save_game(slot_name: String = "save_1") -> bool:
	"""Salva o progresso do jogo em um slot"""
	var save_data: Dictionary = {
		"timestamp": Time.get_ticks_msec(),
		"player": GameManager.get_player_data(),
		"playtime": get_playtime()
	}
	
	var file_path: String = SAVE_PATH + slot_name + ".json"
	var json_string: String = JSON.stringify(save_data)
	
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	if file == null:
		print("[SaveManager] Erro ao salvar: ", file.get_error())
		return false
	
	file.store_string(json_string)
	print("[SaveManager] Jogo salvo em: ", slot_name)
	return true

func load_game(slot_name: String = "autosave") -> bool:
	"""Carrega o progresso do jogo de um slot"""
	var file_path: String = SAVE_PATH + slot_name + ".json"
	
	if not FileAccess.file_exists(file_path):
		print("[SaveManager] Arquivo de save não encontrado: ", file_path)
		return false
	
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file == null:
		print("[SaveManager] Erro ao carregar: ", file.get_error())
		return false
	
	var json_string: String = file.get_as_text()
	var json = JSON.new()
	var error = json.parse(json_string)
	
	if error != OK:
		print("[SaveManager] Erro ao parsear JSON")
		return false
	
	var save_data: Dictionary = json.data
	GameManager.load_player_data(save_data.get("player", {}))
	
	print("[SaveManager] Jogo carregado de: ", slot_name)
	return true

func has_save(slot_name: String = "autosave") -> bool:
	"""Verifica se existe um save em um slot"""
	var file_path: String = SAVE_PATH + slot_name + ".json"
	return FileAccess.file_exists(file_path)

func get_playtime() -> float:
	"""Retorna o tempo de jogo em segundos"""
	return Time.get_ticks_msec() / 1000.0

func delete_save(slot_name: String) -> bool:
	"""Deleta um arquivo de save"""
	var file_path: String = SAVE_PATH + slot_name + ".json"
	var dir = DirAccess.open(SAVE_PATH)
	
	if dir == null:
		return false
	
	return dir.remove(file_path) == OK

func get_all_saves() -> Array:
	"""Retorna lista de todos os saves disponíveis"""
	var saves: Array = []
	var dir = DirAccess.open(SAVE_PATH)
	
	if dir == null:
		return saves
	
	dir.list_dir_begin()
	var file_name: String = dir.get_next()
	
	while file_name != "":
		if file_name.ends_with(".json"):
			saves.append(file_name.trim_suffix(".json"))
		file_name = dir.get_next()
	
	return saves
