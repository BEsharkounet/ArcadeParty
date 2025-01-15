extends Control

# music source : https://pixabay.com/music/search/gaming%20background/?pagi=2
# by XtremeFreddy

#region nodes
@onready var _scene_transition:Control = $SceneTransition
@onready var _triangle:Sprite2D = $MenuSelection/Control/Control/Sprite2D
#endregion

#region private properties
var _triangle_rotation_speed:float = 0.3
#endregion

#region overrides
func _ready() -> void:
	_set_triangle_color()
func _process(delta: float) -> void:
	_rotate_triangle(delta)
#endregion

#region public methods
func _set_triangle_color() -> void:
	_triangle.modulate = Color("0f1952")
func _rotate_triangle(delta:float) -> void:
	_triangle.rotate(_triangle_rotation_speed*delta)
#endregion

#region signal handlers
func _on_new_gamebutton_on_touch_screen_released() -> void:
	_scene_transition.change_scene("res://Features/Game/Game.tscn")

func _on_scores_button_on_touch_screen_released() -> void:
	_scene_transition.change_scene("res://Features/Scores/Scores.tscn")

func _on_credits_button_on_touch_screen_released() -> void:
	_scene_transition.change_scene("res://Features/Credits/Credits.tscn")
#endregion
