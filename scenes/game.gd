extends Node2D

func _on_player_shoot(projectiles_object):	
	$BulletsGroup.add_child(projectiles_object)
