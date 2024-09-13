extends Area2D

@export var effect_scene: PackedScene = preload("res://Scenes/EatScenes/effect_eat.tscn")
@export var sprite_key: String = "default"

var sprite_paths = {
					   "ball": "res://Resources/Sprites/Objects & NPCs/Ball.png",
					   "beach_umbrella": "res://Resources/Sprites/Objects & NPCs/BeachUmbrella.png",
					   "child_f_water": "res://Resources/Sprites/Objects & NPCs/ChildFWater.png",
					   "child_m": "res://Resources/Sprites/Objects & NPCs/ChildM.png",
					   "child_m_water": "res://Resources/Sprites/Objects & NPCs/ChildMWater.png",
					   "cyan_towel": "res://Resources/Sprites/Objects & NPCs/CyanTowel.png",
					   "dog": "res://Resources/Sprites/Objects & NPCs/Dog.png",
					   "pink_towel": "res://Resources/Sprites/Objects & NPCs/PinkTowel.png",
					   "volleyball_net": "res://Resources/Sprites/Objects & NPCs/Volleyball Net.png",
					   "ship": "res://Resources/Sprites/Objects & NPCs/Ship.png",
					   "flowers": "res://Resources/Sprites/lvls/Town - Level/Objects & NPCs/FlowersTrees.png",
					   "house": "res://Resources/Sprites/lvls/Town - Level/Objects & NPCs/House.png",
					   "car1": "res://Resources/Sprites/lvls/Town - Level/Objects & NPCs/Silver Car.png",
					   "car2": "res://Resources/Sprites/lvls/Town - Level/Objects & NPCs/Red Car.png",
	
				   }

func _ready() -> void:
	var sprite = $Sprite
	if sprite_key in sprite_paths:
		sprite.texture = load(sprite_paths[sprite_key])
	else:
		print("Sprite key not found: ", sprite_key)

	self.connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("players"):
		body.item_eaten()
		if effect_scene:
			var effect = effect_scene.instantiate()
			effect.position = position
			get_tree().current_scene.add_child(effect)
		queue_free()
