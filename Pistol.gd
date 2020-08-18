extends "res://RangedWeapon.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var RAY_LENGTH = 10

var projectile = preload("res://Bullet.tscn")
var debug = preload("res://Debug.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _fire(rayPos: Vector3):
	
	print(rayPos)
	var dg = debug.instance()
	dg.translation = rayPos
	
	var from = $ProjectileSpawnLocation.translation
	var to = from + Vector3.DOWN *  RAY_LENGTH
	var directState = PhysicsServer.space_get_direct_state(self.get_parent().get_world().get_space())
	var downResult = directState.intersect_ray(from, to, [self])
	var proj = projectile.instance()
	proj.transform = $ProjectileSpawnLocation.global_transform
	var direction = $ProjectileSpawnLocation.translation.direction_to(rayPos)
	var dotProd = rayPos.cross(Vector3.UP)
	var up = rayPos.rotated(dotProd, PI / 2)
	rayPos = rayPos.rotated(Vector3.UP, PI)
	proj.look_at_from_position(proj.translation, rayPos, Vector3.UP)
	get_node("/root/Main/WorldEnvironment").add_child(proj)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
