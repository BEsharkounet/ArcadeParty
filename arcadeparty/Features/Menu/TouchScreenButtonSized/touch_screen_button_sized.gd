extends Control

#region signals
signal on_touch_screen_released()
#endregion

#region nodes
@onready var _label:Label = $Label
#endregion

#region public properties
@export var text:String = ""
#endregion

#region overrides
func _ready() -> void:
	_update_text()
#endregion

#region private methods
func _update_text() -> void:
	_label.text = text
#endregion

#region signal handlers
func _on_touch_screen_button_released() -> void:
	on_touch_screen_released.emit()
#endregion
