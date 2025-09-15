extends CharacterBody2D

const SPEED = 50.0
@onready var target = $"../guard"
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if target:
		var direction = (target.position - position).normalized()
		velocity = direction * SPEED
		
		animated_sprite.play("walk")
		
		if direction.x > 0:
			animated_sprite.flip_h = false
		elif direction.x < 0:
			animated_sprite.flip_h = true
	
		
		move_and_slide()
