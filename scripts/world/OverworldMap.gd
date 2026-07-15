extends Node2D

# OverworldMap - Mapa do mundo
class_name OverworldMap

var player: Player
var npc_locations: Dictionary = {}
var items_in_world: Array[Node2D] = []

func _ready():
	# Carregar ou criar jogador
	if GameManager.current_player:
		player = GameManager.current_player
	else:
		player = Player.new()
		player.player_name = "Trainer"
		add_child(player)
		GameManager.current_player = player
	
	# Inicializar NPCs
	_spawn_npcs()
	
	# Carregar música do mundo
	AudioManager.play_music("res://assets/audio/music/overworld.mp3")

func _spawn_npcs() -> void:
	# Criar NPCs em diferentes locais
	npc_locations["Cidade Central"] = Vector2(500, 300)
	npc_locations["Floresta"] = Vector2(200, 500)
	npc_locations["Praia"] = Vector2(800, 200)

# Interagir com NPC
func interact_with_npc(npc_name: String) -> void:
	if npc_name in npc_locations:
		print("Interagindo com %s" % npc_name)

# Salvar jogo automaticamente
func _on_autosave_timer_timeout() -> void:
	SaveManager.save_game(player, 1)
