extends Camera2D

var cameraSpeed:= 25
onready var camera:= $"."

func _ready() -> void:
	camera.current = true
	camera.zoom = Vector2(5, 5)


func _process(_delta: float) -> void:
	move_camera()


func move_camera():
	if Input.is_action_pressed("UP"):
		camera.global_position.y -= cameraSpeed
	elif Input.is_action_pressed("DOWN"):
		camera.global_position.y += cameraSpeed
	elif Input.is_action_pressed("LEFT"):
		camera.global_position.x -= cameraSpeed
	elif Input.is_action_pressed("RIGHT"):
		camera.global_position.x += cameraSpeed


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_WHEEL_UP:
				camera.zoom -= Vector2(0.1, 0.1)
			if event.button_index == BUTTON_WHEEL_DOWN:
				camera.zoom += Vector2(0.1, 0.1)
