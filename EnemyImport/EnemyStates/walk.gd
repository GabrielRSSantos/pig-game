extends EnemyState

@onready var nav := %NavigationAgent2D
@onready var ground_detect: RayCast2D = $"../../GroundDetect"
var initial_position

func enter(previous_state_path: String, data := {}) -> void:
	print("[Enter Enemy] Walk state")
	%AnimatedSprite2D.play("Walk")
	initial_position = enemy.position
	enemy.SPEED = 30

func physics_update(delta: float) -> void:
	enemy.move_and_slide()
	range_patrol(enemy.range_of_patrol)
	enemy.velocity.x = enemy.DIRECTION * enemy.SPEED
	
	if %WallDetector.is_colliding() or !ground_detect.is_colliding():
		%AnimatedSprite2D.flip_h = !%AnimatedSprite2D.flip_h
	
	if player_detection.is_colliding():
		enemy.player = player_detection.get_collider()
		enemy.is_chasing_state = true
		finished.emit("ChasingState")

func range_patrol(_range: int) -> void:
	if enemy.position.x > initial_position.x + _range:
		%AnimatedSprite2D.flip_h = true
	elif enemy.position.x < initial_position.x - _range:
		%AnimatedSprite2D.flip_h = false
	elif _range == 0:
		pass

func _on_back_normal_timeout() -> void:
	finished.emit("Idle")
