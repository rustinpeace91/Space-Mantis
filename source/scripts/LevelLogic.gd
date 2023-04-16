extends Node2D


# GLOBAL VARIABLE IMPORTS
const GLOBAL = preload("res://scripts/GLOBAL.gd")
onready var global_instance = GLOBAL.new()

var laser = preload("res://scenes/Projectile.tscn") 
var enemy_laser = preload("res://scenes/EnemyProjectile.tscn")

var bug_ship = preload("res://scenes/BugShip.tscn")
var mantis = preload("res://scenes/Mantis.tscn")
var enemy_count = 0
var random = RandomNumberGenerator.new()

var level_number;

# DIFFICULTY FACTORS
var mantis_count = 0
var spawn_grid
var spawngrids = {
	1: 'FourGrid', 
	2: 'FourGrid', 
	3: 'FiveGrid'
}

signal player_dead
signal enemy_destroyed
signal enemies_cleared

func init(
	difficulty_params
):
	self.spawn_grid = $SpawnGrid.get_node(spawngrids[1])
	self.mantis_count = difficulty_params['mantis_count']


# Called when the node enters the scene tree for the first time.
func _ready():
	
	$AnimationPlayer.play("shimmy")
	$ShotTimer.wait_time = global_instance.ENEMY_SHOT_COOLDOWN
	$ShotTimer.start()

	for p in spawn_grid.get_children():
		var new_enemy
		enemy_count +=1
		if p.is_in_group("mantis_point") and mantis_count > 0:
			new_enemy = mantis.instance()
			mantis_count -=1
		else:
			new_enemy = bug_ship.instance()
		new_enemy.global_position = p.global_position
		new_enemy.connect("enemy_destroyed", self, "enemy_destroyed")
		spawn_grid.add_child(new_enemy)


		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ship_shoot():
	var laser_instance = laser.instance()
	laser_instance.global_position  = $Ship.get_node("Muzzle").global_position
	add_child(laser_instance)



func enemy_shot():
	random.randomize()
	var position_seed = random.randi_range(0, enemy_count)
	var counter = 0
	for child in self.spawn_grid.get_children():
		if child.is_in_group("enemies") and counter == position_seed:
			child.shoot()
			break;
		elif child.is_in_group("enemies"):
			counter +=1

func enemy_destroyed():
	emit_signal("enemy_destroyed")
	enemy_count -=1
	if enemy_count == 0: 
		emit_signal("enemies_cleared")

func _on_ShotTimer_timeout():
	enemy_shot()


func _on_Ship_player_dead():
	emit_signal("player_dead")
