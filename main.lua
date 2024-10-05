--VERSION v1.1	

local mod = RegisterMod("Unique Items Port Pack", 1)

if not UniqueItemsAPI then
	local warn =
	"[Unique Items Port Pack] UniqueItemsAPI is not installed! It is required for this mod to function, please install it from the Steam Workshop."
	print(warn)
	Isaac.DebugString(warn)
	return
end

--#region variables

local basePath = "gfx_unique_portpack/"
local itemPath = basePath .. "collectibles/"
local costumePath = basePath .. "costumes/"
local familiarPath = basePath .. "familiars/"
local knifePath = basePath .. "knives/"

--#endregion

function mod:OnUniqueItemsLoad()
	--#region Register Moddeds

	local fullModdedSupportList = {
		"Josuke",
		"Deleted",
		"Samuel",
		"Golem",
		"Fiend",
		"Josuke",
		"Namie",
		"Sarah",
		"Dante",
		"Charon",
		"Andromeda",
		"Samael",
		"Bertran",
		"Mei",
		"Icarus",
		"Mammon",
		"Edith",
		[" Edith"] = "Edith (Classic)",
		"Job",
		"Arachna",
		"Nemesis",
		"Sodom",
		"Gomorrah",
		"Bela",
		"Eevee",
		"Guppy",
		"Steven",
		"Car",
		"Hollow",
		"Stranger",
		"Mastema",
		"MaidInTheMist",
		"Dio Part 1",
		"Siren",
		["​Isaac"] = "Tarnished Isaac",
		["​Magdalene"] = "Tarnished Magdalene",
		["​Cain"] = "Tarnished Cain",
		["​Judas"] = "Tarnished Judas",
		["​Samson"] = "Tarnished Samson",
		["​Eden"] = "Tarnished Eden",
		["​Keeper"] = "Tarnished Keeper",
		"Bael",
		"The Sheriff",
		"Felix",
		["!!!"] = "Red Baby",
		["..."] = "Dead Baby",
		"Henry"
	}

	local fullModdedTaintedList = {
		"Josuke",
		"Deleted",
		"Fiend",
		"Tainted Namie",
		"AndromedaB",
		"Samael",
		"Tainted Mei",
		"Edith",
		"Job",
		"Arachna",
		"Tainted Nemesis",
		"Sodom",
		"Gomorrah",
		"Decayed",
		"Tainted Stranger",
		"MastemaB",
		"Dio Part 3",
		["!!!"] = "Red Baby",
	}

	for key, name in pairs(fullModdedSupportList) do
		local displayName
		if type(key) == "string" then
			displayName = name
			name = key
		end
		UniqueItemsAPI.RegisterCharacter(name, false, displayName)
	end

	for key, name in pairs(fullModdedTaintedList) do
		local displayName
		if type(key) == "string" then
			displayName = name
			name = key
		end
		if string.find(name, "Tainted") then
			displayName = name
		end
		if string.sub(name, -1, -1) == "B" then
			displayName = string.sub(name, 1, -2)
		end

		UniqueItemsAPI.RegisterCharacter(name, true, displayName)
	end

	--#endregion
	--#region Mr. Dolly

	-----------------
	--  MR. DOLLY  --
	-----------------

	local noCostumes = {
		[PlayerType.PLAYER_THEFORGOTTEN] = true,
		[PlayerType.PLAYER_BETHANY] = true,
		[PlayerType.PLAYER_JACOB] = true,
		[PlayerType.PLAYER_THEFORGOTTEN_B] = true,
		[PlayerType.PLAYER_BETHANY_B] = true,
		[PlayerType.PLAYER_JACOB_B] = true,
		[PlayerType.PLAYER_JACOB2_B] = true,
	}

	UniqueItemsAPI.RegisterMod("Stewartisme's Mr Dolly's")
	for playerType = 0, PlayerType.NUM_PLAYER_TYPES - 1 do
		---@type string | nil
		local dollyCostumePath = costumePath .. "mr_dolly_stewart/" .. playerType .. "_DollyCostume.png"
		if noCostumes[playerType] then dollyCostumePath = nil end
		UniqueItemsAPI.AssignUniqueObject({
			PlayerType = playerType,
			ObjectID = CollectibleType.COLLECTIBLE_MR_DOLLY,
			SpritePath = { itemPath .. "mr_dolly_stewart/" .. playerType .. "_MrDolly.png" },
			CostumeSpritePath = dollyCostumePath,
		}, UniqueItemsAPI.ObjectType.COLLECTIBLE)
	end

	UniqueItemsAPI.AssignUniqueObject({
		PlayerType = Isaac.GetPlayerTypeByName("Josuke", false),
		ObjectID = CollectibleType.COLLECTIBLE_MR_DOLLY,
		SpritePath = { itemPath .. "mr_dolly_stewart/Josuke_MrDolly.png" },
		CostumeSpritePath = costumePath
	}, UniqueItemsAPI.ObjectType.COLLECTIBLE)

	UniqueItemsAPI.AssignUniqueObject({
		PlayerType = Isaac.GetPlayerTypeByName("Josuke", true),
		ObjectID = CollectibleType.COLLECTIBLE_MR_DOLLY,
		SpritePath = { itemPath .. "mr_dolly_stewart/BJosuke_MrDolly.png" },
		CostumeSpritePath = costumePath
	}, UniqueItemsAPI.ObjectType.COLLECTIBLE)

	--#endregion
	--#region Birthright

	------------------
	--  BIRTHRIGHT  --
	------------------

	UniqueItemsAPI.RegisterMod("Gouchnox's Birthrights")
	for playerType = 0, PlayerType.NUM_PLAYER_TYPES - 1 do
		UniqueItemsAPI.AssignUniqueObject({
			PlayerType = playerType,
			ObjectID = CollectibleType.COLLECTIBLE_BIRTHRIGHT,
			SpritePath = { itemPath .. "birthright_gouchnox/" .. playerType .. "_birthright.png" }
		}, UniqueItemsAPI.ObjectType.COLLECTIBLE)
	end

	local gouchnoxSupportedChars = {
		"Andromeda",
		"Deleted",
		"Job",
		"Mastema",
		"Samuel",
		"Steven"
	}
	local gouchnoxSupportedTainteds = {
		"AndromedaB",
		"Deleted",
		"Job",
		"MastemaB"
	}

	for i = 1, 2 do
		local charList = i == 1 and gouchnoxSupportedChars or gouchnoxSupportedTainteds
		local isTainted = i == 2
		for _, name in ipairs(charList) do
			local playerType = Isaac.GetPlayerTypeByName(name, isTainted)

			UniqueItemsAPI.AssignUniqueObject({
				PlayerType = playerType,
				ObjectID = CollectibleType.COLLECTIBLE_BIRTHRIGHT,
				SpritePath = { itemPath .. "birthright_gouchnox/" .. string.lower(name) .. "_birthright.png" }
			}, UniqueItemsAPI.ObjectType.COLLECTIBLE)
		end
	end

	local function deletedHasBirthright(params)
		return params.ModName == "Gouchnox's Birthrights"
			and theDeletedMode ~= nil
			and params.PlayerType == Isaac.GetPlayerTypeByName("Deleted", false)
			and params.ObjectID == CollectibleType.COLLECTIBLE_BIRTHRIGHT
	end

	local function deletedModeBirthright(params)
		params.SpritePath = { string.gsub(params.SpritePath[1], "birthright.png",
			"birthright_" .. theDeletedMode .. ".png") }
		return params
	end

	UniqueItemsAPI.AssignObjectModifier("Gouchnox Deleted Birthright", deletedHasBirthright, deletedModeBirthright,
		UniqueItemsAPI.ObjectType.COLLECTIBLE)

	local TearFlagsBlood = {
		[TearVariant.BLOOD] = true,
		[TearVariant.CUPID_BLOOD] = true,
		[TearVariant.PUPULA_BLOOD] = true,
		[TearVariant.GODS_FLESH_BLOOD] = true,
		[TearVariant.NAIL_BLOOD] = true,
		[TearVariant.GLAUCOMA_BLOOD] = true,
		[TearVariant.EYE_BLOOD] = true
	}
	local SkinColorToString = {
		[SkinColor.SKIN_PINK] = "",
		[SkinColor.SKIN_WHITE] = "_white",
		[SkinColor.SKIN_BLACK] = "_black",
		[SkinColor.SKIN_BLUE] = "_blue",
		[SkinColor.SKIN_RED] = "_strawberry",
		[SkinColor.SKIN_GREEN] = "_green",
		[SkinColor.SKIN_GREY] = "_grey"
	}

	local function andromedaBHasBirthright(params)
		local tearVariant = params.Player:GetTearHitParams(WeaponType.WEAPON_TEARS, 1, 1, nil).TearVariant

		return params.ModName == "Gouchnox's Birthrights"
			and params.PlayerType == Isaac.GetPlayerTypeByName("AndromedaB", true)
			and params.ObjectID == CollectibleType.COLLECTIBLE_BIRTHRIGHT
			and params.Player ~= nil
			and (
				params.Player:GetHeadColor() ~= SkinColor.SKIN_PINK
				or TearFlagsBlood[tearVariant]
			)
	end

	local function andromedaBSkinColorBirthright(params)
		local tearVariant = params.Player:GetTearHitParams(WeaponType.WEAPON_TEARS, 1, 1, nil).TearVariant
		local suffix = TearFlagsBlood[tearVariant] and SkinColorToString[params.Player:GetHeadColor()] or "_blood"
		local gsubReplace = "birthright" .. suffix .. ".png"
		params.SpritePath = { string.gsub(params.SpritePath[1], "birthright.png", gsubReplace) }
		return params
	end

	UniqueItemsAPI.AssignObjectModifier("Gouchnox AndromedaB Birthright", andromedaBHasBirthright,
		andromedaBSkinColorBirthright, UniqueItemsAPI.ObjectType.COLLECTIBLE)

	--#endregion
	--#region Incubus

	---------------
	--  INCUBUS  --
	---------------

	UniqueItemsAPI.RegisterMod("Incubuddies")

	for playerType = 0, PlayerType.NUM_PLAYER_TYPES - 2 do
		local spritePath = familiarPath .. "incubus_incubuddies/" .. playerType .. "_incubus.png"
		UniqueItemsAPI.AssignUniqueObject({
			PlayerType = playerType,
			ObjectID = FamiliarVariant.INCUBUS,
			SpritePath = {
				[0] = spritePath,
				[1] = spritePath,
				[2] = spritePath
			}
		}, UniqueItemsAPI.ObjectType.FAMILIAR)
	end

	--#endregion
	--#region Spirit Sword

	--------------------
	--  SPIRIT SWORD  --
	--------------------

	local unsupportedSwords = {
		[PlayerType.PLAYER_THEFORGOTTEN] = true,
		[PlayerType.PLAYER_THEFORGOTTEN_B] = true,
		[PlayerType.PLAYER_THESOUL_B] = true
	}

	local KnifeVariant = {
		MOMS_KNIFE = 0,
		BONE_CLUB = 1,
		BONE_KNIFE = 2,
		JAWBONE = 3,
		BAG_OF_CRAFTING = 4,
		SUMPTORIUM = 5,
		NOTCHED_AXE = 9,
		SPIRIT_SWORD = 10,
		TECH_SWORD = 11,
	}

	for i = 1, 2 do
		local modName = i == 1 and "Xtrike's Take" or "Royal's Take"
		local modPath = i == 1 and "xtrike" or "royal"
		UniqueItemsAPI.RegisterMod(modName)
		for playerType = 0, PlayerType.NUM_PLAYER_TYPES - 1 do
			if unsupportedSwords[playerType] then goto continue end
			local spritePath = knifePath .. "spirit_sword_" .. modPath .. "/" .. playerType .. "_spirit_sword.png"
			UniqueItemsAPI.AssignUniqueObject({
				PlayerType = playerType,
				ObjectID = KnifeVariant.SPIRIT_SWORD,
				SpritePath = {
					[0] = spritePath,
					[1] = spritePath,
					[2] = spritePath,
				}
			}, UniqueItemsAPI.ObjectType.KNIFE)
			::continue::
		end
	end

	local henryPath = knifePath .. "spirit_sword_royal/henry_spirit_sword.png"
	UniqueItemsAPI.AssignUniqueObject({
		PlayerType = Isaac.GetPlayerTypeByName("Henry", false),
		ObjectID = KnifeVariant.SPIRIT_SWORD,
		SpritePath = {
			[0] = henryPath,
			[1] = henryPath,
			[2] = henryPath
		}
	}, UniqueItemsAPI.ObjectType.KNIFE)

	local altSwords = {
		"Eyelander",
		"Australium Eyelander",
		"Brand of the Inferno",
		"Zenith",
		"Solar Chainsaw",
		"Old Nail",
		"Sharpened Nail",
		"Channeled Nail",
		"Coiled Nail",
		"Pure Nail",
		"Master Sword Lvl 1",
		"Master Sword Lvl 2",
		"Master Sword Lvl 3",
		"Fabled Sans Blade (Blue)",
		"Fabled Sans Blade (Orange)",
		"8itch Sword",
		"Beam Katana",
		"Binary Sword",
		"Candlestick",
		"Cardboard Tube",
		"Claymore",
		"Cleaver",
		"Crucible",
		"Diamond Sword",
		"Dio's Sign",
		"Dragonslayer",
		"Feather",
		"Guiding Moonlight",
		"Iconoclasts Wrench",
		"Life Stealing Sword",
		"Lothric Knight Sword",
		"Luna Nights",
		"Phosphorus",
		"Planetarium",
		"Pyre Blade",
		"Reimu Fumo",
		"Roblox Sword",
		"Sord",
		"Strange Umbrella",
		"Text Sword",
		"Tricky's Sign",
	}

	local beamSwords = {
		["Phosphorus"] = true,
	}

	for _, modName in ipairs(altSwords) do
		local swordName = string.lower(string.gsub(modName, " ", "_"))
		local spritePath = knifePath .. "spirit_sword_royal_alts/" .. swordName .. ".png"
		local spiritSword
		if beamSwords[modName] then
			spiritSword = {
				Beam = spritePath,
				Splash = spritePath
			}
		end
		UniqueItemsAPI.RegisterMod(modName)
		UniqueItemsAPI.AssignUniqueObject({
			ObjectID = KnifeVariant.SPIRIT_SWORD,
			GlobalMod = true,
			SpritePath = {
				[0] = spritePath,
				[1] = spritePath,
				[2] = spritePath
			},
			SwordProjectile = spiritSword
		}, UniqueItemsAPI.ObjectType.KNIFE)
	end

	--#endregion
	--#region Lost Soul

	-----------------
	--  LOST SOUL  --
	-----------------

	local lostSoulNormal = {
		["Golem"] = true,
		["Fiend"] = true,
		["Josuke"] = true,
		["Namie"] = true,
		["Sarah"] = true,
		["Dante"] = true,
		["Charon"] = true,
		["Andromeda"] = true,
		["Samael"] = true,
		["Bertran"] = true,
		["Mei"] = true,
		["Icarus"] = true,
		["Mammon"] = true,
		["Edith"] = true,
		[" Edith"] = "edith_classic",
		["Job"] = true,
		["Arachna"] = true,
		["Nemesis"] = true,
		["Sodom"] = true,
		["Gomorrah"] = true,
		["Bela"] = true,
		["Eevee"] = true,
		["Guppy"] = true,
		["Steven"] = true,
		["Car"] = true,
		["Hollow"] = true,
		["Stranger"] = true,
		["Mastema"] = true,
		["MaidInTheMist"] = true,
		["Dio Part 1"] = "Dio",
		["Siren"] = true,
		["​Isaac"] = "Isaac_c",
		["​Magdalene"] = "Magdalene_c",
		["​Cain"] = "Cain_c",
		["​Judas"] = "Judas_c",
		["​Samson"] = "Samson_c",
		["​Eden"] = "Eden_c",
		["​Keeper"] = "Keeper_c",
		["Bael"] = true,
		["The Sheriff"] = "Sheriff",
		["Felix"] = true,
		["!!!"] = "RedBaby",
		["..."] = "RedBabySkull",
	}
	local lostSoulTainted = {
		["Fiend"] = true,
		["Tainted Namie"] = "namie_b",
		["AndromedaB"] = "andromeda_b",
		["Samael"] = true,
		["Tainted Mei"] = "mei_b",
		["Edith"] = true,
		["Job"] = true,
		["Arachna"] = true,
		["Tainted Nemesis"] = "nemesis_b",
		["Sodom"] = true,
		["Gomorrah"] = true,
		["Decayed"] = true,
		["Tainted Stranger"] = "stranger_b",
		["MastemaB"] = true,
		["Dio Part 3"] = "dio",
		["!!!"] = "redbaby_b",
	}
	local lostSoulPath = familiarPath .. "lostsoul_customlostsoul/"

	local secondLayerSouls = {
		[PlayerType.PLAYER_THEFORGOTTEN_B] = "40"
	}

	UniqueItemsAPI.RegisterMod("Custom Lost Souls")
	for playerType = 0, PlayerType.NUM_PLAYER_TYPES - 2 do
		local spritePath = lostSoulPath .. playerType .. "_lostsoul.png"
		local secondLayer = secondLayerSouls[playerType]
		local secondLayerPath = secondLayer and lostSoulPath .. secondLayer .. "_lostsoul.png" or nil
		UniqueItemsAPI.AssignUniqueObject({
			PlayerType = playerType,
			ObjectID = FamiliarVariant.LOST_SOUL,
			Anm2 = lostSoulPath .. "003.211_lost soul.anm2",
			SpritePath = {
				[0] = spritePath,
				[1] = spritePath,
				[3] = secondLayerPath,
				[4] = secondLayerPath
			}
		}, UniqueItemsAPI.ObjectType.FAMILIAR)
	end

	for name, value in pairs(lostSoulNormal) do
		local fileName = type(value) == "string" and value or name
		local spritePath = lostSoulPath .. fileName .. "_lostsoul.png"
		UniqueItemsAPI.AssignUniqueObject({
			PlayerType = Isaac.GetPlayerTypeByName(name, false),
			ObjectID = FamiliarVariant.LOST_SOUL,
			Anm2 = lostSoulPath .. "003.211_lost soul.anm2",
			SpritePath = {
				[0] = spritePath,
				[1] = spritePath,
			}
		}, UniqueItemsAPI.ObjectType.FAMILIAR)
	end

	for name, value in pairs(lostSoulTainted) do
		local fileName = type(value) == "string" and value or name
		local spritePath = lostSoulPath .. fileName .. "_lostsoul.png"
		UniqueItemsAPI.AssignUniqueObject({
			PlayerType = Isaac.GetPlayerTypeByName(name, true),
			ObjectID = FamiliarVariant.LOST_SOUL,
			Anm2 = lostSoulPath .. "003.211_lost soul.anm2",
			SpritePath = {
				[0] = spritePath,
				[1] = spritePath,
			}
		}, UniqueItemsAPI.ObjectType.FAMILIAR)
	end

	local function eveIsAWhore(params)
		if not params.Player then return false end
		local effects = params.Player:GetEffects()
		return params.ObjectType == UniqueItemsAPI.ObjectType.FAMILIAR
			and params.ObjectID == FamiliarVariant.LOST_SOUL
			and (
				(params.PlayerType == PlayerType.PLAYER_EVE
					and effects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_WHORE_OF_BABYLON)
				)
				or (params.PlayerType == PlayerType.PLAYER_EVE_B
					and effects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_SUMPTORIUM)
				)
			)
	end

	local function applyEveWhore(params)
		for layerID, spritePath in pairs(params.SpritePath) do
			params[layerID] = string.gsub(spritePath, ".png", "_whore.png")
		end
		return params
	end

	UniqueItemsAPI.AssignObjectModifier("Lost Soul Eve Whore", eveIsAWhore, applyEveWhore, UniqueItemsAPI.ObjectType
		.FAMILIAR)

	--#endregion
end

mod:AddCallback(UniqueItemsAPI.Callbacks.LOAD_UNIQUE_ITEMS, mod.OnUniqueItemsLoad)
