extends Node2D

@onready var video_player: VideoStreamPlayer = $VideoStreamPlayer
@onready var sprite: Sprite2D = $Sprite

func _ready() -> void:
	sprite.hide()

	await get_tree().create_timer(0.5).timeout
	start_video()

func start_video() -> void:
	if video_player:
		video_player.play()
		video_player.finished.connect(_on_video_finished)

func _on_video_finished() -> void:
	sprite.show()
