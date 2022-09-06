extends TileMap


class bStar:
	
	var point_id: int
	var point_position: Vector2
	
	# Array with point connections
	var connections: Array = [] 


class bStar2D:
	extends bStar
	
	# Dictionary with all regiserd points
	var points: Dictionary = {}

	# Adds point to the dictionary, id must be bigger than 0
	func add_point(id: int, pos: Vector2):
		if !(id in points) and id > 0:
			var new_point = bStar.new()
			new_point.point_id = id
			new_point.point_position = pos
			points[id] = new_point


	# Check if points exists in connections array
	func are_points_connected(id: int, to_id: int, bidirectional: bool = true) -> bool:
		if id in points and to_id in points:
			if points[to_id] in points[id].connections:
				if !bidirectional:
					return true
				elif bidirectional:
					if points[id] in points[to_id].connections:
						return true
					else:
						print("This4")
						return false
				else:
					print("This3")
					return false
			else:
				print("This2")
				return false
		else:
			print("This1")
			return false


	# Adds point to connection array in the point with corresponding id
	# Connection id => to_id
	func connect_points(id: int, to_id: int, bidirectional: bool = true):
		if id in points and to_id in points:
			points[id].connections.append(points[to_id])
			# Connection to_id => id
			if bidirectional:
				points[to_id].connections.append(points[id])


var _bStar: = bStar2D.new()

func _ready() -> void:
	_bStar.add_point(1, Vector2(128, 128))
	_bStar.add_point(2, Vector2(64, 32))
	_bStar.connect_points(1, 2)
	print(_bStar.points[1].connections[0].point_id)
	print(_bStar.are_points_connected(1, 2))
