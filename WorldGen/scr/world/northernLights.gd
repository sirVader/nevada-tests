extends TileMap


# -----------------------------------------------------


class bStar:
	
	var point_id: int
	var point_position: Vector2
	
	# Float between 1.0 - 0.0
	var wheight: float = 1.0
	
	# Array with point connections
	var connections: Array = [] 


class bStar2D:
	extends bStar
	
	# Dictionary with all regiserd points
	var points: Dictionary = {}


# -----------------------------------------------------


	# Clears all points from dictionary
	func clear():
		points.clear()


	# Adds point to the dictionary, id must be bigger than 0
	func add_point(id: int, pos: Vector2):
		if !(id in points) and id > 0:
			var new_point = bStar.new()
			new_point.point_id = id
			new_point.point_position = pos
			points[id] = new_point


	# Check if points exists in connections array
	func are_points_connected(id: int, to_id: int, bidirectional: bool = true) -> bool:
		if id in points and to_id in points and id != to_id:
			if points[to_id] in points[id].connections:
				if !bidirectional:
					return true
				elif bidirectional:
					if points[id] in points[to_id].connections:
						return true
					else:
						return false
				else:
					return false
			else:
				return false
		else:
			return false


	# Adds point to connection array in the point with corresponding id
	# Connection id => to_id
	func connect_points(id: int, to_id: int, bidirectional: bool = true):
		if id in points and to_id in points and id != to_id:
			points[id].connections.append(points[to_id])
			# Connection to_id => id
			if bidirectional:
				points[to_id].connections.append(points[id])


	func disconnect_points(id: int, to_id: int, bidirectional: bool = true):
		if id in points and to_id in points and id != to_id:
			points[id].connections.erase(points[to_id])
			if bidirectional:
				points[to_id].connections.erase(points[id])


	# Gets the next avalible point id from points dict
	func get_available_point_id() -> int:
		var dict_keys: Array = points.keys()
		var key: int = 0
		
		while true:
			key += 1
			if !(key in dict_keys):
				return key
		return -1


	func _calculate_angle(pos1: Vector2, pos2: Vector2) -> float:
		var angle: float
		# angle = abs(rad2deg(atan2(pos2.y - pos1.y, pos2.x - pos1.x)))
		angle = 0
		return angle


	func get_point_path(from_id: int, to_id: int) -> Array:
		var queue: Array = []
		var visited: Array = []
		var path: Array = []
		var goal_point = points[to_id]
		
		if from_id in points and to_id in points and from_id != to_id:
			queue.push_back(points[from_id])
			
			while queue.size() > 0:
				var point = queue.pop_front()
				var to_point_angle = _calculate_angle(point.point_position, goal_point.point_position)
				var point_direction: Vector2 = Vector2.ZERO
				
				if !(point in visited):
					visited.append(point)
					
					# Gets direction to move in
					if 135 > to_point_angle and to_point_angle >= 45:
						point_direction = Vector2.UP
					elif 225 > to_point_angle and to_point_angle >= 135:
						point_direction = Vector2.LEFT
					elif 315 > to_point_angle and to_point_angle >= 225:
						point_direction = Vector2.DOWN
					elif 45 > to_point_angle or 360 >= to_point_angle and to_point_angle >= 315:
						point_direction = Vector2.RIGHT
					
					
					print(point_direction)
					
					
					if !(points[to_id] in point.connections):
						for new_point in point.connections:
							queue.push_back(new_point)
					else:
						break
			
			
			var backtraced_path: Array = []
			var current_position = points[to_id]
			
			return path
		else:
			return []

# -----------------------------------------------------


var _bStar: = bStar2D.new()

func _ready() -> void:
	_bStar.add_point(1, Vector2(128, 128))
	_bStar.add_point(2, Vector2(64, 32))
	_bStar.connect_points(1, 2)
	print(_bStar.get_available_point_id())
	print(_bStar.get_point_path(1, 2))

