extends Node

# BrainTot - Classe base de um BrainTot
class_name BrainTot

var braintot_id: int
var braintot_name: String
var level: int = 1
var experience: int = 0
var braintot_type: String

var hp: int
var max_hp: int
var attack: int
var defense: int
var sp_attack: int
var sp_defense: int
var speed: int

var ability: String
var moves: Array[String] = []
var captured_at: int = 0
var is_evolved: bool = false

func _init(id: int) -> void:
	braintot_id = id
	_initialize_from_database()

func _initialize_from_database() -> void:
	var data = BrainTotDatabase.get_braintot_data(braintot_id)
	
	if data.is_empty():
		return
	
	braintot_name = data.get("name", "Unknown")
	braintot_type = data.get("type", "Normal")
	max_hp = data.get("base_hp", 50)
	hp = max_hp
	attack = data.get("base_attack", 50)
	defense = data.get("base_defense", 50)
	sp_attack = data.get("base_sp_attack", 50)
	sp_defense = data.get("base_sp_defense", 50)
	speed = data.get("base_speed", 50)

# Ganhar experiência
func gain_experience(amount: int) -> void:
	experience += amount
	var exp_to_level = level * 100
	
	while experience >= exp_to_level:
		experience -= exp_to_level
		level_up()

# Level up
func level_up() -> void:
	level += 1
	_update_stats()

func _update_stats() -> void:
	var multiplier = 1.0 + (level * 0.1)
	max_hp = int(BrainTotDatabase.get_braintot_data(braintot_id).get("base_hp", 50) * multiplier)
	hp = max_hp
	attack = int(BrainTotDatabase.get_braintot_data(braintot_id).get("base_attack", 50) * multiplier)
	defense = int(BrainTotDatabase.get_braintot_data(braintot_id).get("base_defense", 50) * multiplier)
	sp_attack = int(BrainTotDatabase.get_braintot_data(braintot_id).get("base_sp_attack", 50) * multiplier)
	sp_defense = int(BrainTotDatabase.get_braintot_data(braintot_id).get("base_sp_defense", 50) * multiplier)
	speed = int(BrainTotDatabase.get_braintot_data(braintot_id).get("base_speed", 50) * multiplier)

# Sofrer dano
func take_damage(damage: int) -> void:
	hp -= damage
	if hp < 0:
		hp = 0

# Curar
func heal(amount: int) -> void:
	hp += amount
	if hp > max_hp:
		hp = max_hp

# Verificar se ainda está vivo
func is_alive() -> bool:
	return hp > 0

# Evoluir
func evolve() -> void:
	var evolution_id = BrainTotDatabase.get_braintot_data(braintot_id).get("evolution_id", 0)
	
	if evolution_id > 0:
		braintot_id = evolution_id
		is_evolved = true
		_initialize_from_database()
