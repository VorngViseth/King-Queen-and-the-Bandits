extends CharacterBody2D

const SPEED = 100.0
@onready var target = $"../guard"
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
#@onready var timer: Timer = $Timer

var attacking = false
var chasing = false

func _physics_process(delta: float) -> void:
	if attacking:
		_attacking()
	else:
		_chasing()
		
	move_and_slide()

#Chasing
func _chasing() -> void:
	if chasing and target:
		var direction = (target.position - position).normalized()
		
		velocity = direction * SPEED
		animated_sprite.play("walk")
				
		if direction.x > 0:
			animated_sprite.flip_h = false
		elif direction.x < 0:
			animated_sprite.flip_h = true
	else:
		velocity = Vector2.ZERO
		animated_sprite.play("idle")

#Detection zone 
func _on_detection_zone_body_entered(body: Node2D) -> void:
	if body.name == "guard":
		chasing = true

func _on_detection_zone_body_exited(body: Node2D) -> void:
	if body.name == "guard":
		chasing = false

#Attack Zone
func _on_attack_zone_body_entered(body: Node2D) -> void:
	if body.name == "guard":
		attacking = true
		#timer.start()

func _on_attack_zone_body_exited(body: Node2D) -> void:
	if body.name == "guard":
		attacking = false
		#timer.stop()

#Attacking
func _attacking() -> void:
	velocity = Vector2.ZERO
	animated_sprite.play("attack")
	return

#Dealing damage
func _on_attack_animation_finished() -> void:
	if target:
		target._takeDamage(10)
