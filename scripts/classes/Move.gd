extends Node

# Move - Classe de movimento/ataque
class_name Move

var move_name: String
var move_type: String
var power: int
var accuracy: int
var pp: int  # Power Points
var description: String
var priority: int = 0
var effect: String = ""  # Efeito especial do movimento

func _init(name: String, type: String, power: int, accuracy: int, pp: int, desc: String = "") -> void:
	move_name = name
	move_type = type
	self.power = power
	self.accuracy = accuracy
	self.pp = pp
	description = desc

# Usar o movimento
func use_move(attacker: BrainTot, defender: BrainTot) -> int:
	if pp <= 0:
		return 0
	
	pp -= 1
	
	var base_damage = power
	var attack_stat = attacker.attack if move_type == "Físico" else attacker.sp_attack
	var defense_stat = defender.defense if move_type == "Físico" else defender.sp_defense
	
	var damage = int((((2 * attacker.level / 5.0 + 2) * base_damage * (attack_stat / defense_stat)) / 50.0 + 2) * (randf_range(85, 100) / 100.0))
	
	if randf() * 100 > accuracy:
		return 0
	
	return damage
