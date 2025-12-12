extends Node2D


#Upgrades
var collected_upgrades: Array[String] = []

var upgrades_options: Array[String] = []
var random_upgrade: String

signal ability_upgrade(upgrade: float)


const ITENS_PATH  = "res://assets/sprites/itens/"
const ABILITIES_PATH = "res://assets/sprites/abilities/"

const UPGRADES = {
	# Red Gem
	"red_gem" : {
		"icon" : ITENS_PATH + "spr_coin_roj_icon.png",
		"display_name" : "Red Gem",
		"description" : "Gem with dense concentration of energy, helps in the repair process.",
		"level" : "",
		"prerequisite" : [],
		"type" : "item",
	},
	
	# Energy Bullet
	"energy_bullet1" : {
		"icon" : ABILITIES_PATH + "01.png",
		"display_name" : "Energy Bullet",
		"description" : "Fast energy bullet.",
		"level" : "Level 1",
		"prerequisite" : [],
		"type" : "attack",
	},
	"energy_bullet2" : {
		"icon" : ABILITIES_PATH + "01.png",
		"display_name" : "Energy Bullet",
		"description" : "Add an adicional especial energy bullet.",
		"level" : "Level 2",
		"prerequisite" : ["energy_bullet1"],
		"type" : "attack",
	},
	"energy_bullet3" : {
		"icon" : ABILITIES_PATH + "01.png",
		"display_name" : "Energy Bullet",
		"description" : "Add more piercing power to the blue energy bullet.",
		"level" : "Level 3",
		"prerequisite" : ["energy_bullet2"],
		"type" : "attack",
	},
	
	# Orbiting Star
	"orbiting_star1" : {
		"icon" : ABILITIES_PATH + "197_star_icon.png",
		"display_name" : "Orbiting Star",
		"description" : "Add an orbiting energy star to your gravity center.",
		"level" : "Level 1",
		"prerequisite" : [],
		"type" : "attack",
	},
	"orbiting_star2" : {
		"icon" : ABILITIES_PATH + "197_star_icon.png",
		"display_name" : "Orbiting Star",
		"description" : "Focus energy to your blue energy star.",
		"level" : "Level 2",
		"prerequisite" : ["orbiting_star1"],
		"type" : "attack",
	},
	"orbiting_star3" : {
		"icon" : ABILITIES_PATH + "197_star_icon.png",
		"display_name" : "Orbiting Star",
		"description" : "Add an adcional soul energy star to your orbity.",
		"level" : "Level 3",
		"prerequisite" : ["orbiting_star2"],
		"type" : "attack",
	},
	
	# Empty Gem
	"empty_gem1" : {
		"icon" : ABILITIES_PATH + "spr_coin_gri_icon.png",
		"display_name" : "Empty Gem",
		"description" : "An empty gem that pulls energy towards itself.",
		"level" : "Level 1",
		"prerequisite" : [],
		"type" : "item",
	},
	"empty_gem2" : {
		"icon" : ABILITIES_PATH + "spr_coin_gri_icon.png",
		"display_name" : "Empty Gem",
		"description" : "An empty gem that pulls energy towards itself with more streng.",
		"level" : "Level 2",
		"prerequisite" : ["empty_gem1"],
		"type" : "item",
	},
	"empty_gem3" : {
		"icon" : ABILITIES_PATH + "spr_coin_gri_icon.png",
		"display_name" : "Empty Gem",
		"description" : "An empty gem that pulls energy towards itself over a larger area.",
		"level" : "Level 3",
		"prerequisite" : ["empty_gem2"],
		"type" : "item",
	},
	"empty_gem4" : {
		"icon" : ABILITIES_PATH + "spr_coin_gri_icon.png",
		"display_name" : "Empty Gem",
		"description" : "An empty gem that pulls energy towards itself with more force.",
		"level" : "Level 4",
		"prerequisite" : ["empty_gem3"],
		"type" : "item",
	},
	"empty_gem5" : {
		"icon" : ABILITIES_PATH + "spr_coin_gri_icon.png",
		"display_name" : "Empty Gem",
		"description" : "An empty gem that pulls all energy towards.",
		"level" : "Level 5",
		"prerequisite" : ["empty_gem4"],
		"type" : "item",
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
	if UPGRADES[upgrade]["display_name"] != "Red Gem":
		collected_upgrades.append(upgrade)

		ability_upgrade.emit(upgrade)
