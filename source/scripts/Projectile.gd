extends Area2D

# GLOBAL VARIABLE IMPORTS
const GLOBAL = preload("res://scripts/GLOBAL.gd")
onready var global_instance = GLOBAL.new()
onready var speed = global_instance.SHIP_SHOT_SPEED


# Declare member variables here. Examples:
# var a = 2
# var b = "text"




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_position.y += -speed * delta


func _on_Projectile_area_entered(area):
	pass
	if not area.is_in_group("player"):
		queue_free()
