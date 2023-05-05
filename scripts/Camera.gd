extends Camera2D

const maxzoom = 1.75
const zoomratio = 0.75

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var plr1p = get_node("../player1").position
	var plr2p = get_node("../player2").position
	var campres = Vector2(0, 0)
	var carsdist
	var screensize = get_tree().get_root().size
	var minscreen = min(screensize.x, screensize.y) 
	var carscreen = minscreen * zoomratio
	var screenzoom
	
	campres.x = (plr1p.x + plr2p.x) / 2
	campres.y = (plr1p.y + plr2p.y) / 2
	
	carsdist = sqrt((plr1p.x - plr2p.x)**2 + (plr1p.y - plr2p.y)**2)
	
	screenzoom = carscreen / carsdist
	if screenzoom > maxzoom:
		screenzoom = maxzoom
	
	get_node(".").position = campres
	get_node(".").zoom = Vector2(screenzoom, screenzoom)
	pass
