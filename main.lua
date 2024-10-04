local mod = RegisterMod("Unique Items Port Pack", 1)

if not UniqueItemsAPI then
	local warn = "[Unique Items Port Pack] UniqueItemsAPI is not installed! It is required for this mod to function, please install it from the Steam Workshop."
	print(warn)
	Isaac.DebugString(warn)
	return
end

local basePath = "gfx_unique_portpack/"
local itemPath = basePath .. "collectibles/"
local costumePath = basePath .. "costumes/"
local familiarPath = basePath .. "familiars/"
local knifePath = basePath .. "knives/"

-----------------
--  MR. DOLLY  --
-----------------

--Lost and Soul technically never use their costumes but stewart created one for each of them so I'm implementing their costumes anyway lol
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
	local costumePath = noCostumes[playerType] and nil or
		costumePath .. "mr_dolly_stewart/" .. playerType .. "_DollyCostume.png"
	UniqueItemsAPI.AddCharacterItem({
		PlayerType = playerType,
		ItemID = CollectibleType.COLLECTIBLE_MR_DOLLY,
		ItemSprite = itemPath .. "mr_dolly_stewart/" .. playerType .. "_MrDolly.png",
		CostumeSpritePath = costumePath,
	})
end
UniqueItemsAPI.RegisterCharacter("Josuke", false)
UniqueItemsAPI.RegisterCharacter("Josuke", true)
UniqueItemsAPI.AddCharacterItem({
	PlayerType = Isaac.GetPlayerTypeByName("Josuke", false),
	ItemID = CollectibleType.COLLECTIBLE_MR_DOLLY,
	ItemSprite = itemPath .. "mr_dolly_stewart/Josuke_MrDolly.png",
	CostumeSpritePath = costumePath
})
UniqueItemsAPI.AddCharacterItem({
	PlayerType = Isaac.GetPlayerTypeByName("Josuke", true),
	ItemID = CollectibleType.COLLECTIBLE_MR_DOLLY,
	ItemSprite = itemPath .. "mr_dolly_stewart/BJosuke_MrDolly.png",
	CostumeSpritePath = costumePath
})

------------------
--  BIRTHRIGHT  --
------------------

UniqueItemsAPI.RegisterMod("Gouchnox's Birthrights")
for playerType = 0, PlayerType.NUM_PLAYER_TYPES - 1 do
	UniqueItemsAPI.AddCharacterItem({
		PlayerType = playerType,
		ItemID = CollectibleType.COLLECTIBLE_BIRTHRIGHT,
		ItemSprite = itemPath .. "birthright_gouchnox/" .. playerType .. "_birthright.png"
	})
end

local gouchnoxSupportedChars = {
	"Andromeda",
	"Deleted",
	"Job",
	"Mastema",
	"Samuel"
}
local gouchnoxSupportedTainteds = {
	"AndromedaB",
	"Deleted",
	"Job",
	"MastemaB"
}

for _, name in ipairs(gouchnoxSupportedChars) do
	local playerType = Isaac.GetPlayerTypeByName(name, false)
	UniqueItemsAPI.RegisterCharacter(name, false)
	UniqueItemsAPI.AddCharacterItem({
		PlayerType = playerType,
		ItemID = CollectibleType.COLLECTIBLE_BIRTHRIGHT,
		ItemSprite = itemPath .. "birthright_gouchnox/" .. string.lower(name) .. "_birthright.png"
	})
end

for _, name in ipairs(gouchnoxSupportedTainteds) do
	local playerType = Isaac.GetPlayerTypeByName(name, true)
	UniqueItemsAPI.RegisterCharacter(name, true)
	if string.sub(name, -1, -1) ~= "B" then name = name .. "B" end
	UniqueItemsAPI.AddCharacterItem({
		PlayerType = playerType,
		ItemID = CollectibleType.COLLECTIBLE_BIRTHRIGHT,
		ItemSprite = itemPath .. "birthright_gouchnox/" .. string.lower(name) .. "_birthright.png"
	})
end

local function DeletedHasBirthright(itemParams)
	if itemParams.ModName == "Gouchnox's Birthrights"
		and itemParams.PlayerType == Isaac.GetPlayerTypeByName("Deleted", false)
		and itemParams.ItemID == CollectibleType.COLLECTIBLE_BIRTHRIGHT then
		return true
	end
	return false
end

local function DeletedModeBirthright(itemParams)
	---@diagnostic disable-next-line: undefined-global
	itemParams.ItemSprite = string.gsub(itemParams.ItemSprite, "birthright.png", "birthright_" .. theDeletedMode .. ".png")
	return itemParams
