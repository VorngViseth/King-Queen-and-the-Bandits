extends CharacterBody2D

const SPEED = 50.0
@onready var target = $"../guard"
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

func _ready():
	if target:
		nav_agent.target_position = target.position

func _physics_process(delta: float) -> void:
	if target:
		# Update target position every frame
		nav_agent.target_position = target.position

		# Get next position along the path
		var next_point = nav_agent.get_next_path_position()

		if next_point != Vector2.ZERO:
			var direction = (next_point - position).normalized()
			velocity = direction * SPEED
			move_and_slide()
