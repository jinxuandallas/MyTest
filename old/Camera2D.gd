extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var screen_size=get_viewport_rect().size 
onready var duration=0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var mouse_pos=get_viewport().get_mouse_position()
	print(mouse_pos)
	if screen_size.x- mouse_pos.x<50:
		if duration>20: #加上duration判断是为了让鼠标在边界悬停一会再滚动
			offset_h+=delta *5
		else:
			duration+=delta*50 #将每一帧的悬停时间累加到duration里
	else:
		duration=0
#		offset.x+= delta *200
#	print($"../..".get_local_mouse_position())
#	print(get_viewport().get_mouse_position())

#func _input(event):
#	if event is inputeventmouse
