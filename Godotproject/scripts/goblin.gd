extends CharacterBody2D

const SPEED = 50.0
@onready var target = $"../guard"  # make sure path is correct

func _physics_process(delta: float) -> void:
	if target:
		var direction = (target.position - position).normalized()
		velocity = direction * SPEED
		move_and_slide()
