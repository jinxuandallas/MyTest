extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const SPEED=800
var in_edge
var zoom=0.5 setget _zoom_set

onready var background=$ParallaxBackground
onready var margin_container=$Viewport/MarginContainer
onready var screen_size=get_viewport_rect().size

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _input(event):
	$Viewport.input(event)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	if in_edge:
		var mouse_pos=get_viewport().get_mouse_position()
		if mouse_pos.x>screen_size.x-margin_container.get_constant("margin_right"):
			background.scroll_offset.x-=delta*SPEED/zoom
			
		if mouse_pos.x<margin_container.get_constant("margin_left"):
			background.scroll_offset.x+=delta*SPEED/zoom

		if mouse_pos.y<margin_container.get_constant("margin_top"):
			background.scroll_offset.y+=delta*SPEED/zoom
			
		if mouse_pos.y>screen_size.y- margin_container.get_constant("margin_bottom"):
			background.scroll_offset.y-=delta*SPEED/zoom
			
	if Input.is_action_just_released("ScrollUp"):
		self.zoom+=0.05
		background.scale.x=zoom
		background.scale.y=zoom
#		print(self.zoom)
	if Input.is_action_just_released("ScrollDown"):
		self.zoom-=0.05
#		print(self.zoom)
		background.scale.x=zoom
		background.scale.y=zoom
		

func _on_MarginContainer_mouse_entered():
	in_edge=true


func _on_MarginContainer_mouse_exited():
	in_edge=false

func _zoom_set(scale):
	zoom=clamp(scale,0.1,1)
