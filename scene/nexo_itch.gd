extends PhysicsBody3D

@export var sprint_speed = 9
@export var gravity = 5
@export var walk_speed = 5
@export var jump_force = 3

#animation

var idle_node_name = 'idle'
var walk_node_name = 'walk'
var run_node_name = 'run'
var jump_node_name = 'jump'
var death_node_name = 'death'
var attack_node_name = 'attack'

#state machine condition
var is_attacking: bool
var is_walking: bool
var is_dying: bool
var is_running: bool

#physics level
var direction : Vector3
var horizontal_velocity: Vector3
var aim_turn: float
var movement: Vector3
var vertial_velocity: Vector3
var movement_speed: int
var angular_acceleration:int
var acceleration: Vector3
var just_hit: bool

@onready var camrot_h = get_node("camroot/h")

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		aim_turn = -event.relative.x * 0.015
	if event.is_action_pressed("aim"):
		direction = camrot_h.global_tranform.basis.z
		
func _physics_process(delta: float) -> void:
	var on_floor = move_and_slide()
	if !is_dying:
		if !is_on_floor:
			vertical_velocity += Vector3.DOWN*gravity*2*delta
			
	
	
	
