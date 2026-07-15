extends CanvasLayer

# BattleUI - Interface da batalha
class_name BattleUI

var player_hp_bar: ProgressBar
var enemy_hp_bar: ProgressBar
var player_name_label: Label
var enemy_name_label: Label
var moves_container: VBoxContainer
var move_buttons: Array[Button] = []
var battle_log: Label

func _ready():
	_create_battle_ui()

func _create_battle_ui() -> void:
	# Nomes dos BrainTots
	enemy_name_label = Label.new()
	enemy_name_label.position = Vector2(100, 50)
	enemy_name_label.text = GameManager.current_enemy.braintot_name
	add_child(enemy_name_label)
	
	player_name_label = Label.new()
	player_name_label.position = Vector2(1100, 350)
	player_name_label.text = GameManager.current_player_braintot.braintot_name
	add_child(player_name_label)
	
	# Barras de HP
	enemy_hp_bar = ProgressBar.new()
	enemy_hp_bar.position = Vector2(100, 100)
	enemy_hp_bar.custom_minimum_size = Vector2(200, 30)
	enemy_hp_bar.max_value = GameManager.current_enemy.max_hp
	enemy_hp_bar.value = GameManager.current_enemy.hp
	add_child(enemy_hp_bar)
	
	player_hp_bar = ProgressBar.new()
	player_hp_bar.position = Vector2(1000, 400)
	player_hp_bar.custom_minimum_size = Vector2(200, 30)
	player_hp_bar.max_value = GameManager.current_player_braintot.max_hp
	player_hp_bar.value = GameManager.current_player_braintot.hp
	add_child(player_hp_bar)
	
	# Log de batalha
	battle_log = Label.new()
	battle_log.position = Vector2(400, 500)
	battle_log.text = "Batalha iniciada!"
	add_child(battle_log)
	
	# Container de movimentos
	moves_container = VBoxContainer.new()
	moves_container.position = Vector2(900, 500)
	add_child(moves_container)
	
	# Criar botões de movimentos
	for i in range(len(GameManager.current_player_braintot.moves)):
		var move = GameManager.current_player_braintot.moves[i]
		var button = Button.new()
		button.text = move.move_name
		button.custom_minimum_size = Vector2(150, 40)
		button.pressed.connect(_on_move_selected.bindv([i]))
		move_buttons.append(button)
		moves_container.add_child(button)

func update_hp_bars() -> void:
	enemy_hp_bar.value = GameManager.current_enemy.hp
	player_hp_bar.value = GameManager.current_player_braintot.hp

func add_log_message(message: String) -> void:
	battle_log.text = message

func _on_move_selected(move_index: int) -> void:
	pass  # Será implementado no sistema de batalha
