# BrainTotDatabase.gd
# Banco de dados com todos os BrainTots disponíveis no jogo

class_name BrainTotDatabase

static var braintots: Dictionary = {
	"brainy": {
		"id": 1,
		"name": "Brainy",
		"type": "Mental",
		"description": "Um pequeno cerebro luminoso com poderes psíquicos.",
		"hp": 35,
		"attack": 40,
		"defense": 40,
		"sp_attack": 65,
		"sp_defense": 50,
		"speed": 45,
		"ability": "Mind Power",
		"moves": ["Brain Beam", "Psi Wave"],
		"evolution": "cerebrix",
		"evolution_level": 16
	},
	"cerebrix": {
		"id": 2,
		"name": "Cerebrix",
		"type": "Mental",
		"description": "Evolução de Brainy. Um cérebro gigante com poderes psíquicos devastadores.",
		"hp": 60,
		"attack": 70,
		"defense": 70,
		"sp_attack": 120,
		"sp_defense": 80,
		"speed": 75,
		"ability": "Mind Master",
		"moves": ["Brain Beam", "Psi Wave", "Psychic Surge"],
		"evolution": "",
		"evolution_level": 0
	},
	"flamespark": {
		"id": 3,
		"name": "FlameSpark",
		"type": "Fire",
		"description": "Uma pequena chama dançante com olhos brilhantes.",
		"hp": 40,
		"attack": 55,
		"defense": 35,
		"sp_attack": 70,
		"sp_defense": 45,
		"speed": 65,
		"ability": "Blaze",
		"moves": ["Fire Blaster 67", "Ember"],
		"evolution": "inferno",
		"evolution_level": 16
	},
	"inferno": {
		"id": 4,
		"name": "Inferno",
		"type": "Fire",
		"description": "Evolução de FlameSpark. Um inferno controlado em forma de criatura.",
		"hp": 65,
		"attack": 95,
		"defense": 60,
		"sp_attack": 110,
		"sp_defense": 75,
		"speed": 100,
		"ability": "Blaze Master",
		"moves": ["Fire Blaster 67", "Ember", "Flame Burst"],
		"evolution": "",
		"evolution_level": 0
	},
	"frostbite": {
		"id": 5,
		"name": "FrostBite",
		"type": "Ice",
		"description": "Um cristal de gelo animado que congela tudo ao seu redor.",
		"hp": 40,
		"attack": 50,
		"defense": 60,
		"sp_attack": 65,
		"sp_defense": 60,
		"speed": 40,
		"ability": "Frost",
		"moves": ["Icy Blades", "Freeze Ray"],
		"evolution": "glaciax",
		"evolution_level": 16
	},
	"boltwhisk": {
		"id": 6,
		"name": "BoltWhisk",
		"type": "Electric",
		"description": "Uma pequena bola de energia elétrica que pulsa constantemente.",
		"hp": 35,
		"attack": 40,
		"defense": 45,
		"sp_attack": 75,
		"sp_defense": 50,
		"speed": 85,
		"ability": "Spark",
		"moves": ["Thunder Strike", "Spark"],
		"evolution": "voltstream",
		"evolution_level": 16
	},
	"sigmapunch": {
		"id": 7,
		"name": "SigmaPunch",
		"type": "Fighting",
		"description": "Um pequeno luttador com braços gigantes. Um meme vivo.",
		"hp": 60,
		"attack": 95,
		"defense": 55,
		"sp_attack": 40,
		"sp_defense": 50,
		"speed": 60,
		"ability": "Sigma Mode",
		"moves": ["Sigma Punch", "Strong Arm"],
		"evolution": "alphaking",
		"evolution_level": 20
	},
	"memeoid": {
		"id": 8,
		"name": "Memeoid",
		"type": "Normal",
		"description": "Uma criatura feita de puro meme. Sua eficácia é incalculável.",
		"hp": 50,
		"attack": 85,
		"defense": 70,
		"sp_attack": 60,
		"sp_defense": 65,
		"speed": 75,
		"ability": "Meme Power",
		"moves": ["Deep Fry", "Cringe"],
		"evolution": "megameme",
		"evolution_level": 25
	}
}

static func get_braintot(braintot_id: String) -> Dictionary:
	"""Retorna os dados de um BrainTot pelo ID"""
	return braintots.get(braintot_id, {})

static func get_all_braintots() -> Array:
	"""Retorna lista de todos os BrainTots"""
	return braintots.values()

static func get_braintot_by_name(name: String) -> Dictionary:
	"""Busca um BrainTot pelo nome"""
	for braintot_data in braintots.values():
		if braintot_data["name"].to_lower() == name.to_lower():
			return braintot_data
	return {}
