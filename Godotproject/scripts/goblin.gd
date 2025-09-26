extends CharacterBody2D

@onready var target = $"../guard"
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
const SPEED = 100.0
var hp = 100
var attacking = false
var chasing = false
var dead = false
var temp = false

func _physics_process(delta: float) -> void:
	if dead:
		if  not temp:
			animated_sprite.play("die")
			temp = true
	elif attacking and not target.dead:
		_attacking()
	elif not attacking:
		_chasing()
	else:
		animated_sprite.play("idle")
		
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

func _on_attack_zone_body_exited(body: Node2D) -> void:
	if body.name == "guard":
		attacking = false

#Attacking
func _attacking() -> void:
	velocity = Vector2.ZERO
	animated_sprite.play("attack")
	return

#Dealing damage
func _on_attack_animation_finished() -> void:
	if target:
		target._takeDamage(10)

#Taking damage
func _takeDamage(amount: int) -> void:
	if dead:
		return

	hp -= amount
	
	if hp <= 0:
		dead = true
		
	print(hp)
