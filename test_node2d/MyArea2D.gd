extends Node2D
class_name MyArea2DClass

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var map:Sprite=$Area2D/CollisionShape2D/Map
onready var area=$Area2D
onready var collision_shape=$Area2D/CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
