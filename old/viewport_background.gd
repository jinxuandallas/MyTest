extends Node2D
class_name MapEditor

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const SPEED=200

var in_edge
var active_color_rect
var map_data=[]
#var num

onready var background=$ParallaxBackground
onready var margin_container=$"Viewport/MarginContainer"
onready var screen_size=get_viewport_rect().size
onready var map=$"ParallaxBackground/ParallaxLayer/53"
#onready var rect=$"ParallaxBackground/ParallaxLayer/53/ColorRect"
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in 21:
		var l=Line2D.new()
		l.add_point(Vector2(i*50,0))
		l.add_point(Vector2(i*50,1000))
		l.default_color=Color.red
		l.width=2
		map.add_child(l)
		
	print(get_tree().get_meta("MapNum"))
		
	for i in 21:
		var l=Line2D.new()
		l.add_point(Vector2(0,i*50))
		l.add_point(Vector2(1000,i*50))
		l.default_color=Color.red
		l.width=2
		map.add_child(l)
	
	_load_map()
	
	for i in 20:
#		var line_data=[]
		for j in 20:
			var cr=ColorRect.new()
			cr.rect_position=Vector2(i*50,j*50)
			cr.rect_size=Vector2(50,50)
			
			#初始化所有格子的颜色
			var type=map_data[j][i]
			cr.color=_get_color(type)
			if type==0:
				cr.color.a=0
			else:
				cr.color.a=0.6
				
#			cr.visible=false
			cr.connect("mouse_entered",self,"_on_ColorRect_mouse_entered",[cr])
			cr.connect("mouse_exited",self,"_on_ColorRect_mouse_exited",[cr])
			map.add_child(cr)
			
#			line_data.append(0)
			
#		map_data.append(line_data)
	
		
#	print(map_data.size())
	$ParallaxBackground/ParallaxLayer/GridContainer/ColorRect1.color=Color.goldenrod
	$ParallaxBackground/ParallaxLayer/GridContainer/ColorRect2.color=Color.yellowgreen
	$ParallaxBackground/ParallaxLayer/GridContainer/ColorRect3.color=Color.dodgerblue
	$ParallaxBackground/ParallaxLayer/GridContainer/ColorRect4.color=Color.cornflower
	$ParallaxBackground/ParallaxLayer/GridContainer/ColorRect5.color=Color.darkgreen
	$ParallaxBackground/ParallaxLayer/GridContainer/ColorRect6.color=Color.darkorange
	$ParallaxBackground/ParallaxLayer/GridContainer/ColorRect7.color=Color.sienna
	$ParallaxBackground/ParallaxLayer/GridContainer/ColorRect8.color=Color.cadetblue
	$ParallaxBackground/ParallaxLayer/GridContainer/ColorRect9.color=Color.firebrick
	
#	$ParallaxBackground/VBoxContainer/HBoxContainer1/ColorRect.color=Color.peru
#	$ParallaxBackground/VBoxContainer/HBoxContainer1/ColorRect.color=Color.peru
#	$ParallaxBackground/VBoxContainer/HBoxContainer1/ColorRect.color=Color.peru
#	$ParallaxBackground/VBoxContainer/HBoxContainer1/ColorRect.color=Color.peru
#	print(map_data)

	
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
	
	if Input.is_action_pressed("ui_cancel"):
		$WindowDialog.popup()
		_save_map()
		
	if active_color_rect!=null:
		if Input.is_action_pressed("0"):
			_handle_pressed(0)
#			active_color_rect.color=Color(1,1,1,0.7)
		if Input.is_action_pressed("1"):
