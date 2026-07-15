extends Node

# SaveManager - Gerencia salvamentos do jogo
class_name SaveManager

const SAVE_PATH = "user://braintots_saves/"
const AUTO_SAVE_INTERVAL = 300.0  # 5 minutos

var auto_save_timer: Timer
var current_save_slot: int = 1

func _ready():
	if not DirAccess.dir_exists_absolute(SAVE_PATH):
		DirAccess.make_abs_absolute(SAVE_PATH)
	
	auto_save_timer = Timer.new()
	add_child(auto_save_timer)
	auto_save_timer.wait_time = AUTO_SAVE_INTERVAL
	auto_save_timer.timeout.connect(_on_auto_save_timeout)
	auto_save_timer.start()

# Salvar jogo
func save_game(player: Player, slot: int = 1) -> bool:
	var save_data = {
		"player_name": player.player_name,
		"player_level": player.level,
		"player_experience": player.experience,
		"player_position": player.global_position,
		"player_scene": GameManager.current_scene,
		"braintots": [],
		"inventory": player.inventory,
		"money": player.money,
		"timestamp": Time.get_ticks_msec()
	}
	
	# Salvar BrainTots do jogador
	for braintot in player.braintots:
		save_data["braintots"].append({
			"id": braintot.braintot_id,
			"level": braintot.level,
			"experience": braintot.experience,
			"hp": braintot.hp,
			"max_hp": braintot.max_hp,
			"captured_at": braintot.captured_at
		})
	
	var file_path = SAVE_PATH + "save_%d.json" % slot
	var json = JSON.stringify(save_data)
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	
	if file:
		file.store_string(json)
		return true
	return false

# Carregar jogo
func load_game(slot: int = 1) -> Dictionary:
	var file_path = SAVE_PATH + "save_%d.json" % slot
	
	if not FileAccess.file_exists(file_path):
		return {}
	
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file:
		var json = JSON.parse_string(file.get_as_text())
		return json if json else {}
	
	return {}

# Verificar se slot existe
func save_slot_exists(slot: int) -> bool:
	var file_path = SAVE_PATH + "save_%d.json" % slot
	return FileAccess.file_exists(file_path)

# Auto-save
func _on_auto_save_timeout() -> void:
	if GameManager.current_player:
		save_game(GameManager.current_player, 99)
