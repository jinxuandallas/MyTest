extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var a=10
	var b=12 if a<5 else 666
	print("xxxx")
	print(a)
	print(b)
	
	print("xxx"+str(a))
	
	var d:Dictionary
	d[str(a)]=[0,0,1,2]
	d[22]=[1,3,4,5]
	print(d)
	print(to_json(d))
	
	print (Vector2(2000,1000).angle())
	print(get_viewport().size)
	print(get_viewport_rect().size)
	$ConfirmationDialog.get_cancel().connect("pressed",self,"_cancelled")

func _input(event):
	if event is InputEventKey:
		if event.scancode==KEY_ESCAPE:
			$ConfirmationDialog.popup()
			print("66666")
#	if Input.is_key_pressed(KEY_ESCAPE):
#		$ConfirmationDialog.popup()
#		print("66666")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
#func _physics_process(delta):
#	if Input.is_key_pressed(KEY_ESCAPE):
#		$ConfirmationDialog.popup()

func _on_Button_pressed():
	$ConfirmationDialog.popup()

func _cancelled():
	print("xxxxx")


func _on_ConfirmationDialog_confirmed():
	print("aaaaa")
