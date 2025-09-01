extends RigidBody2D

@onready var box_sprite: AnimatedSprite2D = $BoxSprite

const BOX_PIECES_1 = preload("res://Assets/Sprites/08-Box/Box Pieces 1.png")
const BOX_PIECES_2 = preload("res://Assets/Sprites/08-Box/Box Pieces 2.png")
const BOX_PIECES_3 = preload("res://Assets/Sprites/08-Box/Box Pieces 3.png")
const BOX_PIECES_4 = preload("res://Assets/Sprites/08-Box/Box Pieces 4.png")
var box_piece = preload("res://Scenes/box_piece.tscn")

var coin = preload("res://Scenes/Coin.tscn")

var health := 12

func _process(delta: float) -> void:
	if health == 0:
		drop_coin()
		drop_box_pieces()
		queue_free()

func _on_box_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Attack"):
		$HitEffect.play("Hit")
		box_sprite.play("Hit")

func _on_box_sprite_animation_finished() -> void:
	if box_sprite.animation == "Hit":
		health -= 1
		box_sprite.play("Default")

func drop_coin() -> void:
	var coin = coin.instantiate()
	coin.position = position
	get_parent().add_child(coin)

func drop_box_pieces() -> void:
	for box in [BOX_PIECES_1, BOX_PIECES_2, BOX_PIECES_3, BOX_PIECES_4]:
		var new_piece = box_piece.instantiate()
		new_piece.get_child(0).texture = box
		new_piece.position = position 
		get_parent().add_child(new_piece)
