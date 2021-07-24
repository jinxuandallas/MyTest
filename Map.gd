extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	test()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func test():
	var map=$"."
	var border=$ReferenceRect
	print(map is Sprite)
#	border.rect_size.x=map.region_rect.size.x
#	border.rect_size.y=map.region_rect.size.y
	
	border.rect_size.x=100
	border.rect_size.y=100
	print(map.region_rect.size.x)
	print(map.region_rect.size.y)
	
