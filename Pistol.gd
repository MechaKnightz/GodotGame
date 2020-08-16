extends "res://RangedWeapon.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var projectile = preload("res://Bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _fire():
	
	var proj = projectile.instance()
	print(proj)
	proj.transform = $ProjectileSpawnLocation.global_transform
	get_node("/root/Main/WorldEnvironment").add_child(proj)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
