extends Area2D

@export var max_travel_length: int = 10000
@export var travel_speed: int = 1000
@export var normal_damage: int = 10
@export var critical_damage: int = 50
@export var critical_rate: float = 0.2

var travel_direction: Vector2 = Vector2.UP
var travel_length: int = 0


func _physics_process(delta):
	
	travel_length += travel_speed * delta * 10
	position += travel_direction * travel_speed * delta
	
	if travel_length > max_travel_length:
		queue_free()


func _on_body_entered(body):
	
	if body is CharacterBody2D or body is StaticBody2D:
		var damage = normal_damage
		
		if randf() < critical_rate:
			damage = critical_damage
			print("Crit on: ", body)
		
		body.hp -= damage
	
		queue_free()
