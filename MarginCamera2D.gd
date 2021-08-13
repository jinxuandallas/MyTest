extends Camera2D

var in_edge:=false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var margin_container=$"../CanvasLayer/MarginContainer"

onready var screen_size=margin_container.get_viewport_rect().size
# Called when the node enters the scene tree for the first time.
func _ready():
	print(screen_size)
	print(get_viewport_rect().size)
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#func _physics_process(delta):
#	if in_edge:
#		var mouse_pos=get_viewport().get_mouse_position()
#		print(mouse_pos)
#		if mouse_pos>screen_size.y-

func _on_MarginContainer_mouse_entered():
	in_edge=true


func _on_MarginContainer_mouse_exited():
	in_edge=false
