extends TileMap

onready var tilemap = $"."
onready var start = $pos1
onready var target = $pos2


var path = []


func _process(delta: float) -> void:
	path = []
	path = get_path_bfs(start.position / 32, target.position / 32)



func global_position_to_tilemap_pos(pos):
	var t_pos = tilemap.world_to_map(pos)
	return {"x": int(round(t_pos.x)), "y": int(round(t_pos.y))}

func can_move_to_spot(cell_pos):
	return tilemap.get_cell(cell_pos.x, cell_pos.y) < 0

var queue = []
var visited = {}
const MAX_ITERS = 10000
func get_path_bfs(start_pos, goal_pos):
	if !can_move_to_spot(goal_pos):
		return []
	queue = []
	visited = {}
	queue.push_back({"pos": start_pos, "last_pos": null})
	var iters = 0
	while queue.size() > 0:
		var cell_info = queue.pop_front()
		if check_cell(cell_info.pos, cell_info.last_pos, goal_pos):
			break
		iters += 1
		if iters >= MAX_ITERS:
			return []
	var backtraced_path = []
	var cur_pos = goal_pos
	while str(cur_pos) in visited and visited[str(cur_pos)] != null:
		if cur_pos != null:
			backtraced_path.append(cur_pos)
		cur_pos = visited[str(cur_pos)]
	backtraced_path.invert()
	return backtraced_path

func check_cell(cur_pos, last_pos, goal_pos):
	if !can_move_to_spot(cur_pos):
		return false
	if str(cur_pos) in visited:
		return false
	
	visited[str(cur_pos)] = last_pos
	if cur_pos.x == goal_pos.x and cur_pos.y == goal_pos.y:
		return true
	queue.push_back({"pos": {"x": cur_pos.x, "y": cur_pos.y + 32}, "last_pos": cur_pos})
	queue.push_back({"pos": {"x": cur_pos.x + 32, "y": cur_pos.y}, "last_pos": cur_pos})
	queue.push_back({"pos": {"x": cur_pos.x, "y": cur_pos.y - 32}, "last_pos": cur_pos})
	queue.push_back({"pos": {"x": cur_pos.x - 32, "y": cur_pos.y}, "last_pos": cur_pos})
	return false
