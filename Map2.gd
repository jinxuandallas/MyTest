extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var map=$TextureRect
onready var border=$ReferenceRect

# Called when the node enters the scene tree for the first time.
func _ready():
#	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	test()
	var l=Label.new()
	l.text="texture_rect"
	map.add_child(l)

func test():
	
#	print(map is Sprite)
#	border.rect_size.x=map.region_rect.size.x
#	border.rect_size.y=map.region_rect.size.y
	
	border.rect_size.x=map.get_rect().size.x
	border.rect_size.y=map.get_rect().size.y
	border.rect_position.x=map.get_rect().position.x
	border.rect_position.y=map.get_rect().position.y
#	print(map.texture.get_width())
#	print(map.region_rect.size.x)
#	print(map.region_rect.size.y)
	print(map.get_rect().size.x)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_TextureRect_mouse_entered():
#	border.visible=true
	border.show()
	


func _on_TextureRect_mouse_exited():
#	border.visible=false
	border.hide()
