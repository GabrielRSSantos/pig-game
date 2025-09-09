class_name EnemyState extends State

const IDLE = "Idle"
const WALK = "Walk"
const JUMP = "Jump"
const FALL = "Fall"

@onready var player_detection = %PlayerDetector as RayCast2D

var enemy: Enemy

func _ready() -> void:
	await owner.ready
	enemy = owner as Enemy
	assert(enemy != null, "The EnemyState state type must be used only in the enemy scene. It needs the owner to be a Enemy node.")
