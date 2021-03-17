extends KinematicBody2D

var Target
var Station
export (int) var agro_radius = 1300
export (int) var SlowRadius = 500
export (float) var  firerate = 1
export (int) var HP = 10
export (PackedScene) var Bullet
var speed = 20
var dir = Vector2()
var canshoot = true
var destroyed = false

func takedamage(nb):
	HP -= nb
	$AnimationPlayer.play("BlinkRed")
	if not destroyed and HP <= 0:
		destroyed = true
		boom()
		
func destroy():
	queue_free()
	
func boom():
	$CollisionShape2D.queue_free()
	destroyed = true	
	$AnimationPlayer.play("Death")
	update()

func _physics_process(delta):
	update()
	dir = Vector2.ZERO
	if Target:
		var dist = position.distance_to(Target.position)
		if dist < SlowRadius:
			speed = 0
		else:
			speed = 12
		look_at(Target.position)
		dir = Target.position - global_position
		if canshoot:
			shoot(dir)
# warning-ignore:return_value_discarded
	move_and_slide(dir * speed * delta)
	
func shoot(direct):
	var b = Bullet.instance()
	var a = direct.normalized()
	b.start(position, a) #+ rand_range(-0.05, 0.05))
	get_parent().add_child(b)
	canshoot = false
	$ShootTimer.start()

func _ready():
	Target = null
	$Visibility/CollisionShape2D.shape.radius = agro_radius
	$ShootTimer.wait_time = firerate
	
func _on_Visibility_body_entered(body):
	if not body.has_method("is_destroyed"):
		Target = body
	
# warning-ignore:unused_argument
func _on_Visibility_body_exited(body):	
	Target = Station
		
func getagro(body):
	if body.has_method("is_destroyed"):
		if not Target:
			Target = body
		Station = body

func _on_ShootTimer_timeout():
	canshoot = true
