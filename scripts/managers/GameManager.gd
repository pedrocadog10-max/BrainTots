extends Node

# GameManager - Gerencia o estado global do jogo
class_name GameManager

var current_player: Player
var current_scene: String = ""
var is_in_battle: bool = false
var current_enemy: BrainTot
var current_player_braintot: BrainTot
var music_enabled: bool = true
var sfx_enabled: bool = true
var volume_level: float = 0.8

signal scene_changed(new_scene: String)
signal battle_started
signal battle_ended(victory: bool)

func _ready():
	set_multiplayer_authority(1)

# Mudar de cena
func change_scene(scene_path: String) -> void:
	current_scene = scene_path
	get_tree().change_scene_to_file(scene_path)
	scene_changed.emit(scene_path)

# Iniciar batalha
func start_battle(enemy: BrainTot, player_braintot: BrainTot) -> void:
	is_in_battle = true
	current_enemy = enemy
	current_player_braintot = player_braintot
	battle_started.emit()

func end_battle(victory: bool) -> void:
	is_in_battle = false
	battle_ended.emit(victory)

func set_music_enabled(enabled: bool) -> void:
	music_enabled = enabled

func set_sfx_enabled(enabled: bool) -> void:
	sfx_enabled = enabled

func set_volume_level(level: float) -> void:
	volume_level = clamp(level, 0.0, 1.0)
