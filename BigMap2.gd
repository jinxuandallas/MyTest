extends Node2D

const SPEED=3000
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var in_edge
var zoom = 1 setget set_zoom
var MAX_ZOOM := 2.0
var MIN_ZOOM := 0.2
var ZOOM_PERIOD := 0.05

var MAP_SIZE_X = 12 * 1000
var MAP_SIZE_Y = 9 * 1000

var mouse_position := Vector2()

onready var _Camera2D = $Camera2D
onready var _Chunks = $Chunks
onready var _DetectMouseRect = $LayerGUI/ControlDetectMouse/MarginContainer/DetectMouseRect

onready var screen_size=get_viewport_rect().size
onready var screen_right_up_radian = Vector2(screen_size.x / 2, - screen_size.y / 2).angle()
onready var screen_left_up_radian = Vector2(- screen_size.x / 2, - screen_size.y / 2).angle()
#onready var screen_left_down_radian = Vector2(- screen_size.x / 2, screen_size.y / 2)
#onready var screen_right_down_radian = Vector2(screen_size.x / 2, screen_size.y / 2)
# Called when the node enters the scene tree for the first time.
func _ready():
#	var texture_rect=TextureRect.new()
#	texture_rect.texture=preload("res://Map/1.jpg")
#	texture_rect.num=1
#	texture_rect.name="tilemap1"
#	$ParallaxBackground/ParallaxLayer.add_child(texture_rect)
#	print(texture_rect.name)
	
#	var namestr="ParallaxBackground/ParallaxLayer/"+texture_rect.name
#	print(namestr)
#	var tt=get_node(namestr)
#	tt.texture=preload("res://Map/53.jpg")
	
	
	for i in 9:
		for j in 12:
			var num= i * 12 + j
			var res_str="res://Map/%d.jpg" %num
			var sprite = Sprite.new()
			sprite.texture=load(res_str)
			sprite.centered = false
			sprite.name="PartMap%d" %num
			sprite.position = Vector2(j * 1000, i * 1000)
#			var l=Label.new()
#			l.text=texture_rect.name
#			texture_rect.add_child(l)
#			if num>1:
#				texture_rect.visible=false
			_Chunks.add_child(sprite)
			#$ParallaxBackground/ParallaxLayer.add_child(texture_rect)
			
#			print("(%d,%d)" %[i,j])

func _input(event):
	if event is InputEventMouse:
		mouse_position = event.position
		in_edge = !_DetectMouseRect.get_rect().has_point(mouse_position)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta):
	if in_edge:
#		mouse_position
		var vector = mouse_position - screen_size / 2.0
		var radian = vector.angle()
		var scroll_idx := -1
		if radian <= 0:
			if screen_right_up_radian <= radian and radian <= 0:
				scroll_idx = 0
			if screen_left_up_radian <= radian and radian <= screen_right_up_radian:
				scroll_idx = 1
			if - PI <= radian and radian <= screen_left_up_radian:
				scroll_idx = 2
		else:
			if 0 <= radian and radian <= -screen_right_up_radian:
				scroll_idx = 0
			if - screen_right_up_radian <= radian and radian <= - screen_left_up_radian:
				scroll_idx = 3
			if - screen_left_up_radian <= radian and radian <= PI:
				scroll_idx = 2
		var camera_translation = Vector2()
		match scroll_idx:
			0:
				camera_translation.x = delta * SPEED * zoom
			1:
				camera_translation.y = - delta * SPEED * zoom
			2:
				camera_translation.x = - delta * SPEED * zoom
			3:
				camera_translation.y = delta * SPEED * zoom
		move_camera(camera_translation)
		
	if Input.is_action_just_released("ScrollUp"):
		set_zoom(zoom - ZOOM_PERIOD)
		_Camera2D.zoom = Vector2(zoom, zoom)
		move_camera(Vector2())
#		print(self.zoom)
	if Input.is_action_just_released("ScrollDown"):
		set_zoom(zoom + ZOOM_PERIOD)
		_Camera2D.zoom = Vector2(zoom, zoom)
		move_camera(Vector2())
		

func move_camera(position_offset : Vector2):
	var size_x_half = get_viewport().size.x * zoom / 2.0
	var size_y_half = get_viewport().size.y * zoom / 2.0
	_Camera2D.position.x = clamp(_Camera2D.position.x + position_offset.x, size_x_half, MAP_SIZE_X - size_x_half)
	_Camera2D.position.y = clamp(_Camera2D.position.y + position_offset.y, size_y_half, MAP_SIZE_Y - size_y_half)
	

func set_zoom(new_zoom):
	zoom = clamp(new_zoom, MIN_ZOOM, MAX_ZOOM)
	
#func _zoom_get():
#	return zoom
