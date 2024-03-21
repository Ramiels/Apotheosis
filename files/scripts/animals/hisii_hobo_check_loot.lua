PrizeSpells = {
	"ROCKET_TIER_2",
	"GRENADE_TIER_2",
	"SPITTER_TIER_2",
	"SPITTER_TIER_3",
	"LIGHT_BULLET_TRIGGER",
	"LIGHT_BULLET_TRIGGER_2",
	"DISC_BULLET",
	"ROCKET",
	"GRENADE",
	"SWAPPER_PROJECTILE",
	"LIGHT",
	"BUCKSHOT",
	"SHIELD_FIELD",
	"SEA_LAVA",
	"FREEZE",
	"BALL_LIGHTNING",
	"AIR_BULLET",
	"CHAOS_POLYMORPH_FIELD",
	"LIFETIME",
	"LIFETIME_DOWN",
	"HEAVY_SPREAD",
	"TINY_GHOST",
	"DYNAMITE",
	"BLOOD_MAGIC",
	"MANA_REDUCE",
	"CHAINSAW",
	"RECHARGE",
	"HOMING_SHOOTER",
	"BLOODLUST",
	"DELAYED_SPELL",
	"apotheosis_BOMB_GIGA",
	"APOTHEOSIS_POTION_TO_SEA",
	"apotheosis_AQUA_MINE",
	"apotheosis_ALT_FIRE_TELEPORT_SHORT",
	"BURST_8"
}

if HasFlagPersistent( "apotheosis_card_unlocked_fire_lukki_spell" ) then
	PrizeSpells[#PrizeSpells+1] = "apotheosis_FIRE_CHARGE"
end

if ModIsEnabled("copis_things") then
	local copith_spells = {
		"COPITH_SUMMON_HAMIS",
		--[["COPITH_UPGRADE_MANA_CHARGE_SPEED", 
		"COPITH_UPGRADE_MANA_MAX", 
		"COPITH_UPGRADE_FIRE_RATE_WAIT", 
		"COPITH_UPGRADE_RELOAD_TIME",]]
		"COPITH_ARCANE_TURRET",
		"COPITH_ANCHORED_SHOT",
		"COPITH_LUNGE",
		"COPITH_SLOW",
		"COPITH_CONCRETEBALL",
		"COPITH_SLOW_BULLET_TIMER_N",
		"COPITH_AUTO_FRAME",
		"COPITH_ZAP",
		"COPITH_SCATTER_6",
		"COPITH_CAUSTIC_CLAW",
		"COPITH_LUMINOUS_BLADE",
		"COPITH_ASTRAL_VORTEX",
		"COPITH_LARPA_FORWARDS",
	}
	local prize_ln = #PrizeSpells
	for i=1, #copith_spells do
		PrizeSpells[prize_ln+i] = copith_spells[i]
	end
end

if ModIsEnabled("variaAddons") then
	local varia_spells = {
		"VARIA_SLASH",
		"VARIA_BULLET",
		"VARIA_BULLET_TRIGGER",
		"VARIA_SHOTGUN_SHELL",
		"VARIA_CRIT_ON_CHARM",
		"VARIA_GATLING_RAY_ENEMY",
		"VARIA_RE_ADDED_CHARM_FIELD",
		"VARIA_JUMPER_BLAST",
		"VARIA_LUKKI_BOMB",
		"VARIA_CRESCENT_WAVE_POISON",
		"VARIA_BLINK",
		"VARIA_BEES",
	}
	local prize_ln = #PrizeSpells
	for i=1, #varia_spells do
		PrizeSpells[prize_ln+i] = varia_spells[i]
	end
end

-- Append to this file to add spawns