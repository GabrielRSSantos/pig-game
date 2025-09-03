class_name Player extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -300.0
var gravity = 800

@onready var animation_player: AnimatedSprite2D = $AnimatedSprite2D
@onready var state: Label = $State
@onready var attack_area: Area2D = $AttackArea
@onready var collision_attack: CollisionShape2D = $AttackArea/CollisionShape2D

var respawn_player : Vector2 = Vector2(80, 250)

#Player Attack
enum ATTACK {UP, DOWN}
var actual_attack = ATTACK.UP

#Player's Coins
var coins := 0
var show_label_is_playing := false
@onready var coins_count: Label = $UI/PlayerUI/CoinBar/Coins/Label

#Player's Life
var max_health := 3
var health := 3
@onready var life_bar: TextureRect = $UI/PlayerUI/LifeBar
@onready var hearts_grid: HBoxContainer = $UI/PlayerUI/Hearts
@onready var preload_heart = preload("res://Scenes/hearts.tscn")

func _ready() -> void:
	spawn_hearts(max_health)

func _process(delta: float) -> void:
	if animation_player.flip_h:
		attack_area.position.x = -55
		animation_player.position.x = -7
	else:
		attack_area.position.x = 0
		animation_player.position.x = 7

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		frameFreeze(0.2, 0.1)
	if body.is_in_group("Box"):
		frameFreeze(0.2, 0.1)
	pass

func frameFreeze(timeScale, duration):
	Engine.time_scale = timeScale
	await get_tree().create_timer(duration, true, false, true).timeout
	Engine.time_scale = 1.0

func spawn_hearts(hearts) -> void:
	for h in hearts:
		var new_heart = preload_heart.instantiate()
		hearts_grid.add_child(new_heart)

func add_hearth(hearts) -> void:
	max_health += hearts
	health = max_health
	spawn_hearts(hearts)
	heal(1)

func update_coin(coin) -> void:
	coins += coin
	coins_count.text = str(coins)
	$UI/PlayerUI/CoinBar/Coins/CoinLabelTimer.start()
	if !show_label_is_playing:
		show_label_is_playing = true
		$CoinLabel.play("coin_label_in")

func _on_coin_label_timer_timeout() -> void:
	$CoinLabel.play("coin_label_out")
	show_label_is_playing = false

func take_hit(hit) -> void:
	health -= hit
	for i in hearts_grid.get_children():
		if i.get_index() < health:
			i.texture = load("res://Resources/hearts.tres")
		else:
			i.texture = load("res://Assets/Sprites/12-Live and Coins/GreyHeart.png")

func heal(amount: int) -> void:
	health += amount
	var max_hearts = hearts_grid.get_child_count()
	if health > max_hearts:
		health = max_hearts

	for i in hearts_grid.get_children():
		if i.get_index() < health:
			i.texture = load("res://Resources/hearts.tres")
		else:
			i.texture = load("res://Assets/Sprites/12-Live and Coins/GreyHeart.png")

func _on_player_hurt_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		take_hit(1)
		$StateMachine._transition_to_next_state("Hit", {"enemy_direction" : body.position})
		if health == 0:
			$StateMachine._transition_to_next_state("Dead")
