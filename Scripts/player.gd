extends CharacterBody2D
var speed: float = 70.0
var camera_zoom: Vector2 = Vector2(10, 10)

func _ready() -> void:
	$CameraPlayer.set_zoom(camera_zoom)

func move_character_body(delta: float) -> void:
	var velocity_player: Vector2 = Vector2()

	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite2D.flip_h = false
		velocity_player.x += 1
	#		$AnimatedSprite2D.play("right")
	if Input.is_action_pressed("ui_left"):
		$AnimatedSprite2D.flip_h = true
		#		$AnimatedSprite2D.play("right")
		velocity_player.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity_player.y += 1
	#		$AnimatedSprite2D.play("down")
	if Input.is_action_pressed("ui_up"):
		velocity_player.y -= 1
	#		$AnimatedSprite2D.play("up")

	if velocity_player.length() == 0:
		pass
	#		$AnimatedSprite2D.play("idle")

	velocity_player = velocity_player.normalized() * speed * delta * 100.0
	set_velocity(velocity_player)
	move_and_slide()

func _process(delta: float) -> void:
	move_character_body(delta)