end

UniqueItemsAPI.AddItemModifier("Gouchnox Deleted Birthright", DeletedHasBirthright, DeletedModeBirthright)

local TearFlagsBlood = {
	[TearVariant.BLOOD] = true,
	[TearVariant.CUPID_BLOOD] = true,
	[TearVariant.PUPULA_BLOOD] = true,
	[TearVariant.GODS_FLESH_BLOOD] = true,
	[TearVariant.NAIL_BLOOD] = true,
	[TearVariant.GLAUCOMA_BLOOD] = true,
	[TearVariant.EYE_BLOOD] = true,
}
local SkinColorToString = {
	[SkinColor.SKIN_PINK] = "",
	[SkinColor.SKIN_WHITE] = "_white",
	[SkinColor.SKIN_BLACK] = "_black",
	[SkinColor.SKIN_BLUE] = "_blue",
	[SkinColor.SKIN_RED] = "_strawberry",
	[SkinColor.SKIN_GREEN] = "_green",
	[SkinColor.SKIN_GREY] = "_grey",
}

local function AndromedaBHasBirthright(itemParams)
	local tearVariant = itemParams.Player:GetTearHitParams(WeaponType.WEAPON_TEARS, 1, 1, nil).TearVariant

	if itemParams.ModName == "Gouchnox's Birthrights"
		and itemParams.PlayerType == Isaac.GetPlayerTypeByName("AndromedaB", true)
		and itemParams.ItemID == CollectibleType.COLLECTIBLE_BIRTHRIGHT
		and itemParams.Player ~= nil
		and (
		itemParams.Player:GetHeadColor() ~= SkinColor.SKIN_PINK
			or TearFlagsBlood[tearVariant] == true
		)
	then
		return true
	end
	return false
end

local function AndromedaBSkinColorBirthright(itemParams)
	local tearVariant = itemParams.Player:GetTearHitParams(WeaponType.WEAPON_TEARS, 1, 1, nil).TearVariant

	if TearFlagsBlood[tearVariant] then
		itemParams.ItemSprite = string.gsub(itemParams.ItemSprite, "birthright.png", "birthright_blood.png")
	else
		itemParams.ItemSprite = string.gsub(itemParams.ItemSprite, "birthright.png",
			"birthright" .. SkinColorToString[itemParams.Player:GetHeadColor()] .. ".png")
	end
	return itemParams
end

UniqueItemsAPI.AddItemModifier("Gouchnox AndromedaB Birthright", AndromedaBHasBirthright, AndromedaBSkinColorBirthright)

---------------
--  INCUBUS  --
---------------

UniqueItemsAPI.RegisterMod("Incubuddies")
--Excluding Tainted Soul as they cannot have items
for playerType = 0, PlayerType.NUM_PLAYER_TYPES - 2 do
	local spritePath = familiarPath .. "incubus_incubuddies/" .. playerType .. "_incubus.png"
	UniqueItemsAPI.AddCharacterFamiliar({
		PlayerType = playerType,
		FamiliarVariant = FamiliarVariant.INCUBUS,
		FamiliarSprite = {
			[0] = spritePath,
			[1] = spritePath,
			[2] = spritePath
		}
	})
end

--------------------
--  SPIRIT SWORD  --
--------------------

local unsupportedSwords = {
	[PlayerType.PLAYER_THEFORGOTTEN] = true,
	[PlayerType.PLAYER_THEFORGOTTEN_B] = true,
	[PlayerType.PLAYER_THESOUL_B] = true
}

---@class KnifeVariant
local KnifeVariant = {
	MOMS_KNIFE = 0,
	BONE = 1,
	BONE_KNIFE = 2,
	JAWBONE = 3,
	BAG_OF_CRAFTING = 4,
	SUMPTORIUM = 5,
	NOTCHED_AXE = 9,
	SPIRIT_SWORD = 10,
	TECH_SWORD = 11,
}

UniqueItemsAPI.RegisterMod("Xtrike's Take")
for playerType = 0, PlayerType.NUM_PLAYER_TYPES - 1 do
	if not unsupportedSwords[playerType] then
		local spritePath = knifePath .. "spirit_sword_xtrike/" .. playerType .. "_spirit_sword.png"
		UniqueItemsAPI.AddCharacterKnife({
			PlayerType = playerType,
			KnifeVariant = KnifeVariant.SPIRIT_SWORD,
			KnifeSprite = {
				[0] = spritePath,
				[1] = spritePath,
				[2] = spritePath
			},
		})
	end
end

