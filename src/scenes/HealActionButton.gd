extends "res://ActionButton.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _on_pressed():
#	var main = get_tree().current_scene
#	var playerStats = main.find_node("PlayerStats")
	var playerStats = BattleUnits.PlayerStats
	if playerStats!= null : 
		if playerStats.mp>=8:
			playerStats.hp+=5
			playerStats.mp-=8
			playerStats.ap-=1
