extends CharacterBody3D

# How fast the player moves in meters per second.
var gravity = 16.0
@export var speed = 9.0
@export var jump_velocity = 5.0 
@export var walk_speed = 9.0
@export var sprint_speed =15.0
@export var mouse_sens = 0.001
@onready var pivot = $CameraPivot
@onready var camera = $CameraPivot/Camera3D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		pivot.rotate_y(-event.relative.x *mouse_sens)
		camera.rotate_x(event.relative.y *mouse_sens)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-45),deg_to_rad(60))
		
	
func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		
	#map the movement to vector3
	var input_dir = Input.get_vector("right","left","down","up")
	var direction = (pivot.transform.basis * Vector3(input_dir.x,0,input_dir.y)).normalized()
	if is_on_floor():
		#direction is set to speed
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		#hard stop when input let go
		else:
			velocity.x = lerp(velocity.x,direction.x * speed, delta * 7.0)
			velocity.z = lerp(velocity.z,direction.z * speed, delta * 7.0)
	else:
		velocity.x = lerp(velocity.x,direction.x * speed, delta * 2.0)
		velocity.z = lerp(velocity.z,direction.z * speed, delta * 2.0)
		
	#Handle sprint speed
	if Input.is_action_just_pressed("sprint"):
		speed = sprint_speed
	else:
		speed = walk_speed
	
	#press esc to see mouse
	if Input.is_action_just_pressed("esc"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	# Moving the Character
	move_and_slide()
