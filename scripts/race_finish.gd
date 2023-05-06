extends Control

@export var player1count : int = 0
@export var player2count : int = 0
var end = false
var timer = 0.0

func round_to_dec(num, digit):
	return round(num * pow(10.0, digit)) / pow(10.0, digit)

func _ready():
	get_node("../Camera2D/UI/Label").visible = false
	get_node("../Camera2D/UI/Label2").visible = false

func finish_line1():
	if !end:
		if player1count % 2 == 1:
			player1count += 1
			get_node("../Camera2D/UI/Label3").text = str(player1count)

func finish_line2():
	if !end:
		if player2count % 2 == 1:
			player2count += 1
			get_node("../Camera2D/UI/Label4").text = str(player2count)

func triger_line1():
	if !end:
		if player1count % 2 == 0:
			player1count += 1
			get_node("../Camera2D/UI/Label3").text = str(player1count)

func triger_line2():
	if !end:
		if player2count % 2 == 0:
			player2count += 1
			get_node("../Camera2D/UI/Label4").text = str(player2count)

func _process(delta):
	if !end:
		timer += delta
		get_node("../Camera2D/UI/Label5").text = str(round_to_dec(timer, 2))
	if !end:
		if player1count >= 10:
			end = true
			get_node("../Camera2D/UI/Label").visible = true
		if player2count >= 10:
			end = true
			print("player2 - won")
			get_node("../Camera2D/UI/Label2").visible = true
