
do
	local EZWand = dofile_once("mods/Apotheosis/lib/EZWand/EZWand.lua")
	local entity_id = GetUpdatedEntityID()
	local root = EntityGetRootEntity(entity_id)
	local wand = EZWand(EntityGetParent(entity_id))
	local x, y = EntityGetTransform(entity_id)
	local controlscomp = EntityGetFirstComponent(root, "ControlsComponent")
	local itemcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"ItemComponent")
	local alwayscast = ComponentGetValue2(itemcomp,"permanently_attached")
	local cooldown_frames = 45
	--I didn't like the inconsistency felt when cooldown scaled off of the wand recharge speed. I prefer the feeling of a consistent right click to teleport every 0.75 seconds
	--local cooldown_frames = wand.rechargeTime
	--if cooldown_frames <= 20 then cooldown_frames = 20 end
	--if cooldown_frames >= 45 then cooldown_frames = 45 end
	local cooldown_frame
	local variablecomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
	cooldown_frame = ComponentGetValue2( variablecomp, "value_int" )
	local aim_x, aim_y = ComponentGetValue2(controlscomp, "mAimingVectorNormalized")
	local manacost = 80

	if GameGetFrameNum() >= cooldown_frame then
		if ComponentGetValue2(controlscomp, "mButtonDownRightClick") or InputIsJoystickButtonDown(0, 26) then
			local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"ItemComponent")
			local uses = ComponentGetValue2(comp,"uses_remaining")
			if uses >= 1 or uses == -1 or alwayscast then
				local mana = wand.mana
				if (mana > manacost) then

					GameShootProjectile(root, x+aim_x*12, y+aim_y*12, x+aim_x*20, y+aim_y*20, EntityLoad("data/entities/projectiles/deck/regeneration_field.xml", x, y))
					wand.mana = mana - manacost
					ComponentSetValue2( variablecomp, "value_int", GameGetFrameNum() + cooldown_frames )
					if alwayscast == false then
						uses = uses - 1
						ComponentSetValue2(comp,"uses_remaining",uses)
					end
					if uses <= 0 then
						GamePlaySound( "data/audio/Desktop/items.bank", "magic_wand/action_consumed", x, y )
						EntityLoad("mods/apotheosis/files/entities/particles/spell_fades/cov_fade.xml", x, y )
					end
				else
					GamePlaySound( "data/audio/Desktop/items.bank", "magic_wand/out_of_mana", x, y );
				end
			end
		end
	end
end

---Handles alt fire cards
---@param card integer the card ID
---@param projectile string the projectile to fire
---@param cooldown_frames integer the integer of frames to wait
---@param vel_min integer the minimum velocity
---@param vel_max integer the maximum velocity
---@param mana_cost integer the mana cost
---@param limited boolean|nil whether it is limited
---@param fade string|nil whether it is limited
function AltFireHandler(card, projectile, cooldown_frames, vel_min, vel_max, mana_cost, limited, fade)
	local wand = EntityGetParent(card)
	local shooter = EntityGetRootEntity(card)
	local vscs = EntityGetComponent(card, "VariableStorageComponent") or {}
	local cooldown = nil -- Could be replaced with GetValueNumber ?
	local vsc = nil
	for i = 1, #vscs do
		if ComponentGetValue2(vscs[i], "name") == "cooldown_frame" then
			cooldown = ComponentGetValue2(vscs[i], "value_int"); vsc = vscs[i]; goto start break
		end
	end

	if not cooldown then return end
	::start::
	local now = GameGetFrameNum()
	local abilitycomp = EntityGetFirstComponentIncludingDisabled(wand, "AbilityComponent") --[[@cast abilitycomp integer]]
	local controlscomp = EntityGetFirstComponentIncludingDisabled(shooter, "ControlsComponent") --[[@cast controlscomp integer]]
	local itemcomp = EntityGetFirstComponentIncludingDisabled(shooter, "ItemComponent") --[[@cast itemcomp integer]]

	local mana = ComponentGetValue2(abilitycomp, "mana")
	local alwayscast = ComponentGetValue2(itemcomp, "permanently_attached")
	local uses = ComponentGetValue2(itemcomp, "uses_remaining")
	local unlimited = (alwayscast or uses<0)

	--[[ NOTE FOR DEVS! THE FOLLOWING TWO VARIABLES SHOULD BE SET DURING INITIALIZATION BY GSUBBING THEM!! GET VALUES FROM MOD SETTINGS, OR USE FALLBACK VALUES. ]]

	local key_func = function () print("[APO] KEYBIND NOT SET") end -- This should be set in init
	local key_id = 0 -- This should be set in init


	local x, y = EntityGetTransform(card)
	if now >= cooldown then
		if ComponentGetValue2(controlscomp, "mButtonFrameRightClick") == now then
			local mana = ComponentGetValue2(abilitycomp, "mana")
			if (mana >= mana_cost) then

				-- Handle shoot dist
				local dist_x, dist_y = 12, 0
				local HotspotComponent = EntityGetFirstComponentIncludingDisabled(wand, "HotspotComponent", "shoot_pos")
				if HotspotComponent then
					local wand_x, wand_y, wand_r = EntityGetTransform(wand)
					local ox, oy = ComponentGetValue2(HotspotComponent, "offset")
					local tx = math.cos(wand_r) * ox - math.sin(wand_r) * oy
					local ty = math.sin(wand_r) * ox + math.cos(wand_r) * oy
					dist_x, dist_y = tx, ty
				end

				-- Handle Shooting
				local aim_x, aim_y = ComponentGetValue2(controlscomp, "mAimingVectorNormalized")
				local shoot_x, shoot_y = x + dist_x, y + dist_y
				local projectile_id = EntityLoad(projectile, shoot_x, shoot_y)
				local projcomp = EntityGetFirstComponent(projectile_id, "ProjectileComponent") --[[@cast projcomp integer]]
				local velcomp = EntityGetFirstComponent(projectile_id, "VelocityComponent") --[[@cast velcomp integer]]
				local genome = EntityGetFirstComponent(shooter, "GenomeDataComponent")
				local herd_id = genome and ComponentGetValue2(genome, "herd_id") or -1
				local velocity = math.random(vel_min, vel_max)
				local vel_x, vel_y = aim_x * velocity, aim_y * velocity
				GameShootProjectile(shooter, shoot_x, shoot_y, x + vel_x, y + vel_y, projectile_id, true)
				ComponentSetValue2(projcomp, "mWhoShot", shooter)
				ComponentSetValue2(projcomp, "mShooterHerdId", herd_id)
				ComponentSetValue2(velcomp, "mVelocity", vel_x, vel_y)

				-- Handle Mana
				ComponentSetValue2(abilitycomp, "mana", mana - mana_cost)
				ComponentSetValue2(vsc, "value_int", now + cooldown_frames) -- Could be replaced with SetValueNumber ?
			else
				GamePlaySound("data/audio/Desktop/items.bank", "magic_wand/out_of_mana", x, y)
			end
		end
	end
end
return AltFireHandler