UniqueItemsAPI.RegisterMod("Royal's Take")
for playerType = 0, PlayerType.NUM_PLAYER_TYPES - 1 do
	if not unsupportedSwords[playerType] then
		local spritePath = knifePath .. "spirit_sword_royal/" .. playerType .. "_spirit_sword.png"
		UniqueItemsAPI.AddCharacterKnife({
			PlayerType = playerType,
			KnifeVariant = KnifeVariant.SPIRIT_SWORD,
			KnifeSprite = {
				[0] = spritePath,
				[1] = spritePath,
				[2] = spritePath
			}
		})
	end
end

UniqueItemsAPI.RegisterMod("L0GiCked's Animated Swords")
--Excluding Tainted Soul as they cannot have items
--Code for Tainted Eve, Forgotten, and Tainted Forgotten's special swords are commented out thanks to knives being a bitch to work with. They mostly work, but not to my standards to include them in the pack.
for playerType = 0, PlayerType.NUM_PLAYER_TYPES - 2 do
	local spritePath = knifePath .. "spirit_sword_L0GiCked/" .. playerType .. "_spirit_sword.anm2"
	local tearPath = string.gsub(spritePath, "spirit_sword.anm2", "sword_tear.anm2")
	local splashPath = string.gsub(spritePath, "spirit_sword.anm2", "sword_poof.anm2")

	if playerType == PlayerType.PLAYER_THEFORGOTTEN or playerType == PlayerType.PLAYER_THEFORGOTTEN_B then
		--[[ UniqueItemsAPI.AddCharacterKnife({
			PlayerType = playerType,
			KnifeVariant = KnifeVariant.BONE,
			KnifeSprite = "gfx/008.001_Bone Club.anm2"
		}) ]]
	else
		UniqueItemsAPI.AddCharacterKnife({
			PlayerType = playerType,
			KnifeVariant = KnifeVariant.SPIRIT_SWORD,
			KnifeSprite = spritePath,
			SwordProjectile = {
				Beam = tearPath,
				Splash = playerType == PlayerType.PLAYER_BLUEBABY_B and nil or splashPath
			}
		})
		--[[ UniqueItemsAPI.AddCharacterItem({
			PlayerType = playerType,
			ItemID = CollectibleType.COLLECTIBLE_SPIRIT_SWORD,
			ItemSprite = itemPath .. "spirit_sword_L0GiCked/" .. playerType .. "_spirit_sword.png",
		}) ]]
	end

	--[[ if playerType == PlayerType.PLAYER_EVE_B then
	UniqueItemsAPI.AddCharacterKnife({
		PlayerType = playerType,
		KnifeVariant = KnifeVariant.SUMPTORIUM,
		KnifeSprite = {
			[0] = "gfx/effects/effect_sumptorium.png",
		}
	})
	end ]]
end

local noTearModded = {
	["​Isaac"] = true,
}

local L0giCkedsupportedChars = {
	"Andromeda"
}
local L0giCkedsupportedTainteds = {
	"AndromedaB"
}
local L0giCkedsupportedTarnisheds = {
	"​Isaac",
	"​Magdalene",
}

for _, name in ipairs(L0giCkedsupportedChars) do
	local playerType = Isaac.GetPlayerTypeByName(name, false)
	local spritePath = knifePath .. "spirit_sword_L0GiCked/" .. string.lower(name) .. "_spirit_sword.anm2"
	local tearPath = string.gsub(spritePath, "spirit_sword.anm2", "sword_tear.anm2")
	local splashPath = string.gsub(spritePath, "spirit_sword.anm2", "sword_poof.anm2")
	UniqueItemsAPI.AddCharacterKnife({
		PlayerType = playerType,
		KnifeVariant = KnifeVariant.SPIRIT_SWORD,
		KnifeSprite = spritePath,
		SwordProjectile = noTearModded[name] and nil or {
			Beam = tearPath,
			Splash = splashPath
		}
	})
end

for _, name in ipairs(L0giCkedsupportedTainteds) do
	local playerType = Isaac.GetPlayerTypeByName(name, true)
	local spritePath = knifePath .. "spirit_sword_L0GiCked/" .. string.lower(name) .. "_spirit_sword.anm2"
	local tearPath = string.gsub(spritePath, "spirit_sword.anm2", "sword_tear.anm2")
	local splashPath = string.gsub(spritePath, "spirit_sword.anm2", "sword_poof.anm2")
	UniqueItemsAPI.AddCharacterKnife({
		PlayerType = playerType,
		KnifeVariant = KnifeVariant.SPIRIT_SWORD,
		KnifeSprite = spritePath,
		SwordProjectile = noTearModded[name] and nil or {
			Beam = tearPath,
			Splash = splashPath
		}
	})
