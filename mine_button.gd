class_name MineButton
extends Button

@export var mine_value = 0

signal mine_revealed(MineButton)

func _ready() -> void:
	self.button_up.connect(_on_button_clicked)

func _on_button_clicked() -> void:
	if mine_value > 0:
		self.text = str(mine_value)
	else:
		self.text = ""
	self.disabled = true
	mine_revealed.emit(self)
