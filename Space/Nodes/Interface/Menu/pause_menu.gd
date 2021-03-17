extends Control

var _ishidden = true

func _input(event):
	if event.is_action_pressed("pause"):
		if _ishidden:
			$Vbox.show()
			get_tree().paused = true
			_ishidden = false
		else:
			$Vbox.hide()
			get_tree().paused = false
			_ishidden = true

func _on_resume_button_pressed():
	$Vbox.hide()
	get_tree().paused = false

func _on_quit_button_pressed():
	get_tree().quit()

func _on_exit_button_pressed():
	get_tree().change_scene("res://Nodes/Interface/Menu/TitleScreen.tscn")
