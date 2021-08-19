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


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
