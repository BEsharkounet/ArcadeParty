extends Panel

#region signals
signal on_full_visible()
#endregion

#region private properties
var visibility:float = 0.0
var _visibility_speed:float = 0.6
#endregion

#region override
func _ready() -> void:
	_update_display()
	_connect_signals()
	_play_sound()

func _process(delta: float) -> void:
	_increase_visibility(delta)
#endregion

#region private methods
func _play_sound() -> void:
	$Sound.play()

func _connect_signals() -> void:
	on_full_visible.connect(_on_full_visible_signal_emit)

func _increase_visibility(delta:float)->void:
	if visibility >= 1.0:return
	if visibility < 0.9:
		visibility += delta * _visibility_speed
	else:
		visibility = 1
		on_full_visible.emit()
	_update_display()

func _update_display() -> void:
	$Control.modulate = Color(1, 1, 1, visibility)
#endregion

#region signal handling
func _on_timer_timeout() -> void:
	print("change scene")
	
func _on_full_visible_signal_emit() -> void:
	$Timer.start(1.0)
#endregion
