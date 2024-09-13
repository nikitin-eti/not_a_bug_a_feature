extends CharacterBody2D

@export var speed: float = 50.0
@export var camera_zoom: Vector2 = Vector2(2, 2)
@export var map_size_holder_path: String = "MapSizeHolder"

var current_health: int = 3
var map_rect: Rect2
var items_eaten: int = 0
var scale_increase: float = 0.2

func _ready() -> void:
	add_to_group("players")
	$CameraPlayer.set_zoom(camera_zoom)
	var map_size_holder: Node = get_tree().current_scene.get_node(map_size_holder_path)
	if map_size_holder:
		map_rect = Rect2(map_size_holder.position, map_size_holder.size)
		map_size_holder.hide()
		$CameraPlayer.limit_right = map_rect.size.x
		$CameraPlayer.limit_bottom = map_rect.size.y
	else:
		print("MapSizeHolder not found")

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
	limit_to_map_boundaries()

func limit_to_map_boundaries() -> void:
	if position.x < map_rect.position.x:
		position.x = map_rect.position.x
	elif position.x > map_rect.position.x + map_rect.size.x:
		position.x = map_rect.position.x + map_rect.size.x
	if position.y < map_rect.position.y:
		position.y = map_rect.position.y
	elif position.y > map_rect.position.y + map_rect.size.y:
		position.y = map_rect.position.y + map_rect.size.y

func _process(delta: float) -> void:
	move_character_body(delta)

func take_damage(amount: int) -> void:
	current_health -= amount
	if current_health <= 0:
		current_health = 0
		game_over()
	else:
		print("Player took damage. Current health:", current_health)

func game_over() -> void:
	print("Game Over! Player has no health left.")
	queue_free()

func _on_item_eaten() -> void:
	items_eaten += 1
	scale += Vector2(scale_increase, scale_increase)

