# AudioManager.gd
# Gerencia efeitos sonoros e música de fundo

extends Node

class_name AudioManager

var background_music_player: AudioStreamPlayer
var sfx_players: Array[AudioStreamPlayer] = []
var music_volume: float = 0.8
var sfx_volume: float = 0.8
var is_music_playing: bool = false

func _ready() -> void:
	# Cria player de música
	background_music_player = AudioStreamPlayer.new()
	add_child(background_music_player)
	background_music_player.name = "MusicPlayer"
	
	# Cria players de efeitos sonoros
	for i in range(4):
		var sfx_player = AudioStreamPlayer.new()
		add_child(sfx_player)
		sfx_player.name = "SFXPlayer_%d" % i
		sfx_players.append(sfx_player)
	
	print("[AudioManager] Inicializado")

func play_music(music_path: String, volume: float = 0.8) -> void:
	"""Toca música de fundo"""
	if ResourceLoader.exists(music_path):
		background_music_player.stream = load(music_path)
		background_music_player.volume_db = linear2db(volume)
		background_music_player.play()
		is_music_playing = true
		music_volume = volume
	else:
		print("[AudioManager] Arquivo de música não encontrado: ", music_path)

func stop_music() -> void:
	"""Para a música de fundo"""
	background_music_player.stop()
	is_music_playing = false

func play_sfx(sfx_path: String, volume: float = 0.8) -> void:
	"""Toca um efeito sonoro"""
	if not ResourceLoader.exists(sfx_path):
		print("[AudioManager] Arquivo de SFX não encontrado: ", sfx_path)
		return
	
	# Encontra o primeiro player disponível
	for player in sfx_players:
		if not player.playing:
			player.stream = load(sfx_path)
			player.volume_db = linear2db(volume)
			player.play()
			return

func set_music_volume(volume: float) -> void:
	"""Altera o volume da música"""
	music_volume = clamp(volume, 0.0, 1.0)
	background_music_player.volume_db = linear2db(music_volume)

func set_sfx_volume(volume: float) -> void:
	"""Altera o volume dos efeitos sonoros"""
	sfx_volume = clamp(volume, 0.0, 1.0)
	for player in sfx_players:
		player.volume_db = linear2db(sfx_volume)
