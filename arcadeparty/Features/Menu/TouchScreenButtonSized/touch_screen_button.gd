extends TouchScreenButton

#region public properties
## the touch screen button will follow size of the referenced control master
@export var control_master:Control = null
#endregion

#region overrides
func _process(_delta: float) -> void:
	_update_shape_size()
#endregion

#region private methods
func _update_shape_size() -> void:
	var current_shape:RectangleShape2D = shape
	current_shape.size = control_master.size
#endregion
