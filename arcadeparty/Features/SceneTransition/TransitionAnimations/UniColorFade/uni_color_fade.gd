extends AnimationPlayer

#region nodes
@onready var _texture_rect:TextureRect = $TextureRect
#endregion

#region public methods
# dodge in_animation, in this case, ensure the 
# control is invisible 
func dodge_animation() -> void:
	_texture_rect.modulate.a = 0
#endregion
