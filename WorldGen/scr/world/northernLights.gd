extends TileMap

var worldSize: = Vector2(1024, 640)

onready var level = $"."
var tileSize = $".".cell_size
var tileWorldSize: = Vector2((worldSize.x / tileSize.x), (worldSize.y / tileSize.y))

var worldGrid: = []

func _ready() -> void:
	createGrid()
	placeTiles()
	print(len(worldGrid))


func createGrid():
	for x in tileWorldSize.x:
		for y in tileWorldSize.y:
			var tile = Vector2(x, y)
			worldGrid.append(tile)


func searchNodes():
	var startNode: Vector2 = Vector2(0, 0)
	var currentNode: Vector2 = startNode
	var targetNode: Vector2 = Vector2(28, 0)
	var checkedNodes: = []
	var targetNodeFound: = false
	
	while !targetNodeFound:
		
		if worldGrid currentNode + Vector2.UP:



func placeTiles():
	for tile in worldGrid:
		level.set_cellv(tile, 0)
