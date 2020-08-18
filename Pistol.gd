extends "res://RangedWeapon.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var RAY_LENGTH = 1000

var projectile = preload("res://Bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _fire(rayPos: Vector3):
	print(self.get_parent().get_world().get_space())
	var from = $ProjectileSpawnLocation.translation
	var to = from + Vector3.DOWN *  RAY_LENGTH
	var directState = PhysicsServer.space_get_direct_state(self.get_parent().get_world().get_space())
	var downResult = directState.intersect_ray(from, to, [self])
	var proj = projectile.instance()
	proj.transform = $ProjectileSpawnLocation.global_transform
	
	print(downResult)
	get_node("/root/Main/WorldEnvironment").add_child(proj)
	proj.look_at(rayPos, Vector3.UP)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
