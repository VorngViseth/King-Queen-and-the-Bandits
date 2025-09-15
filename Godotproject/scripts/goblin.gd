extends CharacterBody2D

const SPEED = 100.0
@onready var target = $"../guard"
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var attacking = false
var chasing = false

func _physics_process(delta: float) -> void:
	if attacking:
		velocity = Vector2.ZERO
		move_and_slide()
		return
	
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
		
	move_and_slide()

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
		velocity = Vector2.ZERO
		animated_sprite.play("attack")

func _on_attack_zone_body_exited(body: Node2D) -> void:
	if body.name == "guard":
		attacking = false
