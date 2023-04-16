extends Area2D

# GLOBAL VARIABLE IMPORTS
const GLOBAL = preload("res://scripts/GLOBAL.gd")
onready var global_instance = GLOBAL.new()
onready var speed = global_instance.ENEMY_SHOT_SPEED
export (int) var x_skew = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_position.y += speed * delta
	global_position.x += x_skew * delta




func _on_Projectile_area_entered(area):
	if area.is_in_group("player"):
		queue_free()
