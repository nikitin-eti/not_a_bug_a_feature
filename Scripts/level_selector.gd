extends Control

# Number of open levels (1 by default)
var unlocked_levels = 3

func _ready():
	update_level_buttons()

# Block levels that are not yet open and ulocked them
func update_level_buttons():
	var buttons: Array[Variant] = [$Town, $City, $Planet, $Galaxy, $Universe] # Array of buttons
	for i in range(buttons.size()):
		buttons[i].disabled = unlocked_levels <= i

# Called when the button Town is pressed to change the scene to town
func _on_town_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Stages/Stage_1.tscn")

# Called when the button City is pressed to change the scene to city
func _on_city_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Stages/Stage_2.tscn")

# Called when the button Planet is pressed to change the scene to planet
func _on_planet_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Stages/Stage_3.tscn")

# Called when the button galaxy is pressed to change the scene to galaxy
func _on_galaxy_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Stages/Stage_4.tscn")

# Called when the button Universe is pressed to change the scene to Universe
func _on_universe_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Stages/Stage_5.tscn")

# Called when the button is pressed to change the scene to MainMenu
func _on_back_to_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")
