extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 9

func _physics_process(delta):
	
	#map the movement to vector3
	var input_dir = Input.get_vector("left","right","up","down")
	var direction = (transform.basis * Vector3(input_dir.x,0,input_dir.y)).normalized()
	
	#direction is set to speed
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	#hard stop when input let go
	else:
		velocity.x = 0.0
		velocity.z = 0.0
	

	# Moving the Character
	move_and_slide()
