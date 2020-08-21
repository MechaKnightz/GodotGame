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
	#$Laser.is_casting = true
	#$Laser.translation = $ProjectileSpawnLocation.translation
	#$Laser.cast_to = rayPos
	pass

func _fire(result: Vector3):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
