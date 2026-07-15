# ItemDatabase.gd
# Banco de dados com todos os itens do jogo

class_name ItemDatabase

static var items: Dictionary = {
	"potion": {
		"id": 1,
		"name": "Potion",
		"description": "Restaura 20 HP.",
		"type": "healing",
		"value": 50,
		"effect": {"hp_restore": 20}
	},
	"super_potion": {
		"id": 2,
		"name": "Super Potion",
		"description": "Restaura 60 HP.",
		"type": "healing",
		"value": 150,
		"effect": {"hp_restore": 60}
	},
	"antidote": {
		"id": 3,
		"name": "Antidote",
		"description": "Remove envenenamento.",
		"type": "status",
		"value": 100,
		"effect": {"remove_poison": true}
	},
	"pokeball": {
		"id": 4,
		"name": "PokéBall",
		"description": "Captura um BrainTot selvagem.",
		"type": "capture",
		"value": 200,
		"effect": {"capture_rate": 0.5}
	},
	"ultra_ball": {
		"id": 5,
		"name": "Ultra Ball",
		"description": "Captura um BrainTot selvagem com taxa mais alta.",
		"type": "capture",
		"value": 500,
		"effect": {"capture_rate": 0.8}
	}
}

static func get_item(item_id: String) -> Dictionary:
	"""Retorna os dados de um item pelo ID"""
	return items.get(item_id, {})

static func get_all_items() -> Array:
	"""Retorna lista de todos os itens"""
	return items.values()
