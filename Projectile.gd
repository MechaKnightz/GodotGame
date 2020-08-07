extends KinematicBody
class_name Projectile
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector3()
var time_lived = 0

export var SPEED = 30
export var ACCELERATION = 30
export var DEACCELERATION = 3
export var TTL = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#todo start with velocity

func _process(delta):
	time_lived += delta
	if time_lived > TTL:
		queue_free()

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
