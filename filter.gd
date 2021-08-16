extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var cr=$ColorRect

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ColorRect_mouse_entered():
	print("aaa")
	cr.color=Color(1,1,1,0.4)
	


func _on_ColorRect_mouse_exited():
	print("bbb")
	cr.color=Color(1,0,0,0)
