extends Node
' These are global gameplay variables that can be altered for playtesting'

# PLAYER
var SHIP_SPEED = 300
var DEFAULT_LIVES = 3
var SHIP_SHOT_COOLDOWN = 0.1
var SHIP_SHOT_SPEED = 2000
var SHIP_SHOT_TIMER = 0.1

# BASIC ENEMY
var ENEMY_SHOT_COOLDOWN = 1

# ENEMY PROJECTILE
var ENEMY_SHOT_SPEED = 1000

# MANTIS ENEMY
var MANTIS_SHOT_COOLDOWN = 2
var MANTIS_X_SKEW = [-400, -200, -100, 0, 100, 200, 400]
var MANTIS_HP = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
