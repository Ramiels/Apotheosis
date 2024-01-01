-- default biome functions that get called if we can't find a a specific biome that works for us
-- The level of action ids that are spawned from the chests
CHEST_LEVEL = 3
dofile_once("data/scripts/director_helpers.lua")
dofile_once("data/scripts/biome_scripts.lua")

RegisterSpawnFunction( 0xff55AF8C, "spawn_skulls" )
RegisterSpawnFunction( 0xffffeedd, "init" )
RegisterSpawnFunction( 0xffbc32d0, "spawn_teleporter" )
RegisterSpawnFunction( 0xff15a43a, "spawn_potions" )
RegisterSpawnFunction( 0xff2531cf, "spawn_spells" )

--------------------------------------

g_items =
{
	total_prob = 0,
	{
		prob   		= 1,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/items/wand_level_03.xml"
	},
	{
		prob   		= 1,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/items/wand_unshuffle_02.xml"
	},
}

--------------------------------------

g_skulls =
{
	total_prob = 0,
	{
		prob   		= 6,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= ""
	},
	{
		prob   		= 1.5,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/physics_skull_01.xml"
	},
	{
		prob   		= 1.5,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/physics_skull_02.xml"
	},
	{
		prob   		= 1.5,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/physics_skull_03.xml"
	},
	{
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/physics_bone_01.xml"
	},
	{
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/physics_bone_02.xml"
	},
	{
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/physics_bone_03.xml"
	},
	{
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/physics_bone_04.xml"
	},
	{
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/physics_bone_05.xml"
	},
	{
		prob   		= 0.5,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/physics_bone_06.xml"
	},
}

g_stones =
{
	total_prob = 0,
	{
		prob   		= 2,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/stonepile.xml"
	},
	{
		prob   		= 1.5,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/physics_stone_01.xml"
	},
	{
		prob   		= 1.5,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/physics_stone_02.xml"
	},
	{
		prob   		= 1.5,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/physics_stone_03.xml"
	},
	{
		prob   		= 1.5,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= "data/entities/props/physics_stone_04.xml"
	},
	{
		prob   		= 4,
		min_count	= 1,
		max_count	= 1,    
		offset_y 	= 0,
		entity 	= ""
	},
}

g_lamp =
{
	total_prob = 0,
	{
		prob   		= 0.25,
		min_count	= 1,
		max_count	= 1,    
		entity 	= ""
	},
	{
		prob   		= 1.0,
		min_count	= 1,
		max_count	= 1,    
		entity 	= "data/entities/props/physics/temple_lantern.xml"
	},
}

--------------------------------------

function init(x, y, w, h)
	LoadPixelScene( "mods/apotheosis/files/biome_impl/upsidedown/spawnroom.png", "", x + 40, y, "", true )
end

function spawn_lamp(x, y)
	spawn(g_lamp,x,y,0,20)
end

function spawn_skulls(x, y)
	spawn(g_skulls,x,y,0,0)
end

function spawn_teleporter(x, y)
	EntityLoad("mods/apotheosis/files/entities/buildings/teleport_alchemy_secret_return.xml", x, y)
end

function spawn_potions(x, y)
	math.randomseed(x + y)
	local rng = math.random(1,100)
	if rng == 1 then
		EntityLoad( "mods/Apotheosis/files/entities/items/pickups/runestones/runestone_alchemy.xml", x, y )
	elseif rng == 2 then
		EntityLoad("mods/apotheosis/files/entities/items/pickups/potion_reinforced.xml", x , y )
	else
		EntityLoad("data/entities/items/pickup/potion.xml", x, y)
	end
end

function spawn_spells(x, y)
	CreateItemActionEntity( "APOTHEOSIS_MATERIAL_SLIME", x - 16, y )
	CreateItemActionEntity( "APOTHEOSIS_MATERIAL_ALCOHOL", x + 16, y )
	EntityLoad("mods/apotheosis/files/entities/items/books/book_omegadeath.xml", x + 150, y + 85) --Old Numbers: x32, y8
end

function spawn_shopitem( x, y ) end
function spawn_small_enemies(x, y) end
function spawn_big_enemies(x, y) end
function spawn_unique_enemy(x, y) end
function spawn_props(x, y) end
function load_pixel_scene( x, y ) end
function load_pixel_scene2( x, y ) end
function spawn_items(x, y) end