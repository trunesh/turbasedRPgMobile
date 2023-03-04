extends "res://ActionButton.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _on_pressed():
	var main  = get_tree().current_scene
	var enemy = main.find_node("Enemy")
	var playerStats = main.find_node("PlayerStats")
	if enemy!=null and playerStats!=null:
		enemy.take_damage(4)
		playerStats.mp+=2
		playerStats.ap-=1


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
