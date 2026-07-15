extends Node

# BrainTotDatabase - Base de dados de BrainTots
class_name BrainTotDatabase

var braintots_data: Dictionary = {}
var type_data: Dictionary = {}

func _ready():
	_load_braintots_data()
	_load_type_data()

# Carregar dados de BrainTots
func _load_braintots_data() -> void:
	braintots_data = {
		1: {
			"name": "Brainion",
			"type": "Mental",
			"base_hp": 45,
			"base_attack": 49,
			"base_defense": 49,
			"base_sp_attack": 65,
			"base_sp_defense": 65,
			"base_speed": 45,
			"evolution_id": 2,
			"description": "Um pequeno BrainTot com poder mental"
		},
		2: {
			"name": "Cerebrex",
			"type": "Mental",
			"base_hp": 65,
			"base_attack": 75,
			"base_defense": 70,
			"base_sp_attack": 100,
			"base_sp_defense": 80,
			"base_speed": 60,
			"evolution_id": 3,
			"description": "Evolução de Brainion com poderes mentais aumentados"
		},
		3: {
			"name": "Synapsion",
			"type": "Mental",
			"base_hp": 80,
			"base_attack": 95,
			"base_defense": 85,
			"base_sp_attack": 120,
			"base_sp_defense": 95,
			"base_speed": 75,
			"evolution_id": 0,
			"description": "Forma final de Brainion, um verdadeiro mestre mental"
		},
		4: {
			"name": "Flamebrain",
			"type": "Fogo",
			"base_hp": 52,
			"base_attack": 64,
			"base_defense": 43,
			"base_sp_attack": 80,
			"base_sp_defense": 50,
			"base_speed": 65,
			"evolution_id": 5,
			"description": "Um BrainTot que controla chamas"
		},
		5: {
			"name": "Infernotot",
			"type": "Fogo",
			"base_hp": 75,
			"base_attack": 89,
			"base_defense": 72,
			"base_sp_attack": 110,
			"base_sp_defense": 80,
			"base_speed": 86,
			"evolution_id": 0,
			"description": "Forma evoluída de Flamebrain, domina as chamas"
		}
	}

# Carregar dados de tipos
func _load_type_data() -> void:
	type_data = {
		"Mental": {
			"color": Color.BLUE,
			"weaknesses": ["Sombra"],
			"resistances": ["Mental", "Psíquico"]
		},
		"Fogo": {
			"color": Color.RED,
			"weaknesses": ["Água", "Terra"],
			"resistances": ["Fogo", "Metal"]
		},
		"Água": {
			"color": Color.CYAN,
			"weaknesses": ["Eletricidade", "Terra"],
			"resistances": ["Água", "Gelo"]
		}
	}

# Obter dados de um BrainTot
func get_braintot_data(braintot_id: int) -> Dictionary:
	return braintots_data.get(braintot_id, {})

# Obter dados de tipo
func get_type_data(type_name: String) -> Dictionary:
	return type_data.get(type_name, {})
