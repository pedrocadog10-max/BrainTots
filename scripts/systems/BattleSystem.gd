extends Node

# BattleSystem - Sistema de batalha por turnos
class_name BattleSystem

var player_braintot: BrainTot
var enemy_braintot: BrainTot
var battle_log: Array[String] = []
var current_turn: int = 0
var battle_active: bool = false

signal turn_ended(attacker_name: String, damage: int)
signal battle_ended(victory: bool)

func start_battle(player: BrainTot, enemy: BrainTot) -> void:
	player_braintot = player
	enemy_braintot = enemy
	battle_active = true
	current_turn = 0
	battle_log.clear()
	
	add_log("Batalha iniciada!")
	add_log("%s vs %s" % [player_braintot.braintot_name, enemy_braintot.braintot_name])

func player_attack(move_index: int) -> void:
	if not battle_active or not player_braintot.is_alive():
		return
	
	if move_index >= len(player_braintot.moves):
		return
	
	var move = player_braintot.moves[move_index]
	var damage = move.use_move(player_braintot, enemy_braintot)
	
	enemy_braintot.take_damage(damage)
	add_log("%s usou %s! (%d de dano)" % [player_braintot.braintot_name, move.move_name, damage])
	turn_ended.emit(player_braintot.braintot_name, damage)
	
	if not enemy_braintot.is_alive():
		end_battle(true)
		return
	
	enemy_turn()

func enemy_turn() -> void:
	if not battle_active or not enemy_braintot.is_alive():
		return
	
	var move_index = randi() % len(enemy_braintot.moves)
	var move = enemy_braintot.moves[move_index]
	var damage = move.use_move(enemy_braintot, player_braintot)
	
	player_braintot.take_damage(damage)
	add_log("%s usou %s! (%d de dano)" % [enemy_braintot.braintot_name, move.move_name, damage])
	turn_ended.emit(enemy_braintot.braintot_name, damage)
	
	if not player_braintot.is_alive():
		end_battle(false)

func end_battle(victory: bool) -> void:
	battle_active = false
	
	if victory:
		add_log("%s venceu a batalha!" % player_braintot.braintot_name)
		player_braintot.gain_experience(50)
	else:
		add_log("%s foi derrotado!" % player_braintot.braintot_name)
	
	battle_ended.emit(victory)

func add_log(message: String) -> void:
	battle_log.append(message)

func get_battle_log() -> Array[String]:
	return battle_log
