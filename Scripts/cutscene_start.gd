extends Node2D

@onready var video_player: VideoStreamPlayer = $VideoStreamPlayer
@onready var button: Button = $Button
@onready var end_sprite: Sprite2D = $EndSprite

var videos = [
			 "res://Resources/Video/gga.ogv",
			 "res://Resources/Video/gga1.ogv",
			 "res://Resources/Video/gga2.ogv"
			 ]

var end_sprites = [
				  "res://Resources/Video/0end.png",
				  "res://Resources/Video/1end.png",
				  "res://Resources/Video/2end.png"
				  ]

var current_video_index = 0
var last_video_index = videos.size() - 1

func _ready() -> void:
	load_and_play_video(current_video_index)
	button.hide()
	end_sprite.hide()
	button.connect("pressed", Callable(self, "_on_button_pressed"))

func load_and_play_video(index: int) -> void:
	var video_stream = ResourceLoader.load(videos[index]) as VideoStream
	if video_stream:
		video_player.stream = video_stream
		video_player.play()
		video_player.set_paused(false)
		end_sprite.hide()
		button.hide()

func _on_button_pressed() -> void:
	if current_video_index == last_video_index:
		get_tree().change_scene_to_file("res://Scenes/Stages/Stage_1.tscn")
	if video_player.is_playing():
		video_player.stop()
		video_player.set_paused(true)
	current_video_index = (current_video_index + 1) % videos.size()
	load_and_play_video(current_video_index)

func _on_video_finished() -> void:
	video_player.stop()
	video_player.set_paused(true)
	end_sprite.texture = load(end_sprites[current_video_index])
	end_sprite.show()
	button.show()

	

func _input(event: InputEvent) -> void:
	if event is InputEventKey or event is InputEventMouseButton:
		if end_sprite.visible and button.visible:
			_on_button_pressed()
