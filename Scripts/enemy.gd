class_name Enemy extends CharacterBody2D

var coin = preload("res://Scenes/Coin.tscn")

@onready var enemy_area: Area2D = $EnemyArea
@onready var enemy_sprite: AnimatedSprite2D = $EnemySprite
@onready var collision_enemy_sight: CollisionShape2D = $EnemySight/CollisionEnemySight
@onready var state_label: Label = $StateLabel
@onready var state_machine: StateMachine = $StateMachine

@export var distance_to_patrol : int = 0

var player : Player

var health := 2

func _physics_process(delta: float) -> void:
	if health == 0:
		drop_coin()
		queue_free()
	
	velocity += get_gravity() * delta
	direction()
	move_and_slide()

func _on_enemy_sprite_animation_finished() -> void:
	if enemy_sprite.animation == "Hurt":
		enemy_sprite.play("Idle")

func _on_enemy_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Attack"):
		health -= 1
		$HitEffect.play("Hit")
		enemy_sprite.play("Hurt")

func drop_coin() -> void:
	var coin = coin.instantiate()
	coin.position = position
	get_parent().add_child(coin)

func direction() -> void:
	if velocity.x != 0:
		if velocity.x <= 0:
			enemy_sprite.flip_h = false
			collision_enemy_sight.position.x = -50
		else:
			enemy_sprite.flip_h = true
			collision_enemy_sight.position.x = 50

func _on_enemy_sight_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		state_machine._transition_to_next_state("Chasing")
		player = body
		$EnemySight/EnemySightTimer.stop()
	if body.is_in_group("Bomb"):
		state_machine._transition_to_next_state("TakeBomb", {"bomb" : body})
	if body.is_in_group("Cannon"):
		pass

func _on_enemy_sight_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$EnemySight/EnemySightTimer.start()

func _on_enemy_sight_timer_timeout() -> void:
		player = null
		velocity.x = 0
