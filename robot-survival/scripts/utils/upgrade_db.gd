extends Node2D


#Upgrades
var collected_upgrades: Array[String] = []

var upgrades_options: Array[String] = []
var random_upgrade: String

signal ability_upgrade(upgrade: float)


const ICON_PATH  = "res://assets/sprites/itens/"
const WEAPON_PATH = "res://assets/sprites/attacks/"

const UPGRADES = {
	"red_gem" : {
		"icon" : ICON_PATH + "spr_coin_roj_icon.png",
		"display_name" : "Red Gem",
		"description" : "Gem with dense concentration of energy, helps in the repair process.",
		"level" : "",
		"prerequisite" : [],
		"type" : "item",
	},
	"energy_bullet1" : {
		"icon" : WEAPON_PATH + "01.png",
		"display_name" : "Energy Bullet",
		"description" : "Fast energy bullet.",
		"level" : "Level 1",
		"prerequisite" : [],
		"type" : "attack",
	},
	"energy_bullet2" : {
		"icon" : WEAPON_PATH + "01.png",
		"display_name" : "Energy Bullet",
		"description" : "Add an adicional especial energy bullet.",
		"level" : "Level 2",
		"prerequisite" : ["energy_bullet1"],
		"type" : "attack",
	},
	"energy_bullet3" : {
		"icon" : WEAPON_PATH + "01.png",
		"display_name" : "Energy Bullet",
		"description" : "Add more piercing power to the blue energy bullet.",
		"level" : "Level 3",
		"prerequisite" : ["energy_bullet2"],
		"type" : "attack",
	},
	"orbiting_star1" : {
		"icon" : WEAPON_PATH + "197_star_icon.png",
		"display_name" : "Orbiting Star",
		"description" : "Add an orbiting energy star to your gravity center.",
		"level" : "Level 1",
		"prerequisite" : [],
		"type" : "attack",
	},
	"orbiting_star2" : {
		"icon" : WEAPON_PATH + "197_star_icon.png",
		"display_name" : "Orbiting Star",
		"description" : "Focus energy to your blue energy star.",
		"level" : "Level 2",
		"prerequisite" : ["orbiting_star1"],
		"type" : "attack",
	},
	"orbiting_star3" : {
		"icon" : WEAPON_PATH + "197_star_icon.png",
		"display_name" : "Orbiting Star",
		"description" : "Add an adcional soul energy star to your orbity.",
		"level" : "Level 3",
		"prerequisite" : ["orbiting_star2"],
		"type" : "attack",
	},
}


func get_random_upgrade() -> String:
	#Create options list
	for i in UPGRADES:
		if i in collected_upgrades: #Already have upgrade
			pass
		elif i in upgrades_options: #Already chosen upgrade as option
			pass
		elif UPGRADES[i]["prerequisite"].size() > 0: #Check for PreRequisites
			for j in UPGRADES[i]["prerequisite"]:
				if not j in collected_upgrades:
					pass
				else:
					upgrades_options.append(i)
		else:
			upgrades_options.append(i)
		
	if upgrades_options.size() > 0:
		random_upgrade = upgrades_options.pick_random()
		
		upgrades_options.append(random_upgrade)
		
		return random_upgrade
	else:
		return ""
		

func update_collected_upgrades(upgrade) -> void:
	if UPGRADES[upgrade]["type"] != "item":
		collected_upgrades.append(upgrade)

		ability_upgrade.emit(upgrade)
