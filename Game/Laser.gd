extends RayCast

var is_casting := false setget set_is_casting
var camera: Camera
var RAY_LENGTH = 1000

func _ready():
	set_physics_process(false)
	$Line2D.points[1] = Vector2.ZERO
	camera = get_node("./../../../CameraHolder/Camera")
	
func _process(delta):
	if camera == null:
		return
		
	var from = camera.project_ray_origin(get_viewport().get_mouse_position())
	var to = from + camera.project_ray_normal(get_viewport().get_mouse_position()) * RAY_LENGTH
	var directState = PhysicsServer.space_get_direct_state(camera.get_world().get_space())
	var result = directState.intersect_ray(from, to, [self])
	
	if "position" in result and !is_casting:
		self.translation = get_node("./../ProjectileSpawnLocation").translation
		self.cast_to = result.position
	
		set_is_casting(true)
	elif "position" in result:
		self.translation = get_node("./../ProjectileSpawnLocation").translation
		self.cast_to = result.position
	else: 
		set_is_casting(false)
	print(is_casting)

func _draw():
	if is_casting:
		._draw()

func _physics_process(delta):
	
	var cast_point := cast_to
	force_raycast_update()
	
	if is_colliding():
		cast_point = get_collision_point()
		
	$Line2D.points[0] = camera.unproject_position(self.global_transform.origin)
	$Line2D.points[1] = camera.unproject_position(cast_point)

func set_is_casting(cast: bool):

	is_casting = cast
	
	if is_casting:
		var cast_point := cast_to
		force_raycast_update()
		
		if is_colliding():
			cast_point = get_collision_point()
		
		$Line2D.points[0] = camera.unproject_position(self.global_transform.origin)
		$Line2D.points[1] = camera.unproject_position(cast_point)
		appear()
	else:
		disappear()
	
	set_physics_process(is_casting)

func appear():
	#$Tween.stop_all()
	#$Tween.interpolate_property($Line2D, "width", 0, 5.0, 0.2)
	#$Tween.start()
	$Line2D.show()

func disappear():
	#$Tween.stop_all()
	#$Tween.interpolate_property($Line2D, "width", 5.0, 0, 0.1)
	#$Tween.start()
	$Line2D.hide()
