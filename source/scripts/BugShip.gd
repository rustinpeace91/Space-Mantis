extends Area2D

signal enemy_destroyed
var enemy_laser = preload("res://scenes/EnemyProjectile.tscn")
var alive = true
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func destroyed():
	$AnimatedSprite.play("destroy")







func _on_BugShip_area_entered(area):
	
	if area.is_in_group("bullets") and self.alive == true:
		self.alive = false
		destroyed()
		emit_signal("enemy_destroyed")


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "destroy":
			queue_free()


func shoot():
	var laser = enemy_laser.instance()
	# TODO: Fix scaling issues
	laser.scale.x = 10
	laser.scale.y = 10
	laser.position.y = $ShotPos.position.y
	laser.position.x = $ShotPos.position.x
	var shotpos = $ShotPos
	add_child(laser)
