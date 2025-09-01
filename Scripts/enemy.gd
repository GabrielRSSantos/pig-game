extends CharacterBody2D

var coin = preload("res://Scenes/Coin.tscn")

@onready var enemy_area: Area2D = $EnemyArea
@onready var enemy_sprite: AnimatedSprite2D = $EnemySprite

var health := 12

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if health == 0:
		drop_coin()
		queue_free()
	
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
