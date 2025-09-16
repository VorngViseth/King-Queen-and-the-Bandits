extends CharacterBody2D

const SPEED = 150.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var basicAttack = false

func _physics_process(delta: float) -> void:
	# Get input direction (-1 for left, 1 for right, 0 for none)
	var direction_x := Input.get_axis("move_left", "move_right")
	var direction_y := Input.get_axis("move_forward", "move_backward")
	var direction := Vector2(direction_x, direction_y).normalized()
	
	var basicAttackInput = Input.is_action_just_pressed("basicAttack")
	
	if  basicAttackInput and not basicAttack:
		basicAttack = true
		animated_sprite.play("basicAttack")
		velocity = Vector2.ZERO
		
	if not basicAttack:
		if direction != Vector2.ZERO:
			velocity = direction * SPEED
			animated_sprite.play("walk")
		
			if direction.x < 0:
				animated_sprite.flip_h = true
			elif direction.x > 0:
				animated_sprite.flip_h = false
				
		else:
			velocity = Vector2.ZERO
			animated_sprite.play("idle")
			
	move_and_slide()
	
#Attaking
func _on_attack_animation_finished() -> void:
		basicAttack = false
