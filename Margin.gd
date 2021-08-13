extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var in_edge
#var screen_size
var speed=3
onready var margin_container=$CanvasLayer/MarginContainer
onready var camera=$Camera2D
onready var screen_size=camera.get_viewport_rect().size
# Called when the node enters the scene tree for the first time.
func _ready():
	print(margin_container.get_constant("margin_right"))

func _input(event):
	if event is InputEventMouseMotion:
		print("pos",event.position)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	if in_edge:
		var mouse_pos=get_viewport().get_mouse_position()
#		print(mouse_pos)
		if mouse_pos.x>screen_size.x-margin_container.get_constant("margin_right"):
			camera.offset_h+=delta*speed
			
		if mouse_pos.x<margin_container.get_constant("margin_left"):
			camera.offset_h-=delta*speed

		if mouse_pos.y<margin_container.get_constant("margin_top"):
			camera.offset_v-=delta*speed
			
		if mouse_pos.y>screen_size.y- margin_container.get_constant("margin_bottom"):
			camera.offset_v+=delta*speed
			
func _on_MarginContainer_mouse_entered():
	print("yyy")
	in_edge=true


func _on_MarginContainer_mouse_exited():
	in_edge=false
	print("xxx")
