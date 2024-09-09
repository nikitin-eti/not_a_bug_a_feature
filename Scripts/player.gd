extends CharacterBody2D
var speed: float = 150.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func move_character_body() -> void:
	var velocity = Vector2()

	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite2D.flip_h = false
		velocity.x += 1
		$AnimatedSprite2D.play("right")
	if Input.is_action_pressed("ui_left"):
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("right")
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		$AnimatedSprite2D.play("down")
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		$AnimatedSprite2D.play("up")

	if velocity.length() == 0:
		$AnimatedSprite2D.play("idle")

	velocity = velocity.normalized() * speed
	self.velocity = velocity
	move_and_slide()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_character_body()
