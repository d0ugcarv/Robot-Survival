extends Node2D

@onready var player: Player = $".."
@onready var energy_bullet_attack: Node2D = $EnergyBulletAttack
@onready var orbiting_star_attack: Node2D = $OrbitingStarAttack

func _ready() -> void:
	UpgradeDb.ability_upgrade.connect(ability_upgrades)
	
	UpgradeDb.collected_upgrades.append("energy_bullet1")
	ability_upgrades("energy_bullet1")

func ability_upgrades(upgrade) -> void:
	match upgrade:
		"red_gem":
			player.update_health(20)
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
		"orbiting_star1":
			orbiting_star_attack.level = 1.0
			orbiting_star_attack.amount = 1.0
		"orbiting_star2":
			orbiting_star_attack.level = 2.0
			orbiting_star_attack.amount = 1.0
		"orbiting_star3":
			orbiting_star_attack.level = 3.0
			orbiting_star_attack.amount = 2.0
