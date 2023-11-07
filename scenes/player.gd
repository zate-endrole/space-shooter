extends CharacterBody2D

signal shoot(projectiles_object)
signal player_die

@export var movement_speed: int = 250
@export var hp: int = 100

var can_laser: bool = true
var projectile_type: PackedScene
var player_direction: Vector2

func _ready():
	projectile_type = load("res://scenes/laser.tscn")

func _physics_process(delta):
	
	if hp <= 0:
		player_die.emit()
	
	var movement_direction = Input.get_vector("move_left", "move_right", "move_front", "move_back")
	velocity = movement_direction * movement_speed
	
	move_and_slide()

	look_at(get_global_mouse_position())
	player_direction = (get_global_mouse_position() - position).normalized()
	
	if Input.is_action_pressed("shoot") and can_laser:
		can_laser = false
		$ShootingTimer.start()
		shoot.emit(create_projectile())


func create_projectile() -> Area2D:
	var projectile = projectile_type.instantiate() as Area2D
	
	var projectile_spawn_points = $BulletMarkers.get_children()
	var selected_spawn_point = projectile_spawn_points[randi() % projectile_spawn_points.size()].global_position
	
	projectile.position = selected_spawn_point
	projectile.travel_direction = player_direction
	projectile.rotation_degrees = rad_to_deg(player_direction.angle()) + 90
	return projectile
	


func _on_shooting_timer_timeout():
	can_laser = true
