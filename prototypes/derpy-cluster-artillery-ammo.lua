-- Kizrak

-- prototypes\derpy-cluster-artillery-ammo.lua

local sb = serpent.block -- luacheck: ignore 211

---------------------------------------------------------------------------------------------------

-- the recicpe to craft the item
local derpyArtilleryShellRecipe = table.deepcopy(data.raw.recipe["artillery-shell"])

derpyArtilleryShellRecipe.name = "derpy-cluster-artillery-ammo"
derpyArtilleryShellRecipe.result = "derpy-cluster-artillery-ammo"
derpyArtilleryShellRecipe.ingredients = {
   {"steel-plate", 1},
   {"water-barrel", 1},
   {"coal", 5},
}
derpyArtilleryShellRecipe.category = "advanced-crafting"
derpyArtilleryShellRecipe.energy_required = 20

data:extend{derpyArtilleryShellRecipe}

---------------------------------------------------------------------------------------------------

-- item the player carries
local derpyArtilleryAmmo = table.deepcopy(data.raw["ammo"]["artillery-shell"])

derpyArtilleryAmmo.name = "derpy-cluster-artillery-ammo"
derpyArtilleryAmmo.ammo_type.action.action_delivery.projectile="derpy-cluster-artillery-projectile-1"
derpyArtilleryAmmo.stack_size = 20

data:extend{derpyArtilleryAmmo}

---------------------------------------------------------------------------------------------------

-- thing that flies through air and does damage
local derpyArtilleryProjectile = table.deepcopy(data.raw["artillery-projectile"]["artillery-projectile"])

derpyArtilleryProjectile.name = "derpy-cluster-artillery-projectile-1"

derpyArtilleryProjectile.final_action = nil

derpyArtilleryProjectile.action = {
   {
      type = "cluster",
      cluster_count = 11,
      distance = 10,
      distance_deviation = 15,
      action_delivery =
      {
         type = "projectile",
         projectile = "cluster-projectile-2", -- not grenade
         direction_deviation = 0.6,
         starting_speed = 0.25,
         starting_speed_deviation = 0.3,
      }
   },
	{
		type = "area",
		radius = 30,
		entity_flags = { "hidden", },
		-- TODO show_in_tooltip ?
	}
}

log(sb( derpyArtilleryProjectile ))
data:extend{derpyArtilleryProjectile}

---------------------------------------------------------------------------------------------------

local derpyClusterArtilleryProjectile =
   {
      type = "projectile",
      name = "cluster-projectile-2",
      flags = {"not-on-map"},
      acceleration = 0.005,
      action =
      {
         {
            type = "cluster",
            cluster_count = 11,
            distance = 10,
            distance_deviation = 15,
            action_delivery =
            {
               type = "projectile",
               projectile = "cluster-artillery-pellet-3",
               direction_deviation = 0.6,
               starting_speed = 0.25,
               starting_speed_deviation = 0.3,
               max_range = 20,
            }
         }
      },
      light = {intensity = 0.5, size = 4},
      animation =
      {
         filename = "__base__/graphics/entity/artillery-projectile/hr-shell.png",
         width = 64,
         height = 64,
         scale = 0.5
      },
      shadow =
      {
         filename = "__base__/graphics/entity/artillery-projectile/hr-shell-shadow.png",
         width = 64,
         height = 64,
         scale = 0.5
      },
   }

log(sb( derpyClusterArtilleryProjectile ))
data:extend{derpyClusterArtilleryProjectile}

---------------------------------------------------------------------------------------------------

local derpyClusterArtilleryPellet =
   {
      type = "projectile",
      name = "cluster-artillery-pellet-3",
      direction_only = true,
      flags = {"not-on-map"},
      acceleration = 0.005,
      action =
      {
         {
            type = "area",
            radius = 6.5,
            action_delivery =
            {
               type = "instant",
               target_effects =
               {
                  {
                     type = "damage",
                     damage = {amount = 1, type = "impact"}
                  },
						--[[
                  {
                     type = "create-entity",
                     entity_name = "explosion"
                  }
						]]--
               }
            }
         }
      },
      light = {intensity = 0.5, size = 4},
      animation =
      {
         filename = "__base__/graphics/entity/bullet/bullet.png",
         frame_count = 1,
         width = 3,
         height = 50,
         priority = "high"
      },
   }

log(sb( derpyClusterArtilleryPellet ))
data:extend{derpyClusterArtilleryPellet}

---------------------------------------------------------------------------------------------------

