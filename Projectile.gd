extends Spatial

var velocity = Vector3()
var time_lived = 0

export var SPEED = 30
export var ACCELERATION = 30
export var DEACCELERATION = 3
export var TTL = 5

var hit_something = false
var BULLET_DAMAGE = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area.connect("body_entered", self, "collided")

func _process(delta):
	time_lived += delta
	if time_lived > TTL:
		queue_free()

func _physics_process(delta):
	var dir = self.global_transform.basis.z
	dir = dir.normalized()
	
	var new_pos = dir * SPEED
	var accel = DEACCELERATION
	
	velocity = velocity.linear_interpolate(new_pos, accel * delta)
	
	global_translate(velocity * delta)
	

func collided(body):
	if hit_something == false:
		if body.has_method("bullet_hit"):
			body.bullet_hit(BULLET_DAMAGE, global_transform)

	hit_something = true
	queue_free()
