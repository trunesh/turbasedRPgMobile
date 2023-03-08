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
onready var gameStartEndPauseTry= $GameStartEndPauseTry
onready var startGame = $GameStartEndPauseTry/StartGame
onready var tryAgain=$GameStartEndPauseTry/TryGame
onready var UI = $UI
func _ready():
	randomize()
	start_player_turn()
	var enemy = BattleUnits.Enemy
	if enemy!=null:
		enemy.connect("died",self, "_on_Enemy_died")
		 
func start_enemy_turn():
	battleActionButtons.hide()
	var enemy = BattleUnits.Enemy
	if enemy!=null and not enemy.is_queued_for_deletion():
		enemy.attack()
		yield(enemy,"end_turn")
	var playerStats = BattleUnits.PlayerStats
	checkPlayerHealth(playerStats)
	start_player_turn()


func checkPlayerHealth(playerStats):
	if playerStats.hp<=0:
		UI.hide()
		gameStartEndPauseTry.show()
		startGame.hide()
		enemyStartPosition.hide()
		tryAgain.show()
		
	

func start_player_turn(playerDied=false):
	battleActionButtons.show()
	var playerStats = BattleUnits.PlayerStats
	if playerDied==true:
		playerStats.hp = playerStats.max_hp
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



func _on_EndGame_pressed():
	get_tree().quit()


func _on_StartGame_pressed():
	gameStartEndPauseTry.hide()
	UI.show()
	nextRoomButton.hide()
	enemyStartPosition.show()
	pass # Replace with function body.


func _on_TryGame_pressed():
	randomize()
	start_player_turn(true)
	var enemy = BattleUnits.Enemy
	if enemy!=null:
		enemy.connect("died",self, "_on_Enemy_died")
	gameStartEndPauseTry.hide()
	UI.show()
	nextRoomButton.hide()
	enemyStartPosition.show()
	pass # Replace with function body.
