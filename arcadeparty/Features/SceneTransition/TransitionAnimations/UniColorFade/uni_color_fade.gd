extends AnimationPlayer

## require to have in_animation and out_animation defined

#region nodes
@onready var _texture_rect:TextureRect = $TextureRect
#endregion

#region public properties
@export var is_in_animation:bool = true
@export var is_out_animation:bool = true
#endregion

#region overrides
func _ready() -> void:
	_set_state_as_end()
#endregion

#region public methods
func play_animation() -> void:
	_set_state_as_start()
	play("in_animation")

func play_backward_animation() -> void:
	_set_state_as_end()
	play_backwards("in_animation")
#endregion

#region private methods
func _set_state_as_start() -> void:
	_texture_rect.modulate.a = 1

func _set_state_as_end() -> void:
	_texture_rect.modulate.a = 0
#endregion
