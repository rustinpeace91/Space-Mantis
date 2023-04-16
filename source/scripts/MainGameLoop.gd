extends Node2D

var level_logic = preload("res://scenes/LevelLogic.tscn")

var LEVELS = [
	{'mantis_count': 0, 'enemy_density': '1'},
	{'mantis_count': 1, 'enemy_density': '1'},
	{'mantis_count': 2, 'enemy_density': '2'},
	{'mantis_count': 4, 'enemy_density': '3'}
]

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#GLOBALS
var lives = 3
var score = 0
var current_level_number = 1
var current_level_instance; 

# Called when the node enters the scene tree for the first time.
func _ready():
	print(LEVELS.size())
	refresh_level(current_level_number)



func refresh_level(level_index):
	if current_level_instance:
		current_level_instance.queue_free()
	current_level_instance = level_logic.instance()
	#TODO: Refactor this into one function
	current_level_instance.call('init', LEVELS[level_index - 1])
	current_level_instance.level_number = current_level_number
	current_level_instance.connect("player_dead", self, "remove_life")
	current_level_instance.connect("enemy_destroyed", self, "up_score")
	current_level_instance.connect("enemies_cleared", self, "change_level")
	get_tree().get_root().call_deferred("add_child", current_level_instance)

func remove_life():
	lives -= 1
	if lives <= 0:
		if current_level_instance:
			current_level_instance.queue_free()
		get_tree().change_scene("res://scenes/GameOver.tscn")
	else:
		$Lives.get_node("liveslabel").text = "Lives: " + String(lives)


func up_score():
	score += 100
	$Score/Label.text = "Score: " + String(score)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func change_level():
	current_level_number += 1 
	if current_level_number >  LEVELS.size():
		if current_level_instance:
			current_level_instance.queue_free()
		get_tree().change_scene("res://scenes/WinScreen.tscn")
	else:
		$AnimationPlayer.play("Level Cleared")
	


func _on_AnimationPlayer_animation_finished(anim_name):
	# TODO: tie refresh level to something other than the animation finished event
	refresh_level(current_level_number)
