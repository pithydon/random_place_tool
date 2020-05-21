minetest.register_tool("random_place_tool:random_place_tool", {
	description = "Random Place Tool",
	inventory_image = "random_place_tool.png",
	wield_image = "random_place_tool.png",
	on_place = function(itemstack, placer, pointed_thing)
		local inv = placer:get_inventory()
		local items = {}
		for i=1,8 do
			local itemstack = inv:get_stack("main", i)
			if not itemstack:is_empty() then
				local name = itemstack:get_name()
				local item = minetest.registered_items[name]
				if name ~= "random_place_tool:random_place_tool" and item then
					table.insert(items, {itemstack, item.on_place, i})
				end
			end
		end
		if items[1] then
			local item = items[math.random(#items)]
			local func = item[2]
			local var = func(item[1], placer, pointed_thing)
			if type(var) == "userdata" and var:is_known() then
				inv:set_stack("main", item[3], var)
			end
		end
	end
})

if minetest.get_modpath("default") then
	minetest.register_craft({
		output = "random_place_tool:random_place_tool",
		recipe = {
			{"", "", "default:mese_crystal"},
			{"", "group:stick", "default:mese_crystal"},
			{"group:stick", "", ""}
		}
	})
end
