extends Node2D

const BattleUnits = preload("res://src/battleUnits.tres")

export(int) var hp = 25 setget set_hp
export(int) var attack_damage = 4



onready var hpLabel = $HPLabel

onready var animationPlayer = $AnimationPlayer

signal died
signal end_turn

func set_hp(new_hp):
	hp = new_hp
	if hpLabel!=null:
		hpLabel.text= str(hp) + "hp"
	


func _ready():
	BattleUnits.Enemy = self

func _exit_tree():
	BattleUnits.Enemy = null
#	if hp <=0:
#		emit_signal("on_death")
#		queue_free()
#	else:
#		animationPlayer.play("Shake") 
#		yield(animationPlayer, "animation_finished")
#		animationPlayer.play("Attack")
#		yield(animationPlayer,"animation_finished")
#		var battle = get_tree().current_scene
#		var player = battle.find_node("PlayerStats")
#		player.hp-=3

func attack()-> void:
	yield(get_tree().create_timer(0.4),"timeout")
	animationPlayer.play("Attack")
	yield(animationPlayer,"animation_finished")
	emit_signal("end_turn")
	
func take_damage(amount):
	self.hp-=amount
	if is_dead():
		emit_signal("died")
		queue_free()
	else:
		animationPlayer.play("Shake")
func is_dead():
	return hp <=0

func deal_damage():
	BattleUnits.PlayerStats.hp -=attack_damage
#	print("deal damage")
	
	
