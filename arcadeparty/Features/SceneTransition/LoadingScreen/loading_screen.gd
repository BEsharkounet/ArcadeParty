extends Control

## add a control as child with interface features and update the view via 
## on_loading_status_update signal (new_value is between 0 and 1

#region signals
signal on_loading_status_update(new_value:float)
signal on_loaded_finished()
#endregion

#region nodes
@onready var _scene_transition:Control = $SceneTransition
#endregion

#region private properties
var _next_scene_path:String = ""
var _progress:Array[float] = []
var _load_status:int = 0
var _is_loaded:bool = false
#endregion

#region overrides
func _ready() -> void:
	_load_scene()

func _process(_delta: float) -> void:
	_update_loading_status()
#endregion

#region private methods
func _load_scene() -> void:
	_next_scene_path = SceneTransition.scene_path_after_loading_screen
	if _next_scene_path == "" : return
	ResourceLoader.load_threaded_request(_next_scene_path)

func _update_loading_status() -> void:
	_load_status = ResourceLoader.load_threaded_get_status(_next_scene_path, _progress)
	if not _is_loaded and _load_status == ResourceLoader.THREAD_LOAD_LOADED:
		_is_loaded = true
		on_loaded_finished.emit()
		$Timer.start(1)
		#_scene_transition.change_scene(_next_scene_path)
	on_loading_status_update.emit(_progress[0])
#endregion

#region signal handlers
func _on_timer_timeout() -> void:
	_scene_transition.change_scene(_next_scene_path)
#endregion
