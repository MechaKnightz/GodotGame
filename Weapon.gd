extends Spatial
class_name Weapon

# Declare member variables here. Examples:
export var weapon_name = "none"
export var cooldown = 0
var last_fired

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _use(result: Vector3):
	if last_fired == null:
		last_fired = OS.get_system_time_msecs()
		_fire(result)
	elif last_fired + cooldown < OS.get_system_time_msecs():
		last_fired = OS.get_system_time_msecs()
		_fire(result)
	pass

func _fire(result: Vector3):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
