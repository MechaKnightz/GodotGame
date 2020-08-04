extends KinematicBody

class_name Projectile
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector3()

var SPEED = 12
var ACCELERATION = 3
var DEACCELERATION = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var dir = self.global_transform.basis.z
	dir.y = 0
	dir = dir.normalized()
	
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
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
