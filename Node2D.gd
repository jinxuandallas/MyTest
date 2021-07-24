extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_WriteButton_pressed():
	#print("Hello world!") 
	save()

func save():
	var save_file=File.new()
	save_file.open("res://Json/test123.json",File.WRITE)
	var json={"name":"xxx","value":"yyy","age":18}
	save_file.store_line(to_json(json))
#	save_file.store_line(JSON.print(json,"\t"))
	save_file.close()
	
	print("成功")


func _on_ReadButton_pressed():
	read()

func read():
	var file=File.new()
	if not file.file_exists("res://Json/test123.json"):
		print("文件不存在")
		return
		
	file.open("res://Json/test123.json",File.READ)
	while file.get_position()<file.get_len():
		var data=parse_json(file.get_line())
		var label=$Label
		label.text+="name:%s\n"%data["name"]
		label.text+="value:%s\n"%data["value"]
		label.text+="age:%d\n"%data["age"]
#		print(data)

	
