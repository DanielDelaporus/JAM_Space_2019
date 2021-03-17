extends Area2D

export (PackedScene) var Arrow
var arrow
var target = Vector2()
var array = []

func _ready():
	arrow = Arrow.instance()
	add_child(arrow)
	target = null
	
# warning-ignore:unused_argument
func _process(delta):
	if target:
		arrow.look_at(target)
		arrow.rotation_degrees += 90


func _on_DetectionArrow_body_entered(body):
	array.push_front(body)

func _on_DetectionArrow_body_exited(body):
	array.erase(body)
