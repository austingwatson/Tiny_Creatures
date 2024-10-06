class_name Juice
extends Resource

enum Creature {
	SLUG,
	SLIME,
	AMOEBA,
}

var slug = 0
var slug_max = 0
var slime = 0
var slime_max = 0
var amoeba = 0
var amoeba_max = 0


func init_juice(slug: int, slime: int, ameomba: int):
	self.slug = slug
	self.slug_max = slug
	self.slime = slime
	self.slime_max = slime
	self.amoeba = ameomba
	self.amoeba_max = ameomba
	

func use_juice(creature):
	match creature:
		Creature.SLUG:
			slug -= 1
		Creature.SLIME:
			slime -= 1
		Creature.AMOEBA:
			amoeba -= 1
			

func has_juice(creature):
	match creature:
		Creature.SLUG:
			return slug > 0
		Creature.SLIME:
			return slime > 0
		Creature.AMOEBA:
			return amoeba > 0


func print_juice():
	print("slug: " + str(slug) + "/" + str(slug_max))
	print("slime: " + str(slime) + "/" + str(slime_max))
	print("amoeba: " + str(amoeba) + "/" + str(amoeba_max))
	print()
