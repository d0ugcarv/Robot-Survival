extends Node2D

@onready var player: Player = $".."
@onready var energy_bullet_attack: Node2D = $EnergyBulletAttack
@onready var orbiting_star_attack: Node2D = $OrbitingStarAttack
@onready var empty_gem_effect: Area2D = $Empty_gem_effect


func _ready() -> void:
	UpgradeDb.ability_upgrade.connect(ability_upgrades)
	
	UpgradeDb.update_collected_upgrades("energy_bullet1")
	
	UpgradeDb.update_collected_upgrades("empty_gem1")


func ability_upgrades(upgrade) -> void:
	match upgrade:
		#Red Gem
		"red_gem":
			player.update_health(20)
			
		# Energy Bullet
		"energy_bullet1":
			energy_bullet_attack.level = 1.0
			energy_bullet_attack.baseamno = 1.0
			energy_bullet_attack.attack_speed = 0.8
		"energy_bullet2":
			energy_bullet_attack.level = 2.0
			energy_bullet_attack.baseamno = 2.0
			energy_bullet_attack.attack_speed = 0.8
		"energy_bullet3":
			energy_bullet_attack.level = 3.0
			energy_bullet_attack.baseamno = 2.0
			energy_bullet_attack.attack_speed = 0.8
		
		# Orbiting Star
		"orbiting_star1":
			orbiting_star_attack.level = 1.0
			orbiting_star_attack.amount = 1.0
		"orbiting_star2":
			orbiting_star_attack.level = 2.0
			orbiting_star_attack.amount = 1.0
		"orbiting_star3":
			orbiting_star_attack.level = 3.0
			orbiting_star_attack.amount = 2.0
		
		 # Empty Gem
		"empty_gem1":
			empty_gem_effect.upgrade(1.0)
		"empty_gem2":
			empty_gem_effect.upgrade(2.0)
		"empty_gem3":
			empty_gem_effect.upgrade(3.0)
		"empty_gem4":
			empty_gem_effect.upgrade(4.0)
		"empty_gem5":
			empty_gem_effect.upgrade(5.0)
			
