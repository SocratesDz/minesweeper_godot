extends Control

@onready var minegrid := %MineGrid
@export var field_size := 10

var mine_button_scene = preload("res://mine_button.tscn")

func _ready():
	reset()


func reset():
	var minefield_generator := MinefieldGenerator.new()
	var minefield = minefield_generator.generate(field_size)
	minegrid.columns = field_size
	
	for i in len(minefield):
		for j in len(minefield[i]):
			var button = mine_button_scene.instantiate()
			button.name = "Mine,{0},{1}".format([i, j])
			button.mine_value = minefield[i][j]
			minegrid.add_child(button)


func _on_mine_button_revealed(button: MineButton):
	if button.mine_value == 0:
		var btn = minegrid.get_node(NodePath(button.name))
		var name_parts = button.name.split(",")
		var i = int(name_parts[1])
		var j = int(name_parts[2])
		
	pass
