extends Control

## this node has to be played when a scene ends or starts
## animations have to be provided from ./TransitionAnimations
## 2 choices :
## - direct transition to new scene (ok for light scenes)
## - transition to a loading screen that'll start loading the new scene

## add a animationPlayer as child with in_animation and out_animation
## from the scenes that use that node  if animations must be played before 
## scene switch

#region signals
signal on_in_animation_finished()
#endregion

#region private properties
var _scene_path_to_go_after_animation:String = ""
var _is_playing_backward:bool = false
#endregion

#region overrides
func _ready() -> void:
	# also set animationPlayer Node
	_handle_animation()
#endregion

#region public methods
## load and display the new scene from scene path
func change_scene(scene_path:String) -> void:
	_scene_path_to_go_after_animation = scene_path
	if not _start_transition_animation():
		_execute_change_scene(scene_path)

## display loading screen giving loading path for next scene
func start_loading_screen(loading_screen_path:String, scene_path:String) -> void:
	# set ./Autoload/SceneTransition.gd as autoload
	SceneTransition.scene_path_after_loading_screen = scene_path
	change_scene(loading_screen_path)
#endregion

#region private methods
func _handle_animation() -> void:
	_link_animation_signals()
	_start_in_animation()

func _link_animation_signals() -> void:
	for animation:AnimationPlayer in get_children():
		animation.animation_finished.connect(_on_animation_finished)
	
func _start_in_animation() -> void:
	var animation_player:AnimationPlayer = _get_animation_in()
	if animation_player:
		animation_player.play_animation()

# get a child that have in animation on true (is_in_animation)
func _get_animation_in() -> AnimationPlayer:
	for animation:AnimationPlayer in get_children():
		if animation.is_in_animation:
			return animation
	return null

# get a child that have out animation on true (is_out_animation)
func _get_animation_out() -> AnimationPlayer:
	for animation:AnimationPlayer in get_children():
		if animation.is_out_animation:
			return animation
	return null

func _execute_change_scene(scene_path:String)->void:
	var packed_scene:PackedScene = load(scene_path)
	get_tree().change_scene_to_packed(packed_scene)

# play out animation, return false if no animation is played
func _start_transition_animation()->bool:
	var animation_player:AnimationPlayer = _get_animation_out()
	if animation_player:
		_is_playing_backward = true
		animation_player.play_backward_animation()
		return true
	return false
#endregion

#region signal handlers
func _on_animation_finished(_anim_name:String) -> void:
	if _is_playing_backward:
		_execute_change_scene(_scene_path_to_go_after_animation)
	else:
		on_in_animation_finished.emit()

#endregion
