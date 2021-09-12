extends Node2D

const SPEED = 3000
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var in_edge
var zoom = 1 setget set_zoom
var MAX_ZOOM := 8.0
var MIN_ZOOM := 1
var ZOOM_PERIOD := 0.25

var MAP_SIZE_X = 12 * 1000
var MAP_SIZE_Y = 9 * 1000

var mouse_position := Vector2()
var current_border
var map_state=[]
var current_map_num

onready var _Camera2D = $Camera2D
onready var _Chunks = $Chunks
onready var _DetectMouseRect = $LayerGUI/ControlDetectMouse/MarginContainer/DetectMouseRect

onready var screen_size = get_viewport_rect().size
onready var screen_right_up_radian = Vector2(screen_size.x / 2, -screen_size.y / 2).angle()
onready var screen_left_up_radian = Vector2(-screen_size.x / 2, -screen_size.y / 2).angle()


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
#	$Chunks/CanvasLayer/Rect.connect("ss",self,"_on_mouse",)

	
			
	for i in 9:
		for j in 12:
			var num = i * 12 + j
			
			
			var res_str = "res://Map/%d.jpg" % num

			var texture_rect = MyTextureRect.new()
			texture_rect.texture=load(res_str)
#			texture_rect.centered = false
			texture_rect.name="PartMap%d" %num
#			texture_rect.position = Vector2(j * 1000, i * 1000)
			texture_rect.margin_left=j*1000
			texture_rect.margin_top=i*1000
			texture_rect.connect("my_mouse_entered",self,"_on_MyTextureRect_mouse_entered")
			
#			var reference_rect=ReferenceRect.new()
			
#			reference_rect.rect_position.x=texture_rect.margin_left
#			reference_rect.rect_position.y=texture_rect.margin_top
#			reference_rect.rect_size.x=996
#			reference_rect.rect_size.y=996
#			reference_rect.border_color=Color.red
#			reference_rect.border_width=2
#			reference_rect.name="Border%d"%num
#			reference_rect.editor_only=false
#			reference_rect.visible=true
#
#			_Chunks.add_child(reference_rect)
			_Chunks.add_child(texture_rect)
			
	_load_mapstate()
#	_format_mapstate()
#			var my_area2d: MyTileMap = load("res://test_node2d/MyArea2D.tscn").instance()
#			_Chunks.add_child(my_area2d)
#			my_area2d.map.name = "PartMap%d" % num
#			my_area2d.map.texture = load(res_str)
#			my_area2d.position.x = j * 1000+500
#			my_area2d.position.y = i * 1000+500
#	$MyArea2D/Area2D/CollisionShape2D/Sprite.texture=load("res://Map/88.jpg")
#			var l=Label.new()
#			l.text=texture_rect.name
#			texture_rect.add_child(l)
#			if num>1:
#				texture_rect.visible=false
#			texture_rect.mouse_filter=Control.MOUSE_FILTER_STOP
#			$Chunks/CanvasLayer.add_child(texture_rect)
			

			#$ParallaxBackground/ParallaxLayer.add_child(texture_rect)

#			print("(%d,%d)" %[i,j])


func _input(event):
	if event is InputEventMouse:
		mouse_position = event.position
		in_edge = ! _DetectMouseRect.get_rect().has_point(mouse_position)
		if event is InputEventMouseButton:
			if event.button_index==BUTTON_WHEEL_UP:
				set_zoom(zoom - ZOOM_PERIOD)
				_Camera2D.zoom = Vector2(zoom, zoom)
				if(zoom<4):
					current_border.width=8 #随着地图缩放，调节线段宽度
				move_camera(Vector2())
			
			if event.button_index==BUTTON_WHEEL_DOWN:
				set_zoom(zoom + ZOOM_PERIOD)
				_Camera2D.zoom = Vector2(zoom, zoom)
				if(zoom>4):
					current_border.width=18 #随着地图缩放，调节线段宽度
				move_camera(Vector2())
				
			if event.button_index==BUTTON_LEFT:
#					var editor:PackedScene =load("res://viewport_background.tscn")
					get_tree().set_meta("MapNum",current_map_num)
