extends CharacterBody2D

# NPC - Classe base para NPCs
class_name NPC

@export var npc_name: String = "NPC"
@export var npc_type: String = "Generic"  # Shopkeeper, Healer, Trainer, etc
@export var dialogue: Array[String] = []

var sprite: Sprite2D
var interaction_area: Area2D
var is_interacting: bool = false

func _ready():
	sprite = Sprite2D.new()
	sprite.texture = load("res://assets/sprites/npc.png")
	add_child(sprite)
	
	# Área de interação
	interaction_area = Area2D.new()
	var collision_shape = CollisionShape2D.new()
	collision_shape.shape = RectangleShape2D.new()
	collision_shape.shape.size = Vector2(50, 50)
	interaction_area.add_child(collision_shape)
	interaction_area.body_entered.connect(_on_interaction_area_entered)
	interaction_area.body_exited.connect(_on_interaction_area_exited)
	add_child(interaction_area)

func _on_interaction_area_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if Input.is_action_just_pressed("ui_accept"):
			interact()

func _on_interaction_area_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_interacting = false

func interact() -> void:
	match npc_type:
		"Shopkeeper":
			open_shop()
		"Healer":
			heal_player()
		"Trainer":
			start_battle()
		_:
			show_dialogue()

func show_dialogue() -> void:
	if dialogue.size() > 0:
		print("%s: %s" % [npc_name, dialogue[randi() % dialogue.size()]])

func open_shop() -> void:
	print("Abrindo loja de %s" % npc_name)

func heal_player() -> void:
	print("%s está curando seus BrainTots" % npc_name)

func start_battle() -> void:
	print("Iniciando batalha com %s" % npc_name)
