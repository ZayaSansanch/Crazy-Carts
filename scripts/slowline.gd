extends Area2D

func _on_body_entered(body):
	if body.is_in_group("player1"):
		get_node("../../player1").slow_down()
	if body.is_in_group("player2"):
		get_node("../../player2").slow_down()


func _on_body_exited(body):
	if body.is_in_group("player1"):
		get_node("../../player1").slow_up()
	if body.is_in_group("player2"):
		get_node("../../player2").slow_up()
