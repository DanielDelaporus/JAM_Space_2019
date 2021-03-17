extends RigidBody2D

export (int) var speed = 1100
export (int) var damage = 5

func start(pos, angle):
	rotation = angle.angle() + PI/2
	position = pos
	apply_central_impulse(angle * speed)
	$AnimationPlayer.play("Shot")

func explode():
	queue_free()

func _on_Bullet_body_entered(body):
	if (body.has_method("takedamage")):	
		body.takedamage(damage)
	$AnimationPlayer.play("Explode")
	

func _on_Timeout_timeout():
	$AnimationPlayer.play("Explode")
