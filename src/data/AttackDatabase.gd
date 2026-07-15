# AttackDatabase.gd
# Banco de dados com todos os ataques do jogo

class_name AttackDatabase

static var attacks: Dictionary = {
	"brain_beam": {
		"id": 1,
		"name": "Brain Beam",
		"type": "Mental",
		"power": 75,
		"accuracy": 100,
		"pp": 10,
		"description": "Um raio psíquico potente que ataca a mente do oponente.",
		"category": "special"
	},
	"fire_blaster_67": {
		"id": 2,
		"name": "Fire Blaster 67",
		"type": "Fire",
		"power": 85,
		"accuracy": 100,
		"pp": 8,
		"description": "Um ataque de fogo devastador inspirado em memes. 67 pontos de potência extra.",
		"category": "special"
	},
	"sigma_punch": {
		"id": 3,
		"name": "Sigma Punch",
		"type": "Fighting",
		"power": 80,
		"accuracy": 100,
		"pp": 12,
		"description": "Um soco supremo que carrega toda a energia sigma do atacante.",
		"category": "physical"
	},
	"deep_fry": {
		"id": 4,
		"name": "Deep Fry",
		"type": "Fire",
		"power": 65,
		"accuracy": 85,
		"pp": 15,
		"description": "Fritar Supremo! Um ataque que frita o alvo completamente.",
		"category": "special"
	},
	"cringe": {
		"id": 5,
		"name": "Cringe",
		"type": "Normal",
		"power": 50,
		"accuracy": 100,
		"pp": 20,
		"description": "O inimigo fica tão envergonhado que tem sua defesa reduzida.",
		"category": "special"
	},
	"icy_blades": {
		"id": 6,
		"name": "Icy Blades",
		"type": "Ice",
		"power": 70,
		"accuracy": 100,
		"pp": 12,
		"description": "Lâminas de gelo afiadas que cortam o inimigo.",
		"category": "physical"
	},
	"thunder_strike": {
		"id": 7,
		"name": "Thunder Strike",
		"type": "Electric",
		"power": 80,
		"accuracy": 100,
		"pp": 10,
		"description": "Um raio devastador que atinge o oponente com força total.",
		"category": "special"
	},
	"psi_wave": {
		"id": 8,
		"name": "Psi Wave",
		"type": "Mental",
		"power": 60,
		"accuracy": 100,
		"pp": 15,
		"description": "Ondas psíquicas que confundem o inimigo.",
		"category": "special"
	}
}

static func get_attack(attack_id: String) -> Dictionary:
	"""Retorna os dados de um ataque pelo ID"""
	return attacks.get(attack_id, {})

static func get_all_attacks() -> Array:
	"""Retorna lista de todos os ataques"""
	return attacks.values()
