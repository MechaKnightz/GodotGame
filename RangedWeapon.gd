extends Weapon


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const RAY_LENGTH = 1000
var id = 7777

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _aim(rayPos):
	var from = $ProjectileSpawnLocation.global_transform.origin
	var directState = PhysicsServer.space_get_direct_state(self.get_parent().get_world().get_space())
	var result = directState.intersect_ray(from, rayPos, [self])
	
	if ("position" in result):
		LineDrawer.remove_line(id)
		LineDrawer.draw_line_3D(id, $ProjectileSpawnLocation.global_transform.origin, result.position,
		 Color(0, 255, 0, 1), 1.0)

func _fire(result: Vector3):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
