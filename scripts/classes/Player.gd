extends CharacterBody2D

# Player - Classe do jogador
class_name Player

@export var speed = 200.0
@export var player_name: String = "Trainer"

var level: int = 1
var experience: int = 0
var money: int = 0
var braintots: Array[BrainTot] = []
var inventory: Dictionary = {}
var current_braintot_index: int = 0
var visited_locations: Array[String] = []

var animation_player: AnimationPlayer
var sprite: Sprite2D

func _ready():
	add_to_group("player")
	GameManager.current_player = self
	
	# Criar sprite básico
	sprite = Sprite2D.new()
	sprite.texture = load("res://assets/sprites/player.png")
	add_child(sprite)

func _physics_process(delta):
	if GameManager.is_in_battle:
		return
	
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed
	move_and_slide()

# Capturar um BrainTot
func capture_braintot(braintot: BrainTot) -> bool:
	if len(braintots) < 6:
		braintots.append(braintot)
		braintot.captured_at = Time.get_ticks_msec()
		return true
	return false

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

# Ganhar dinheiro
func gain_money(amount: int) -> void:
	money += amount

# Adicionar item ao inventário
func add_item(item_name: String, quantity: int = 1) -> void:
	if item_name in inventory:
		inventory[item_name] += quantity
	else:
		inventory[item_name] = quantity

# Remover item do inventário
func remove_item(item_name: String, quantity: int = 1) -> bool:
	if item_name in inventory and inventory[item_name] >= quantity:
		inventory[item_name] -= quantity
		if inventory[item_name] <= 0:
			inventory.erase(item_name)
		return true
	return false

# Obter BrainTot atual
func get_current_braintot() -> BrainTot:
	if current_braintot_index < len(braintots):
		return braintots[current_braintot_index]
	return null

# Trocar BrainTot
func switch_braintot(index: int) -> bool:
	if index >= 0 and index < len(braintots):
		current_braintot_index = index
		return true
	return false

# Visitar localização
func visit_location(location_name: String) -> void:
	if not location_name in visited_locations:
		visited_locations.append(location_name)
