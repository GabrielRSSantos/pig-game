extends EnemyState

@onready var nav: NavigationAgent2D = %NavigationAgent2D
@onready var ground_detect: RayCast2D = $"../../GroundDetect"
@onready var area_to_hit: Area2D = $"../../AreaToHit"

var play_time := true
var body_player

func enter(previous_state_path: String, data := {}) -> void:
	print("[Enter Enemy] Chasing state")
	if body_player != null:
		finished.emit("Attack")
	play_time = true
	enemy.velocity = Vector2.ZERO

func physics_update(delta: float) -> void:
	enemy.move_and_slide()
	enemy.change_direction()
	enemy.velocity.x = enemy.DIRECTION * enemy.SPEED
	
	if enemy.player != null:
		nav.target_position = enemy.player.position
		var dir = -enemy.player.to_local(nav.get_next_path_position()).normalized().x
		%AnimatedSprite2D.flip_h = false if dir > 0 else true
	
	if !ground_detect.is_colliding():
		enemy.SPEED = 0
		%AnimatedSprite2D.play("Idle")
		if !%PlayerDetector.is_colliding() and play_time:
			play_time = false
			enemy.is_chasing_state = false
			$BackNormal.one_shot = true
			$BackNormal.start()
	elif ground_detect.is_colliding():
		%AnimatedSprite2D.play("Walk")
		enemy.SPEED = 30

	if %WallDetector.is_colliding():
		enemy.velocity.x = enemy.DIRECTION * enemy.SPEED
		enemy.velocity.y = -enemy.jump_impulse
		
	if !%PlayerDetector.is_colliding():
		$StopChase.start(5)

func _on_back_normal_timeout() -> void:
	finished.emit(WALK)

func _on_area_to_hit_body_entered(body: Node2D) -> void:
	if body is Player:
		body_player = body
		finished.emit("Attack")

func _on_area_to_hit_body_exited(body: Node2D) -> void:
	if body is Player:
		body_player = null

func _on_stop_chase_timeout() -> void:
	finished.emit(WALK)
	
