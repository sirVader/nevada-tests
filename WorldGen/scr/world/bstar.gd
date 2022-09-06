
class bStar:
	extends TileMap
	
	var point_id: int
	var point_position: Vector2

class bStar2D:
	extends bStar
	
	var points: Dictionary

	func add_point(id: int, position: Vector2):
		if !(id in points):
			var new_point = bStar.new()
			new_point.point_position = position
			points[id] = new_point
