extends CharacterBody2D

@export var obj_bullet: PackedScene
@export var shooting_patterns: Array[int] = [0, 1, 2, 3, 4, 5]
var shooting_pattern: int
var movement_timer: float = 0.0
var shooting_timer: float = 0.0
var random_direction: Vector2 = Vector2.ZERO
var spiral_angle: float = 0.0
var map_rect: Rect2 # Хранит границы карты
var direction_change_timer: float = 0.0 # Таймер для случайного изменения направления

func _ready() -> void:
	obj_bullet = preload("res://Scenes/bullet.tscn")
	shooting_pattern = shooting_patterns[randi() % shooting_patterns.size()]

	# Поиск через дерево сцены
	var map_size_holder: Node = get_tree().current_scene.get_node("MapSizeHolder")
	if map_size_holder:
		map_rect = Rect2(map_size_holder.position, map_size_holder.size)
		map_size_holder.hide()
	else:
		print("MapSizeHolder not found")

	set_process(true)
	set_physics_process(true)

func _process(delta: float) -> void:
	# Автоматическая стрельба с интервалом
	shooting_timer -= delta
	if shooting_timer <= 0:
		match shooting_pattern:
			0:
				shoot_straight()
			1:
				shoot_fan()
			2:
				shoot_circle()
			3:
				shoot_spiral()
			4:
				shoot_random()
			5:
				shoot_cross()
		shooting_timer = randf_range(.5, 3.0) # Рандомный интервал стрельбы

	# Обновление случайного движения
	movement_timer -= delta
	if movement_timer <= 0:
		set_random_direction()
		movement_timer = randf_range(.5, 3.0) # Рандомный интервал смены направления

	# Обновление случайных изменений направления
	direction_change_timer -= delta
	if direction_change_timer <= 0:
		random_direction = random_direction.rotated(randf_range(-0.1, 0.1)) # Небольшие случайные изменения направления
		direction_change_timer = randf_range(1.0, 2.0) # Рандомный интервал изменения направления

	velocity = random_direction * randf_range(30, 70) # Случайная скорость
	move_and_slide()

	# Проверяем границы карты
	check_boundaries()

func check_boundaries() -> void:
	# Если враг выходит за границы карты, меняем направление
	if position.x < map_rect.position.x or position.x > map_rect.position.x + map_rect.size.x:
		random_direction.x *= -1
	if position.y < map_rect.position.y or position.y > map_rect.position.y + map_rect.size.y:
		random_direction.y *= -1

func shoot_straight() -> void:
	shoot(randf_range(0, 360), 100)

func shoot_fan() -> void:
	for angle in range(-30, 31, 15):
		shoot(angle, 100)

func shoot_circle() -> void:
	for angle in range(0, 360, 45):
		shoot(angle, 100)

func shoot_spiral() -> void:
	spiral_angle += randf_range(5, 15) # Случайное изменение угла
	if spiral_angle >= 360:
		spiral_angle = 0
	shoot(spiral_angle, 100)

func shoot_random() -> void:
	for i in range(5):
		shoot(randf_range(0, 360), 100)

func shoot_cross() -> void:
	shoot(0, 100)   # Вверх
	shoot(90, 100)  # Вправо
	shoot(180, 100) # Вниз
	shoot(270, 100) # Влево

func shoot(direction: float, speed: float) -> void:
	var new_bullet = obj_bullet.instantiate()
	new_bullet.velocity = Vector2(speed, 0).rotated(deg_to_rad(direction))
	new_bullet.position = position
	get_parent().add_child(new_bullet)

func set_random_direction() -> void:
	var random_angle = randf_range(0, 360)
	random_direction = Vector2.RIGHT.rotated(deg_to_rad(random_angle))
