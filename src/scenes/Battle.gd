extends Node

onready var hpLabel=$Enemy/HPLabel
onready var enemy = $Enemy
onready var playerStats = $PlayerStats
onready var battleActionButtons = $UI/BattleActionButtons

func _ready():
	start_player_turn()
	
func start_enemy_turn():
	battleActionButtons.hide()
	if enemy!=null:
		enemy.attack(playerStats)
		yield(enemy,"end_turn")
	start_player_turn()

func start_player_turn():
	battleActionButtons.show()
	playerStats.ap = playerStats.max_ap
	yield(playerStats,"end_turn")
	start_enemy_turn()
 

func _on_Enemy_on_death(): 
	battleActionButtons.hide()
	enemy=null
