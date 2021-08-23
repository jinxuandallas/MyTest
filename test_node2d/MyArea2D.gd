extends Node2D
class_name MyTileMap

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var map: Sprite = $Area2D/CollisionShape2D/Map
onready var area = $Area2D
onready var collision_shape = $Area2D/CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_mouse_entered():
	print("in")


func _on_Area2D_mouse_exited():
	print("out")


func _on_Map_texture_changed():
	var sha = collision_shape.shape as RectangleShape2D
	sha.extents.x = map.get_rect().size.x / 2.0
	sha.extents.y=map.get_rect().size.y/2.0
	
