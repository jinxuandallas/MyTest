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


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
