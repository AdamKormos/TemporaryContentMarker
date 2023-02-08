extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	# no-checkin
	print("Just testing this here...")
	var i = randi() % 10
	var x = pow(i, 3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
