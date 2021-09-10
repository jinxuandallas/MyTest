extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var pool_array_size := 10000
	var pool_array := PoolIntArray()
	for i in pool_array_size:
		pool_array.append(i)
	var start_time := 0
	var end_time := 0
	print("-----PoolArray size:%d-----" % pool_array_size)
	start_time = OS.get_system_time_msecs()
	print("start, time: %d" % start_time)
	var _temp = 0
	for i in pool_array_size:
		pool_array.remove(0)
#		pass
#		_temp = pool_array[i]
	end_time = OS.get_system_time_msecs()
	print("end, time: %d" % end_time)
	print("period: %d" % (end_time - start_time))
	
	var array_size := 10000
	var array := Array()
	for i in array_size:
		array.append(i if i % 2 == 0 else str(i))
	print("-----Array size:%d-----" % array_size)
	start_time = OS.get_system_time_msecs()
	print("start, time: %d" % start_time)
	for i in array_size:
		array.remove(0)
#		_temp = array[i]
	end_time = OS.get_system_time_msecs()
	print("end, time: %d" % end_time)
	print("period: %d" % (end_time - start_time))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
