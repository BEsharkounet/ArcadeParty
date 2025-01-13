extends Control

func _on_loading_screen_on_loading_status_update(new_value: float) -> void:
	$Label.text = str(new_value*100, "%")
	print(new_value)
