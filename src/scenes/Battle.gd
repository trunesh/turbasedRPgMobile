extends Node

const BattleUnits = preload ("res://src/battleUnits.tres")

#onready var hpLabel=$Enemy/HPLabel
#onready var enemy = $Enemy  
#onready var playerStats = $PlayerStats
export (Array, PackedScene) var enemies = []


onready var battleActionButtons = $UI/BattleActionButtons
onready var animationPlayer = $AnimationPlayer
onready var nextRoomButton = $UI/CenterContainer/NextRoom
onready var enemyStartPosition = $EnemyPosition 

func _ready():
	randomize()
	start_player_turn()
	var enemy = BattleUnits.Enemy
	if enemy!=null:
		enemy.connect("died",self, "_on_Enemy_died")
		 
func start_enemy_turn():
	battleActionButtons.hide()
	var enemy = BattleUnits.Enemy
	if enemy!=null:
		enemy.attack()
		yield(enemy,"end_turn")
	start_player_turn()

func start_player_turn():
	battleActionButtons.show()
	var playerStats = BattleUnits.PlayerStats
	playerStats.ap = playerStats.max_ap
	yield(playerStats,"end_turn")
	print("playerStats_ON_BATTLE ",playerStats.ap)
	start_enemy_turn()
 
func create_new_enemy():
	print("Created the enemy!YAY")
	enemies.shuffle()
	var Enemy = enemies.front()
	var enemy = Enemy.instance()
	enemyStartPosition.add_child(enemy)
	enemy.connect("died",self,"_on_Enemy_died")
#	var enemy = BattleUnits.Enemy
#	if enemy!=null:
#		enemy.connect("on_death",self, "_on_Enemy_died")
func _on_Enemy_died():
	
	nextRoomButton.show()
	battleActionButtons.hide()

func _on_NextRoom_pressed():
	nextRoomButton.hide()
	animationPlayer.play("FadeToNewRoom")
	yield(animationPlayer,"animation_finished")
	var playerStats = BattleUnits.PlayerStats
	playerStats.ap = playerStats.max_ap
	battleActionButtons.show()
	create_new_enemy()

