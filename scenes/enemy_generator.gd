extends Node2D

@export var max_enemy_number: int = 15

var spawner_in_cooldown: int = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $"../EnemiesGroup".get_child_count() <= max_enemy_number and not spawner_in_cooldown:	
		var enemies: Array = [
			preload("res://scenes/enemies/drones.tscn")
		]
		
		var enemy: CharacterBody2D = enemies[randi() % enemies.size()].instantiate()
		enemy.position = $"../Player".position + Vector2(500, 0).rotated(randf_range(0, 2*PI))
		enemy.scale = $"../Player".scale
		enemy.target = $"../Player"
		$"../EnemiesGroup".add_child(enemy)
		$SpawnerTimer.start()
		spawner_in_cooldown = true

func _on_spawner_timer_timeout():
	spawner_in_cooldown = false
