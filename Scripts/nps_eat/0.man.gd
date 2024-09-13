extends Area2D

@export var effect_scene: PackedScene

func _ready() -> void:
	self.connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("players"):
		if effect_scene:
			var effect = effect_scene.instantiate()
			effect.position = position
			get_tree().current_scene.add_child(effect)
		queue_free()
