extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const SPEED=200

var in_edge
var active_color_rect
var map_data=[]

onready var background=$ParallaxBackground
onready var margin_container=$"Viewport/MarginContainer"
onready var screen_size=get_viewport_rect().size
onready var map=$"ParallaxBackground/ParallaxLayer/53"
onready var rect=$"ParallaxBackground/ParallaxLayer/53/ColorRect"
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in 21:
		var l=Line2D.new()
		l.add_point(Vector2(i*50,0))
		l.add_point(Vector2(i*50,1000))
		l.default_color=Color.red
		l.width=2
		map.add_child(l)
		
	for i in 21:
		var l=Line2D.new()
		l.add_point(Vector2(0,i*50))
		l.add_point(Vector2(1000,i*50))
		l.default_color=Color.red
		l.width=2
		map.add_child(l)
	
	for i in 20:
		var line_data=[]
		for j in 20:
			var cr=ColorRect.new()
			cr.rect_position=Vector2(i*50,j*50)
			cr.rect_size=Vector2(50,50)
			cr.color.a=0
#			cr.visible=false
			cr.connect("mouse_entered",self,"_on_ColorRect_mouse_entered",[cr])
			cr.connect("mouse_exited",self,"_on_ColorRect_mouse_exited",[cr])
			map.add_child(cr)
			
			line_data.append(0)
			
		map_data.append_array(line_data)
		
func _input(event):
	$Viewport.input(event)	

func _physics_process(delta):
	if in_edge:
		var mouse_pos=get_viewport().get_mouse_position()
#	if mouse_pos.x>screen_size.x-margin_container.get_constant("margin_right")||mouse_pos.x<margin_container.get_constant("margin_left")||mouse_pos.y<margin_container.get_constant("margin_top")||mouse_pos.y>screen_size.y- margin_container.get_constant("margin_bottom"):
	
#		print(mouse_pos)
		if mouse_pos.x>screen_size.x-margin_container.get_constant("margin_right"):
			background.scroll_offset.x+=delta*SPEED
			
		if mouse_pos.x<margin_container.get_constant("margin_left"):
			background.scroll_offset.x-=delta*SPEED

		if mouse_pos.y<margin_container.get_constant("margin_top"):
			background.scroll_offset.y+=delta*SPEED
			
		if mouse_pos.y>screen_size.y- margin_container.get_constant("margin_bottom"):
			background.scroll_offset.y-=delta*SPEED

	if active_color_rect!=null:
		if Input.is_action_pressed("0"):
			active_color_rect.color=Color(1,1,1,0.7)
		if Input.is_action_pressed("1"):
			var coordinate=_get_color_rect_num(active_color_rect)
			print(coordinate)
			active_color_rect.color=Color(0.65,0.16,0.16,0.7)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _get_color_rect_num(color_rect:ColorRect):
	var x=color_rect.rect_position.x/50
	var y=color_rect.rect_position.y/50
	return Vector2(x,y)

func _on_MarginContainer_mouse_entered():
	in_edge=true


func _on_MarginContainer_mouse_exited():
	in_edge=false


func _on_ColorRect_mouse_entered(color_rect):
#	if color_rect.color.r==1&&color_rect.color.g==1&&color_rect.color.b==1:
	color_rect.color.a=0.7
#	else:
#		color_rect.color==Color(1,1,1,0.7)
	active_color_rect=color_rect
#	color_rect.visible=true
#	print("xxx")


func _on_ColorRect_mouse_exited(color_rect):
	if color_rect.color.r==1&&color_rect.color.g==1&&color_rect.color.b==1:
		color_rect.color.a=0
	active_color_rect=null
#	print("yyy")
