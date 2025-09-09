class_name Enemy
extends CharacterBody2D

@export var range_of_patrol: int
@export var atk := 10
@export var def := 10
@export var spd := 10
@export var life := 100

@export var GRAVITY = 1400.0
@export var SPEED = 10.0
@export var jump_impulse := 200.0
@export var moving: bool
@export var is_chasing_state: bool = false
@export var change_drop_equip := 0
@export var drop_items: Array[Resource] = []
enum SIDE {RIGHT, LEFT}
@export var side: SIDE

@onready var damage_number: Marker2D = $DamageNumber

var DIRECTION = 1
var player: Player


func _ready() -> void:
	%AnimatedSprite2D.flip_h = false if side == SIDE.RIGHT else true

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += GRAVITY * delta
	change_direction()
	move_and_slide()

func dead() -> void:
	self.queue_free()

func change_direction() -> void:
	if %AnimatedSprite2D.flip_h:
		DIRECTION = -1
		%PlayerDetector.scale.x = -1
		%WallDetector.scale.x = -1
		$GroundDetect.position.x = -8
		$HitBox.position.x = -24
	else:
		DIRECTION = 1
		%PlayerDetector.scale.x = 1
		%WallDetector.scale.x = 1
		$GroundDetect.position.x = 8
		$HitBox.position.x = 16

func _on_hit_box_area_entered(area: Area2D) -> void:
	var player = area.get_parent()
	var damage = player.damage() - def