#					get_tree().change_scene_to(editor)
					get_tree().change_scene("res://viewport_background.tscn")


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
			if -PI <= radian and radian <= screen_left_up_radian:
				scroll_idx = 2
		else:
			if 0 <= radian and radian <= -screen_right_up_radian:
				scroll_idx = 0
			if -screen_right_up_radian <= radian and radian <= -screen_left_up_radian:
				scroll_idx = 3
			if -screen_left_up_radian <= radian and radian <= PI:
				scroll_idx = 2
		var camera_translation = Vector2()
		match scroll_idx:
			0:
				camera_translation.x = delta * SPEED * zoom
			1:
				camera_translation.y = -delta * SPEED * zoom
			2:
				camera_translation.x = -delta * SPEED * zoom
			3:
				camera_translation.y = delta * SPEED * zoom
		move_camera(camera_translation)

#	if Input.is_action_just_released("ScrollUp"):
#		set_zoom(zoom - ZOOM_PERIOD)
#		_Camera2D.zoom = Vector2(zoom, zoom)
#		if(zoom<4):
#			current_border.width=8 #随着地图缩放，调节线段宽度
#		move_camera(Vector2())
##		print(self.zoom)
#	if Input.is_action_just_released("ScrollDown"):
#		set_zoom(zoom + ZOOM_PERIOD)
#		_Camera2D.zoom = Vector2(zoom, zoom)
#		if(zoom>4):
#			current_border.width=18 #随着地图缩放，调节线段宽度
#		move_camera(Vector2())


func move_camera(position_offset: Vector2):
	var size_x_half = get_viewport().size.x * zoom / 2.0
	var size_y_half = get_viewport().size.y * zoom / 2.0
	_Camera2D.position.x = clamp(
		_Camera2D.position.x + position_offset.x, size_x_half, MAP_SIZE_X - size_x_half
	)
	_Camera2D.position.y = clamp(
		_Camera2D.position.y + position_offset.y, size_y_half, MAP_SIZE_Y - size_y_half
	)


func set_zoom(new_zoom):
	zoom = clamp(new_zoom, MIN_ZOOM, MAX_ZOOM)


func _on_MyTextureRect_mouse_entered(my_texture_rect:MyTextureRect):
#	var num=my_texture_rect.name.trim_prefix("PartMap")
#	var border:ReferenceRect= get_node("Chunks/Border"+num)
#	border.visible=true
#	print("yyy")
	if current_border != null:
		current_border.queue_free()
	current_border=Line2D.new()
	current_border.width=8 if zoom<4 else 18 #随着地图缩放，调节线段宽度
#	print(current_border.width)
	current_border.default_color=Color.red
	current_border.add_point(Vector2(my_texture_rect.rect_position.x,my_texture_rect.rect_position.y))
	current_border.add_point(Vector2(my_texture_rect.rect_position.x+my_texture_rect.rect_size.x,my_texture_rect.rect_position.y))
	current_border.add_point(Vector2(my_texture_rect.rect_position.x+my_texture_rect.rect_size.x,my_texture_rect.rect_position.y+my_texture_rect.rect_size.y))
	current_border.add_point(Vector2(my_texture_rect.rect_position.x,my_texture_rect.rect_position.y+my_texture_rect.rect_size.y))
	current_border.add_point(Vector2(my_texture_rect.rect_position.x,my_texture_rect.rect_position.y))
#	current_border.z_index=10
	_Chunks.add_child(current_border)
	current_map_num=my_texture_rect.name.trim_prefix("PartMap")
	

func _load_mapstate():
	var file=File.new()
	if not file.file_exists("res://Json/map_state.json"):
		print("文件不存在")
		_format_mapstate()
		return
		
	file.open("res://Json/map_state.json",File.READ)
#	var line=[]
#	while file.get_position()<file.get_len():
	var map_json=parse_json(file.get_as_text())
#	print(map_json)

	if map_json.size()>0:
		map_state.clear()
		
		for i in map_json["MapState"]:
			map_state.append(i as int)
			if i as int ==1:
#				print("Chunks/PartMap%d"%(map_state.size()-1))
				get_node("Chunks/PartMap%d"%(map_state.size()-1)).modulate=Color.green
#				$Chunks/TextureRect.modulate=Color.green
#			print(i)
#		print(map_state)	
	else:
		_format_mapstate()
#	var data=parse_json(file.g())
#		data[str(l)]
#		label.text+="name:%s\n"%data["name"]
#		label.text+="value:%s\n"%data["value"]
#		label.text+="age:%d\n"%data["age"]
#		print(data)
	file.close()

func _format_mapstate():
	map_state.clear()
	for i in 108:
		map_state.append(0)
	var save_file=File.new()
	var state={"MapState":map_state}
	save_file.open("res://Json/map_state.json",File.WRITE)
	save_file.store_string(JSON.print(state,"\t"))
	save_file.close()
