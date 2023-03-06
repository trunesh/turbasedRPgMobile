extends "res://ActionButton.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const Slash = preload("res://src/scenes/Slash.tscn")

# Called when the node enters the scene tree for the first time.
func _on_pressed():
#	var main  = get_tree().current_scene
#	var enemy = main.find_node("Enemy")
	#var playerStats = main.find_node("PlayerStats")
	var playerStats = BattleUnits.PlayerStats
	var enemy = BattleUnits.Enemy
	if enemy!=null and playerStats!=null:
		create_slash(enemy.global_position)
		enemy.take_damage(4)
		playerStats.mp+=2
		playerStats.ap-=1
		print("SWORDACTION_BUTTON",playerStats.ap)


func create_slash(position):
	var slash = Slash.instance()
	var main = get_tree().current_scene
	main.add_child(slash)
	slash.global_position = position
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
