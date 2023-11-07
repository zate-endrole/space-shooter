extends Node2D

var spawner_in_cooldown: int = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not spawner_in_cooldown:
		var objects: Array = [
			preload("res://scenes/objects/spikes.tscn"),
			preload("res://scenes/objects/stone_line.tscn"),
			preload("res://scenes/objects/ventilation_hole.tscn")
		]
		
		print("a")
		
		var object: Node2D = objects[randi() % objects.size()].instantiate()
		object.position = $"../Player".position + Vector2(800, 0).rotated(randf_range(0, 2*PI))
		object.scale = $"../Player".scale * (randi() % 5)
		object.rotation_degrees = randi() % 180
		$"../ObjectsGroup".add_child(object)
		$SpawnerTimer.start()
		spawner_in_cooldown = true


func _on_spawner_timer_timeout():
		spawner_in_cooldown = false
