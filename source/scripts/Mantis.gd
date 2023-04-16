extends Area2D

# GLOBAL VARIABLE IMPORTS
const GLOBAL = preload("res://scripts/GLOBAL.gd")
onready var global_instance = GLOBAL.new()
onready var HP = global_instance.MANTIS_HP


signal enemy_destroyed

var enemy_laser = preload("res://scenes/EnemyProjectile.tscn")
var random = RandomNumberGenerator.new()
var alive = true
# Called when the node enters the scene tree for the first time.
func _ready():
	$ShotTimer.wait_time = global_instance.MANTIS_SHOT_COOLDOWN
	$ShotTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func destroyed():
	$AnimatedSprite.play("destroy")


func _on_Mantis_area_entered(area):
	HP -=1
	if area.is_in_group("bullets") and alive == true:
		if HP <=0:
			alive = false
			destroyed()
			emit_signal("enemy_destroyed")
		else:
			$AnimatedSprite.play("hit")
		

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "destroy":
			queue_free()



func _on_ShotTimer_timeout():
	var laser = enemy_laser.instance()
	var skews = global_instance.MANTIS_X_SKEW
	var position_seed = random.randi_range(0, skews.size() - 1)
	laser.x_skew = skews[position_seed]
	# TODO: Fix scaling issues
	laser.scale.x = 10
	laser.scale.y = 10
	laser.position.y = $ShotPos.position.y
	laser.position.x = $ShotPos.position.x
	var shotpos = $ShotPos
	add_child(laser)
