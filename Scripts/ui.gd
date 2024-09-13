extends CanvasLayer


func update_hearts(health: int) -> void:
	print("Updating hearts to " + str(health))
	for i in range(0, 3):
		var heart = get_node("Control/h" + str(i + 1))
		if i < health:
			heart.show()
		else:
			heart.hide()
