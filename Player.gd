extends KinematicBody


# Declare member variables here.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") * ProjectSettings.get_setting("physics/3d/default_gravity_vector").y
var velocity = Vector3()
var camera

var SPEED = 12
var ACCELERATION = 3
var DEACCELERATION = 10

const Projectile = preload("res://Projectile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	camera = get_node("../CameraHolder/Camera").get_global_transform()

func _process(delta):
	if(Input.is_action_pressed("shoot")):
		var proj = Projectile.instance()
		print(self.rotation)
		proj.translation += Vector3(0, 2, 0)
		proj.rotation = self.rotation
		add_child_below_node(self, proj)

func _physics_process(delta):
	var dir = Vector3()
	var is_moving = false
	
	if(Input.is_action_pressed("move_forward")):
		dir += -camera.basis.z
		is_moving = true
	if(Input.is_action_pressed("move_back")):
		dir += camera.basis.z
		is_moving = true
	if(Input.is_action_pressed("strafe_left")):
		dir += -camera.basis.x
		is_moving = true
	if(Input.is_action_pressed("strafe_right")):
		dir += camera.basis.x
		is_moving = true
	
	dir.y = 0
	dir = dir.normalized()
	
	velocity.y += delta * gravity
	
	var hv = velocity
	hv.y = 0
	
	var new_pos = dir * SPEED
	var accel = DEACCELERATION
	
	if(dir.dot(hv) > 0):
		accel = ACCELERATION
	
	hv = hv.linear_interpolate(new_pos, accel * delta)
	
	velocity.x = hv.x
	velocity.z = hv.z
	velocity = move_and_slide(velocity, Vector3(0, 1, 0))
	
	if is_moving:
		var angle = -atan2(hv.z, hv.x)
		
		var skel_rot = get_rotation()
		
		skel_rot.y = angle
		skel_rot.y += PI / 2
		
		set_rotation(skel_rot)
	
	var speed = hv.length() / SPEED
	
	$AnimationTree["parameters/Blend2/blend_amount"] = speed
