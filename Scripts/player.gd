extends CharacterBody2D

@export var speed: float = 50.0
@export var camera_zoom: Vector2 = Vector2(10, 10)
@export var map_size_holder_path: String = "MapSizeHolder"
@export var zoom_increase: float = 0.4
@export var speed_increase: float = 5.0
@export var zoom_speed: float = 2

var current_health: int   = 3
var map_rect: Rect2
var items_eaten: int      = 0
var scale_increase: float = 0.05
var target_zoom: Vector2
var current_zoom: Vector2


func _ready() -> void:
	add_to_group("players")
	$CameraPlayer.zoom = camera_zoom
	target_zoom = camera_zoom
	current_zoom = camera_zoom
	set_camera_limits()


func upd_hearts_ui() -> void:
	var hearts_ui: Node = get_tree().current_scene.get_node("UI")
	if hearts_ui:
		hearts_ui.update_hearts(current_health)
	else:
		print("HeartsUI not found")


func set_camera_limits() -> void:
	var map_size_holder: Node = get_tree().current_scene.get_node(map_size_holder_path)
	if map_size_holder:
		map_rect = Rect2(map_size_holder.position, map_size_holder.size)
		map_size_holder.hide()
		$CameraPlayer.limit_right = map_rect.position.x + map_rect.size.x
		$CameraPlayer.limit_bottom = map_rect.position.y + map_rect.size.y
		$CameraPlayer.limit_left = map_rect.position.x
		$CameraPlayer.limit_top = map_rect.position.y
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
	var map_pos  = map_rect.position
	var map_size = map_rect.size

	if position.x < map_pos.x:
		position.x = map_pos.x
	elif position.x > map_pos.x + map_size.x:
		position.x = map_pos.x + map_size.x

	if position.y < map_pos.y:
		position.y = map_pos.y
	elif position.y > map_pos.y + map_size.y:
		position.y = map_pos.y + map_size.y


func _process(delta: float) -> void:
	move_character_body(delta)
	current_zoom = current_zoom.lerp(target_zoom, zoom_speed * delta)
	$CameraPlayer.zoom = current_zoom


func take_damage(amount: int) -> void:
	current_health -= amount
	upd_hearts_ui()
	if current_health <= 0:
		current_health = 0
		game_over()
	else:
		print("Player took damage. Current health:", current_health)


func game_over() -> void:
	print("Game Over! Player has no health left.")
	get_tree().change_scene_to_file("res://Scenes/Stages/Stage_1.tscn")


func item_eaten() -> void:
	print("items_eaten: ", items_eaten)
	items_eaten += 1
	scale += Vector2(scale_increase, scale_increase)
	target_zoom -= Vector2(zoom_increase, zoom_increase)
	speed += speed_increase
	check_next_level()


func check_next_level() -> void:
	if items_eaten >= 15:
		get_tree().change_scene_to_file("res://Scenes/Cutscene_End.tscn")
		print("Player has eaten enough items to go to the next level.")
