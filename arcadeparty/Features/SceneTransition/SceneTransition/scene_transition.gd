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

#region public properties
## play animation when scene is shown
@export var play_in_animation:bool = true
## play animation when scene is left
@export var play_out_animation:bool = true
#endregion

#region private properties
var _scene_path_to_go_after_animation:String = ""
var _animation_player:AnimationPlayer = null
#endregion

#region overrides
func _ready() -> void:
	# also set animationPlayer Node
	_handle_animation()
#endregion

#region public methods
## load and display the new scene from scene path
func change_scene(scene_path:String) -> void:
	if not _animation_player or not play_out_animation:
		_execute_change_scene(scene_path)
	else:
		_scene_path_to_go_after_animation = scene_path
		_start_transition_animation()

## display loading screen giving loading path for next scene
func start_loading_screen(loading_screen_path:String, scene_path:String) -> void:
	# set ./Autoload/SceneTransition.gd as autoload
	SceneTransition.scene_path_after_loading_screen = scene_path
	change_scene(loading_screen_path)
#endregion

#region private methods
func _handle_animation() -> void:
	_link_animation_signals()
	if _animation_player:
		if play_in_animation:
			_start_in_animation()
		else:
			_animation_player.dodge_animation()

func _link_animation_signals() -> void:
	if get_child_count() == 0: return
	_animation_player = get_child(0)
	_animation_player.animation_finished.connect(_on_animation_finished)

func _start_in_animation() -> void:
	_animation_player.play("in_animation")

func _execute_change_scene(scene_path:String)->void:
	var packed_scene:PackedScene = load(scene_path)
	get_tree().change_scene_to_packed(packed_scene)

func _start_transition_animation()->void:
	_animation_player.play("out_animation")
#endregion

#region signal handlers
func _on_animation_finished(_anim_name:String) -> void:
	if _anim_name == "out_animation":
		_execute_change_scene(_scene_path_to_go_after_animation)
	else:
		on_in_animation_finished.emit()

#endregion
