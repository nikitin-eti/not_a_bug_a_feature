extends CharacterBody2D

var speed: float = 50.0
var camera_zoom: Vector2 = Vector2(10, 10)
var current_health: int = 3 # Максимум 3 жизни

func _ready() -> void:
	add_to_group("players")
	$CameraPlayer.set_zoom(camera_zoom)
# Отображение жизней может быть реализовано через интерфейс (HUD), например через спрайты сердечек

func move_character_body(delta: float) -> void:
	var velocity_player: Vector2 = Vector2()

	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite2D.flip_h = false
		velocity_player.x += 1
	if Input.is_action_pressed("ui_left"):
		$AnimatedSprite2D.flip_h = true
		velocity_player.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity_player.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity_player.y -= 1

	velocity_player = velocity_player.normalized() * speed
	set_velocity(velocity_player)
	move_and_slide()

func _process(delta: float) -> void:
	move_character_body(delta)

# Функция получения урона
func take_damage(amount: int) -> void:
	current_health -= amount # Уменьшаем количество жизней
	if current_health <= 0:
		current_health = 0
		game_over() # Вызываем функцию проигрыша, если жизни закончились
	else:
		print("Player took damage. Current current_health:", current_health)

# Функция проигрыша
func game_over() -> void:
	print("Game Over! Player has no current_health left.")
	# Здесь можно добавить логику для завершения игры, перезагрузки уровня, показа экрана смерти и т.д.
	queue_free() # Удаляем игрока из сцены (или можно перезапустить игру)
