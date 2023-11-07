extends CharacterBody2D

@export var movement_speed: int = 150
@export var target: Node2D

@export var hp: int = 20

func _physics_process(delta):
	
	if hp <= 0:
		queue_free()
	
	var target_position = (target.position - position).normalized()
	
	velocity = Vector2(target_position * movement_speed)
	
	look_at(target.position)
	
	move_and_slide()
