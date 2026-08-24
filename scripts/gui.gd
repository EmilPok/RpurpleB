extends CanvasLayer

@onready var cursor = $Cursor

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
