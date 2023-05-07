extends GridContainer

@export var field_size := 10

var mine_button_scene = preload("res://mine_button.tscn")

signal mine_found

func _ready():
	reset()


func reset():
	var minefield_generator := MinefieldGenerator.new()
	var minefield = minefield_generator.generate(field_size)
	self.columns = field_size
	
	for i in len(minefield):
		for j in len(minefield[i]):
			var button = mine_button_scene.instantiate()
			button.name = "Mine,{0},{1}".format([i, j])
			button.mine_value = minefield[i][j]
			button.connect("mine_revealed", _on_mine_button_revealed)
			add_child(button)


func _on_mine_button_revealed(button: MineButton):
	if button.mine_value == 0:
		var name_parts = button.name.split(",")
		var i = int(name_parts[1])
		var j = int(name_parts[2])
		
		_reveal_cell(i-1, j-1)
		_reveal_cell(i-1, j)
		_reveal_cell(i-1, j+1)
		_reveal_cell(i, j-1)
		_reveal_cell(i, j+1)
		_reveal_cell(i+1, j-1)
		_reveal_cell(i+1, j)
		_reveal_cell(i+1, j+1);
	elif button.mine_value == -1:
		mine_found.emit()


func _reveal_cell(i: int, j: int):
	if i >= 0 and i < field_size and j >= 0 and j < field_size:
		var mine = _get_mine_button_with_index(i, j)
		if not mine.disabled:
			mine.emit_signal("button_up")


func _get_mine_button_with_index(i: int, j: int) -> MineButton:
	var child_index = (i * columns) + j
	return get_child(child_index)
