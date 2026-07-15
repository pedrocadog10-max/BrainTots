extends Node

# AudioManager - Gerencia áudio e música
class_name AudioManager

var music_player: AudioStreamPlayer
var sfx_player: AudioStreamPlayer
var current_music: String = ""

func _ready():
	music_player = AudioStreamPlayer.new()
	music_player.bus = &"Music"
	add_child(music_player)
	
	sfx_player = AudioStreamPlayer.new()
	sfx_player.bus = &"SFX"
	add_child(sfx_player)

# Reproduzir música
func play_music(music_path: String, loop: bool = true) -> void:
	if current_music == music_path:
		return
	
	current_music = music_path
	var audio_stream = load(music_path)
	
	if audio_stream:
		music_player.stream = audio_stream
		music_player.play()

# Reproduzir SFX
func play_sfx(sfx_path: String) -> void:
	var audio_stream = load(sfx_path)
	
	if audio_stream:
		sfx_player.stream = audio_stream
		sfx_player.play()

# Parar música
func stop_music() -> void:
	music_player.stop()
	current_music = ""

# Parar SFX
func stop_sfx() -> void:
	sfx_player.stop()
