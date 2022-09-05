extends TileMap


var astar: = AStar2D.new()

# Get the used area of the tilemap
var tileSize = get_node(".").cell_size
var size: Vector2 = Vector2((1024 / tileSize.x), (640 / tileSize.y))
#var size: Vector2 = get_used_rect().size

func _ready() -> void:
	print(size)
	generate_grid()
	#place_tiles(generate_path(Vector2(0, 0), Vector2(31, 19)))
	var pos1 = get_node("pos1").position / 32
	var pos2 = get_node("pos2").position / 32
	place_tiles(generate_path(pos1, pos2))


func generate_grid():

	# Prepare astar area
	astar.reserve_space(size.x * size.y)

	# Build Grid by mapping every tile to a point (grid cell)
	for x in size.x:
		for y in size.y:
			var tile_position = Vector2(x, y)
			astar.add_point(get_tile_id(tile_position), map_to_world(tile_position), 1)

	# Register Neighbours
	for x in size.x:
		for y in size.y:
			var id = get_tile_id(Vector2(x, y))
			var peek_tile_id

			# Neighbours (UP, DOWN, LEFT, RIGHT)
			peek_tile_id = get_tile_id(Vector2(x, y - 1))
			if astar.has_point(peek_tile_id):
				astar.connect_points(id, peek_tile_id, false)

			peek_tile_id = get_tile_id(Vector2(x, y + 1))
			if astar.has_point(peek_tile_id):
				astar.connect_points(id, peek_tile_id, false)

			peek_tile_id = get_tile_id(Vector2(x - 1, y))
			if astar.has_point(peek_tile_id):
				astar.connect_points(id, peek_tile_id, false)

			peek_tile_id = get_tile_id(Vector2(x + 1, y))
			if astar.has_point(peek_tile_id):
				astar.connect_points(id, peek_tile_id, false)

			# Reserve points with tiles
			if get_cell(x, y) != INVALID_CELL:
				astar.set_point_disabled(id, true)


# Gives each tile its own id
func get_tile_id(tile_pos: Vector2) -> int:
	return int(tile_pos.x + (tile_pos.y * size.x))


# Generates a path between two points
func generate_path(start: Vector2, target: Vector2) -> Array:
	var startId = get_tile_id(start)
	var targetId = get_tile_id(target)
	
	if astar.has_point(startId) && astar.has_point(targetId):
		print("Points exist ", start, target)
		return Array(astar.get_point_path(startId, targetId))
	else:
		return []


func place_tiles(path: Array):
	var tilemap = $"."

	for coordinates in path:
		var worldCoordinates: Vector2 = coordinates / 32
		tilemap.set_cellv(worldCoordinates, 1)
