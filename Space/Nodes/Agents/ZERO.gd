extends KinematicBody2D

var Target
var Station
export (int) var agro_radius = 1300
export (int) var blowdamage = 15
export (int) var HP = 1
var speed = 6
var destroyed = false
var dir = Vector2()

func takedamage(nb):
	HP -= nb
	if not destroyed and HP <= 0:
		destroyed = true
		boom()

func boom():
	$CollisionShape2D.queue_free()
	$Area2D.queue_free()
	destroyed = true
	HP = 0
	$AnimationPlayer.play("Death")
	update()
		
func destroy():
	queue_free()
	

func _physics_process(delta):
	update()
	dir = Vector2.ZERO
	$Sprite.rotate(0.001 * 200)
	if Target:
		look_at(Target.position)
		dir = Target.position - global_position
# warning-ignore:return_value_discarded
	move_and_collide(dir * speed * delta * 0.1)

func _ready():
	Target = null
	destroyed = false
	$CollisionShape2D.disabled = false
	$Area2D/CollisionShape2D2.disabled = false
	$Visibility/CollisionShape2D.shape.radius = agro_radius
	
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

func _on_Area2D_body_entered(body):
	if (not body.has_method("getagro")):	
		if (body.has_method("takedamage")):	
			body.takedamage(blowdamage)
		boom()
