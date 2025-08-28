class_name Player extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -700.0
var gravity = 800

@onready var animation_player: AnimatedSprite2D = $AnimatedSprite2D
@onready var state: Label = $State
@onready var attack_area: Area2D = $AttackArea

func _process(delta: float) -> void:
	if animation_player.flip_h:
		attack_area.position.x = -55
		animation_player.position.x = -7
	else:
		attack_area.position.x = 0
		animation_player.position.x = 7

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		frameFreeze(0.05, 1)

func frameFreeze(timeScale, duration):
	Engine.time_scale = timeScale
	await get_tree().create_timer(0.2).timeout
	Engine.time_scale = 1.0
