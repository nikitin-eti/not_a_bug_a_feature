extends Area2D

var velocity: Vector2 = Vector2()
var duration: float   = 2.5


func _ready() -> void:
	self.connect("body_entered", Callable(self, "_on_body_entered"))


func _process(delta: float) -> void:
	position += velocity * delta

	duration -= delta
	if duration <= 0:
		queue_free()


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("players"):
		body.take_damage(1)
		queue_free()


func set_color(color: Color) -> void:
	$BulletSprite.modulate = color