end

--[[ for _, name in ipairs(L0giCkedsupportedTarnisheds) do
	UniqueItemsAPI.RegisterCharacter(name, false)
	local playerType = Isaac.GetPlayerTypeByName(name, false)
	local spritePath = knifePath .. "spirit_sword_L0GiCked/" .. string.lower(string.sub(name, 2, -1)) .. "c_spirit_sword.anm2"
	local tearPath = string.gsub(spritePath, "spirit_sword.anm2", "sword_tear.anm2")
	local splashPath = string.gsub(spritePath, "spirit_sword.anm2", "sword_poof.anm2")
	UniqueItemsAPI.AddCharacterKnife({
		PlayerType = playerType,
		KnifeVariant = KnifeVariant.SPIRIT_SWORD,
		KnifeSprite = spritePath,
		SwordProjectile = noTearModded[name] and nil or {
			Beam = tearPath,
			Splash = splashPath
		}
	})
end ]]


--[[ 
local function IsL0GiCkedSwordEnabled(params)
	local isUsingL0giCked = false
	if params.ItemID == CollectibleType.COLLECTIBLE_SPIRIT_SWORD
	and UniqueItemsAPI.GetCurrentKnifeMod(KnifeVariant.SPIRIT_SWORD, params.PlayerType) == "L0GiCked's Animated Swords"
	and UniqueItemsAPI.IsKnifeEnabled(KnifeVariant.SPIRIT_SWORD) == true
	then
		isUsingL0giCked = true
	end
	return isUsingL0giCked
end

local function ApplyL0GiCkedCollectibleSprite(params)
	params.ItemSprite = "gfx_unique_portpack/collectibles/spirit_sword_l0giCked/"..params.PlayerType.."_spirit_sword.png"
	return params
end

UniqueItemsAPI.AddItemModifier("L0GiCked Sword Collectible", IsL0GiCkedSwordEnabled, ApplyL0GiCkedCollectibleSprite) ]]

--[[ local function BoneShouldPlaySpecialIdleAnimation(params)
	if params.ModName == "Animated Spirit Swords"
	and params.KnifeVariant == KnifeVariant.BONE
	and params.Player ~= nil
	and params.Player:HasCollectible(CollectibleType.COLLECTIBLE_SPIRIT_SWORD)
	and params.Knife ~= nil
	and params.Knife:GetSprite():GetAnimation() == "Idle"
	and not params.Knife:GetSprite():IsPlaying("Idle")
	then
		return true
	end

	return false
end

local function PlayAnimatedBoneSwordIdle(params)
	params.Knife:GetSprite():Play("Idle", true)
	return params
end

UniqueItemsAPI.AddKnifeModifier("Forgotten l0giCked Bone Idle", BoneShouldPlaySpecialIdleAnimation, PlayAnimatedBoneSwordIdle)

local function ForgottenHasSpiritSword(params)
	if params.ModName == "Animated Spirit Swords"
	and (params.PlayerType == PlayerType.PLAYER_THEFORGOTTEN
	or params.PlayerType == PlayerType.PLAYER_THEFORGOTTEN_B)
	and params.Player ~= nil
	and params.Player:HasCollectible(CollectibleType.COLLECTIBLE_SPIRIT_SWORD)
	then
		return true
	end
	return false
end

local function ForgottenAnimatedSword(params)
	local spritePath = knifePath .. "spirit_sword_l0giCked/" .. params.PlayerType .. "_spirit_sword.anm2"
	params.KnifeSprite = spritePath
	return params
end

UniqueItemsAPI.AddKnifeModifier("Forgotten l0giCked Bone", ForgottenHasSpiritSword, ForgottenAnimatedSword)

local function EveBHasSpiritSwordAndSumptoriumKnife(params)
	if params.ModName == "Animated Spirit Swords"
	and params.KnifeVariant == KnifeVariant.SUMPTORIUM
	and params.PlayerType == PlayerType.PLAYER_EVE_B
	and params.Player ~= nil
	and params.Player:HasCollectible(CollectibleType.COLLECTIBLE_SPIRIT_SWORD)
	then
		return true
	end
	return false
end

local function EveUniqueSumptorium(params)
	params.KnifeSprite = {
		[0] = knifePath .. "spirit_sword_l0giCked/effect_sumptorium.png",
	}
	return params
end

UniqueItemsAPI.AddKnifeModifier("Tainted Eve l0giCked Sumptorium", EveBHasSpiritSwordAndSumptoriumKnife, EveUniqueSumptorium)
]]
