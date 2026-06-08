extends EnemyState

var direction := -1
var distance := 0
var distance_x := 0

func enter(previous_state_path: String, data := {}) -> void:
	enemy.state_label.text = "Patrol"
	print("Patrol")
	enemy.enemy_sprite.play("Run")
	distance = enemy.position.x + enemy.distance_to_patrol
	distance_x = enemy.position.x - enemy.distance_to_patrol

func physics_update(_delta: float) -> void:
	if enemy.position.x >= distance:
		printerr("MUDAR DIRECAO PARA ESQUERDA")
		direction = -1
	if enemy.position.x <= distance_x:
		printerr("MUDAR DIRECAO PARA DIREITA")
		direction = 1
	enemy.velocity.x = direction * 100


func _on_enemy_sight_body_entered(body: Node2D) -> void:
	enemy.player = body
	enemy.state_machine._transition_to_next_state("Chasing")
