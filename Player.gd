extends KinematicBody


# Declare member variables here.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") * ProjectSettings.get_setting("physics/3d/default_gravity_vector").y
var velocity = Vector3()
var camera
var cameraTransform

var SPEED = 12
var ACCELERATION = 3
var DEACCELERATION = 10
const RAY_LENGTH = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	camera = get_node("../CameraHolder/Camera")
	cameraTransform = camera.get_global_transform()

func _process(delta):
	if(Input.is_action_pressed("shoot")):
		pass

func _input(ev):
	if ev is InputEventMouseButton and ev.is_action_pressed("shoot"):
		var from = camera.project_ray_origin(ev.position)
		var to = from + camera.project_ray_normal(ev.position) * RAY_LENGTH
		var directState = PhysicsServer.space_get_direct_state(camera.get_world().get_space())
		var result = directState.intersect_ray(from, to, [self])
		if ("position" in result):
			$Pistol._use(result.position)

func _physics_process(delta):
	var dir = Vector3()
	var is_moving = false
	
	if(Input.is_action_pressed("move_forward")):
		dir += -cameraTransform.basis.z
		is_moving = true
	if(Input.is_action_pressed("move_back")):
		dir += cameraTransform.basis.z
		is_moving = true
	if(Input.is_action_pressed("strafe_left")):
		dir += -cameraTransform.basis.x
		is_moving = true
	if(Input.is_action_pressed("strafe_right")):
		dir += cameraTransform.basis.x
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
	velocity = move_and_slide_with_snap(velocity, Vector3.DOWN * 10, Vector3.UP, true, 4, 1.39626)
	#velocity = move_and_slide(velocity, Vector3.UP, true, 4, 0.872665)
	
	if is_moving:
		var angle = -atan2(hv.z, hv.x)
		
		var skel_rot = get_rotation()
		
		skel_rot.y = angle
		skel_rot.y += PI / 2
		
		set_rotation(skel_rot)
	
	var speed = hv.length() / SPEED
	
	$AnimationTree["parameters/Blend2/blend_amount"] = speed
