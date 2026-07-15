extends Node

# Item - Classe base para itens
class_name Item

enum ItemType { CONSUMABLE, POKEBALL, KEY_ITEM, EQUIPMENT, MATERIAL }

var item_name: String
var item_type: ItemType
var description: String
var price: int
var quantity: int = 1

func _init(name: String, type: ItemType, desc: String = "", price_value: int = 0) -> void:
	item_name = name
	item_type = type
	description = desc
	price = price_value

# Usar item
func use_item(target: Node) -> bool:
	match item_type:
		ItemType.CONSUMABLE:
			return use_consumable(target)
		ItemType.POKEBALL:
			return use_pokeball(target)
		_:
			return false

func use_consumable(target: Node) -> bool:
	print("Usando %s" % item_name)
	return true

func use_pokeball(target: Node) -> bool:
	var catch_rate = randf() * 100
	if catch_rate > 50:  # 50% de taxa de captura
		print("Captura bem-sucedida!")
		return true
	else:
		print("Captura falhou!")
		return false
