extends CharacterBody2D

const SPEED = 100.0
@onready var target = $"../guard"
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var attacking = false

func _physics_process(delta: float) -> void:
	if attacking:
		velocity = Vector2.ZERO
		move_and_slide()
		return
	
	if target:
		var direction = (target.position - position).normalized()
		velocity = direction * SPEED
		
		animated_sprite.play("walk")
		
		if direction.x > 0:
			animated_sprite.flip_h = false
		elif direction.x < 0:
			animated_sprite.flip_h = true
	
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "guard":
		attacking = true
		velocity = Vector2.ZERO
		animated_sprite.play("attack")


func _on_area_2d_body_exited(body: Node2D) -> void:
		if body.name == "guard":
			attacking = false
