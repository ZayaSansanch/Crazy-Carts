extends CharacterBody2D

const acceleration = Vector2(0,-10)
const braking = 20
const resistances = 2 # ground and air friction, constant for simplicity.
# deaceleration force of wheels when not in the same 
const wheelDriftResistance = 5 #direction as to velocity.
var maxSpeed = 1000
const rotationSpeed = .08
# minimal percentage of angle difference. If lower - velocity direction
const minWDrResStr = 0.05 # changed to car direction. 1 = PI/2, should be less then rotationSpeed
const spriteAngle = -PI/2 # default sprite image and thus acceleration vector angle
@export var issecondplayer : bool = false

func _physics_process(_delta):
	print(maxSpeed)
	if !issecondplayer:
		get_node("Sprite2").visible = false
		var res = resistances
		if Input.is_action_pressed('ui_left') or Input.is_action_pressed('ui_right'):
			if Input.is_action_pressed('ui_left'):
				rotation -= rotationSpeed
			else:
				rotation += rotationSpeed
		if Input.is_action_pressed('ui_up'):
			velocity += acceleration.rotated(rotation)
			$Sprite/Particles2D.visible = true
		else:
			$Sprite/Particles2D.visible = false
			if Input.is_action_pressed('ui_down'):
				# pressing down is equivalent to braking, no reverse gear for simplicity
				res += braking
		if velocity.length() > res:
			# angle between where car is facing and where it actually moves (drifting)
			var angle = velocity.angle()-(rotation-spriteAngle)
			# strength of wheel resistance to drift, strongest if drift perpendicular to car facing
			var wDrResStr = sin(angle)
			if abs(wDrResStr) > minWDrResStr:
				velocity += Vector2(wDrResStr*wheelDriftResistance,0).rotated(rotation)
			else: # if angle difference in minimal, then we discard
			# drift portion of velocity and leave the other making car move where it faces
				velocity *= abs(cos(angle))
			# applying triction and braking, if we brake
			velocity += -velocity.normalized() * res
			if velocity.length() > maxSpeed:
				# limiting our velocity to maxSpeed
				velocity = velocity / velocity.length() * maxSpeed
		else:
			velocity = Vector2()
		# let's not forget to save remainder of velocity, so it can be processed in future frames,
		# if we don't do it, then we will not be able to slide/drift and accelerate more
		move_and_slide()
	else:
		get_node("Sprite").visible = false
		var res = resistances
		if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_D):
			if Input.is_key_pressed(KEY_A):
				rotation -= rotationSpeed
			else:
				rotation += rotationSpeed
		if Input.is_key_pressed(KEY_W):
			velocity += acceleration.rotated(rotation)
			$Sprite2/Particles2D.visible = true
		else:
			$Sprite2/Particles2D.visible = false
			if Input.is_key_pressed(KEY_S):
				# pressing down is equivalent to braking, no reverse gear for simplicity
				res += braking
		if velocity.length() > res:
			# angle between where car is facing and where it actually moves (drifting)
			var angle = velocity.angle()-(rotation-spriteAngle)
			# strength of wheel resistance to drift, strongest if drift perpendicular to car facing
			var wDrResStr = sin(angle)
			if abs(wDrResStr) > minWDrResStr:
				velocity += Vector2(wDrResStr*wheelDriftResistance,0).rotated(rotation)
			else: # if angle difference in minimal, then we discard
			# drift portion of velocity and leave the other making car move where it faces
				velocity *= abs(cos(angle))
			# applying triction and braking, if we brake
			velocity += -velocity.normalized() * res
			if velocity.length() > maxSpeed:
				# limiting our velocity to maxSpeed
				velocity = velocity / velocity.length() * maxSpeed
		else:
			velocity = Vector2()
		# let's not forget to save remainder of velocity, so it can be processed in future frames,
		# if we don't do it, then we will not be able to slide/drift and accelerate more
		move_and_slide()


func _on_area_2d_body_entered(body):
	if body.is_in_group("player1"):
		get_node("../finishes").finish_line1()
	if body.is_in_group("player2"):
		get_node("../finishes").finish_line2()

func _on_area_2d_2_body_entered(body):
	if body.is_in_group("player1"):
		get_node("../finishes").triger_line1()
	if body.is_in_group("player2"):
		get_node("../finishes").triger_line2()

func slow_down():
	maxSpeed = 200

func slow_up():
	maxSpeed = 1000
