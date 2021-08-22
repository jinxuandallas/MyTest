extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var my_area2d: MyArea2DClass = load("res://test_node2d/MyArea2D.tscn").instance()
	add_child(my_area2d)
#	$MyArea2D/Area2D/CollisionShape2D/Sprite.texture=load("res://Map/88.jpg")
	print("yyy")
	my_area2d.map.texture = load("res://Map/91.jpg")
	print(my_area2d.map.name)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_mouse_entered():
	print("xxx")


func _on_Area2D_mouse_exited():
	print("yyy")