#			var coordinate=_get_color_rect_num(active_color_rect)
#			map_data[coordinate.y][coordinate.x]=1
#			print(coordinate)
#			active_color_rect.color=_get_color(1)
#			active_color_rect.color.a=0.6
			_handle_pressed(1)
			
		if Input.is_action_pressed("2"):
			_handle_pressed(2)
		
		if Input.is_action_pressed("3"):
			_handle_pressed(3)
			
		if Input.is_action_pressed("4"):
			_handle_pressed(4)
			
		if Input.is_action_pressed("5"):
			_handle_pressed(5)
			
		if Input.is_action_pressed("6"):
			_handle_pressed(6)
			
		if Input.is_action_pressed("7"):
			_handle_pressed(7)
			
		if Input.is_action_pressed("8"):
			_handle_pressed(8)
			
		if Input.is_action_pressed("9"):
			_handle_pressed(9)
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _handle_pressed(key_type):		#处理按键后的逻辑
	var coordinate=_get_color_rect_num(active_color_rect)
	map_data[coordinate.y][coordinate.x]=key_type
	active_color_rect.color=_get_color(key_type)
	active_color_rect.color.a=0.6

func _get_color_rect_num(color_rect:ColorRect):		#根据ColorRect对象判断其在map_data中的坐标
	var x=color_rect.rect_position.x/50
	var y=color_rect.rect_position.y/50
	return Vector2(x,y)

func _on_MarginContainer_mouse_entered():
	in_edge=true


func _on_MarginContainer_mouse_exited():
	in_edge=false

func _save_map():
	var save_file=File.new()
	save_file.open("res://Json/53.json",File.WRITE)
#	var json={"name":"xxx","value":"yyy","age":18}
	var l=1
	var map_dic:Dictionary
	while l<=map_data.size():
		map_dic[l]=map_data[l-1]
#		var json={l:map_data[l-1]}
#		save_file.store_line(to_json(json))
		l+=1
		
	save_file.store_string(JSON.print(map_dic,"\t"))
	print(JSON.print(map_dic,"\t"))
#	save_file.store_line(to_json(map_data))
#	save_file.store_line(JSON.print(json,"\t"))
	save_file.close()

func _load_map():
	var file=File.new()
	if not file.file_exists("res://Json/53.json"):
		print("文件不存在")
		_format_mapdata()
		return
		
	file.open("res://Json/53.json",File.READ)
#	var line=[]
#	while file.get_position()<file.get_len():
	var map_json=parse_json(file.get_as_text())
#	print(map_json)

	if map_json.size()>0:
		map_data.clear()
		
		for i in map_json:
			var line_int=[]
			for j in map_json[i]:
				line_int.append(j as int)
			map_data.append(line_int)
			
	else:
		_format_mapdata()
#	var data=parse_json(file.g())
#		data[str(l)]
#		label.text+="name:%s\n"%data["name"]
#		label.text+="value:%s\n"%data["value"]
#		label.text+="age:%d\n"%data["age"]
#		print(data)
func _format_mapdata():
	for i in 20:
		var line_data=[]
		for j in 20:
			line_data.append(0)
		map_data.append(line_data)

func _on_ColorRect_mouse_entered(color_rect):
#	if color_rect.color.r==1&&color_rect.color.g==1&&color_rect.color.b==1:
	color_rect.color=Color(1,1,1,0.6)
#	else:
#		color_rect.color==Color(1,1,1,0.7)
	active_color_rect=color_rect
#	color_rect.visible=true
#	print("xxx")


func _on_ColorRect_mouse_exited(color_rect):
#	if color_rect.color.r==1&&color_rect.color.g==1&&color_rect.color.b==1:
#		color_rect.color.a=0
	var coordinate=_get_color_rect_num(color_rect)
	var type=map_data[coordinate.y][coordinate.x]  #用json转换成Array所有的数字都转成了float，所以这里需要强制转换成int
#	print(type)
	color_rect.color=_get_color(type)
	if type==0:
		color_rect.color.a=0
	else:
		color_rect.color.a=0.6
		
	active_color_rect=null
#	print("yyy")

func _get_color(type):		#根据不同类型返回相应颜色
	var return_color
	match type:
		0:
			return_color=Color(1,1,1)
		1:
			return_color=Color.goldenrod
		2:
			return_color=Color.yellowgreen
		3:
			return_color=Color.dodgerblue
		4:
			return_color=Color.cornflower
		5:
			return_color=Color.darkgreen
		6:
			return_color=Color.darkorange
		7:
			return_color=Color.sienna
		8:
			return_color=Color.cadetblue
		9:
			return_color=Color.firebrick
	return return_color
