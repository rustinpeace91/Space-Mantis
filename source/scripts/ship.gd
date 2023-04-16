extends KinematicBody2D

# GLOBAL VARIABLE IMPORTS
const GLOBAL = preload("res://scripts/GLOBAL.gd")
onready var global_instance = GLOBAL.new()
onready var speed = global_instance.SHIP_SPEED
onready var shot_timeout = global_instance.SHIP_SHOT_COOLDOWN

var velocity = Vector2()
var can_shoot = true;

signal shoot
signal player_dead

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
#	if Input.is_action_pressed("down"):
#		velocity.y += 1
#	if Input.is_action_pressed("up"):
#		velocity.y -= 1
	velocity = velocity.normalized() * speed
	if Input.is_action_just_released("fire"):
		fire_shot()

func _ready():
	$ShotTimer.wait_time = global_instance.SHIP_SHOT_COOLDOWN

func _physics_process(delta):
	get_input()
	move_and_collide(velocity * delta)


func fire_shot():
	if can_shoot:
		$ShotTimer.start()
		emit_signal("shoot")
		self.can_shoot = false
	

func _on_Area2D_area_entered(area):
	if area.is_in_group("enemy_bullets"):
		emit_signal("player_dead")



func _on_ShotTimer_timeout():
	self.can_shoot = true
