extends Node

var Wavecount = 0
export (PackedScene) var Squad1
export (PackedScene) var Squad2
var CurrentSquad
var CurrentSpawn : Vector2


signal wave_changed(wave)
signal spawn_changed(spawn_pos)

func _ready():
	randomize()
	CurrentSquad = null
	
# warning-ignore:unused_argument
func _process(delta):
	if not CurrentSquad:
		newWave()
	else:
		checkempty()
	
func newWave():
	if Wavecount % 5 == 0:
		CurrentSpawn = $Spawn1.position
	if Wavecount % 5 == 1:
		CurrentSpawn = $Spawn2.position
	if Wavecount % 5 == 2:
		CurrentSpawn = $Spawn3.position
	if Wavecount % 5 == 3:
		CurrentSpawn = $Spawn4.position
	if Wavecount % 5 == 4:
		CurrentSpawn = $Spawn5.position
	emit_signal("spawn_changed", CurrentSpawn)
	Wavecount += 1
	emit_signal("wave_changed", Wavecount)
	var tmp = randi() % 2
	if tmp == 0:
		CurrentSquad = Squad2.instance()
	else:
		CurrentSquad = Squad1.instance()
	CurrentSquad.position = CurrentSpawn
	get_parent().add_child(CurrentSquad)

func checkempty():
	if CurrentSquad.get_child_count() == 0:
		CurrentSquad.queue_free()
		CurrentSquad = null
