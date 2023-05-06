class_name MinefieldGenerator
extends Object

func generate(n: int) -> Array:
	var matrix := []
	matrix.resize(n)
	
	# Create an NxN matrix filled with zeroes
	for i in len(matrix):
		matrix[i] = []
		matrix[i].resize(n)
		for j in len(matrix[i]):
			matrix[i][j] = 0
	
	# Add mines in random locations
	var mines := n
	while mines > 0:
		var x = randi_range(0, n-1)
		var y = randi_range(0, n-1)
		if matrix[x][y] != -1:
			matrix[x][y] = -1
			mines -= 1
	
	# Increment values in adjacent cells
	for i in len(matrix):
		for j in len(matrix):
			if matrix[i][j] == -1:
				_increment_cell_in_matrix(matrix, i-1, j-1)
				_increment_cell_in_matrix(matrix, i-1, j)
				_increment_cell_in_matrix(matrix, i-1, j+1)
				_increment_cell_in_matrix(matrix, i, j-1)
				_increment_cell_in_matrix(matrix, i, j+1)
				_increment_cell_in_matrix(matrix, i+1, j-1)
				_increment_cell_in_matrix(matrix, i+1, j)
				_increment_cell_in_matrix(matrix, i+1, j+1)
	
	return matrix


func _increment_cell_in_matrix(matrix: Array, i: int, j: int) -> void:
	if (i >= 0) and (i < len(matrix)) and (j >= 0) and (j < len(matrix)) \
			and (matrix[i][j] != -1):
		matrix[i][j] += 1
