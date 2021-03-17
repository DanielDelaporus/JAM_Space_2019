extends Control

func _on_return_button_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Nodes/Interface/Menu/TitleScreen.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
