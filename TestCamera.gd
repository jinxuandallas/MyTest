extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera2D.position=Vector2(200,200)
	$"3".connect("sxx",self,"_sxx")
	
	var mtr=MyTextureRect.new()
	mtr.name="xxxxa4455aaa"
	mtr.connect("my_mouse_entered",self,"_show_name")
	mtr.texture=load("res://Map/7.jpg")
	self.add_child(mtr)
	
#	pass

func _sxx(vvv):
#	print(xx.name)
	print("sss	"+vvv.name)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	print("xxx")

func _show_name(my_TextureRect):
	print(my_TextureRect.name)
