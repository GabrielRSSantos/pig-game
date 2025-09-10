class_name EnemyState extends State

const IDLE = "Idle"
const RUNNING = "Running"
const JUMPING = "Jump"
const FALLING = "Fall"
const WALKING = "Walking"
const HIT = "Hit"
const DEAD = "Dead"
const CHASING = "Chasing"

var enemy: Enemy

func _ready() -> void:
	await owner.ready
	enemy = owner as Enemy
	assert(enemy != null, "The enemyState state type must be used only in the enemy scene. It needs the owner to be a enemy node.")
