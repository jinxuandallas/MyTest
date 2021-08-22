extends Sprite
signal sxx(vvv)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
#	$".".connect("sxx",self,"_sxx")
#	emit_signal("sxx")

func _sxx():
	print("bbb")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	emit_signal("sxx",self)
