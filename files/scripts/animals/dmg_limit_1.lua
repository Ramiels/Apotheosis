function damage_about_to_be_received( damage )
	return math.max(0.04, damage)
end