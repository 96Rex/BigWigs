
assert(BigWigs, "BigWigs not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigsRange")


----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["Range"] = true,
	["range"] = true,
	["Options for the combat log's range."] = true,

	["party"] = true,
	["Party"] = true,
	["Party combat log range."] = true,

	["friend"] = true,
	["Friendlies"] = true,
	["Friendly players combat log range."] = true,

	["hostile"] = true,
	["Hostiles"] = true,
	["Hostile players combat log range."] = true,

	["mob"] = true,
	["Creatures"] = true,
	["Creature combat log range."] = true,

	["death"] = true,
	["Deaths"] = true,
	["Death message range."] = true,

	["reset"] = true,
	["Reset to defaults"] = true,
	["Resets all ranges to defaults."] = true,
} end)
L:RegisterTranslations("zhCN", function() return {
	["Range"] = "记录范围",
	["range"] = "记录范围",
	["Options for the combat log's range."] = "设置战斗记录范围",

	["party"] = "队伍",
	["Party"] = "队伍",
	["Party combat log range."] = "队伍战斗记录范围",

	["friend"] = "友方",
	["Friendlies"] = "友方",
	["Friendly players combat log range."] = "友方玩家战斗记录范围",

	["hostile"] = "敌对",
	["Hostiles"] = "敌对",
	["Hostile players combat log range."] = "敌对玩家战斗记录范围",

	["mob"] = "怪物",
	["Creatures"] = "怪物",
	["Creature combat log range."] = "怪物战斗记录范围",

	["death"] = "死亡",
	["Deaths"] = "死亡",
	["Death message range."] = "死亡信息范围",

	["reset"] = "重置",
	["Reset to defaults"] = "重置为默认设置",
	["Resets all ranges to defaults."] = "重置所有为默认设置",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

BigWigsRange = BigWigs:NewModule(L["Range"])
BigWigsRange.consoleCmd = L["range"]
BigWigsRange.consoleOptions = {
	type = "group",
	name = L["Range"],
	desc = L["Options for the combat log's range."],
	args   = {
		[L["party"]] = {
			type = "range",
			name = L["Party"],
			desc = L["Party combat log range."],
			order = 1,
			min = 5,
			max = 200,
			step = 5,
			get = function() return GetCVar("CombatLogRangeParty") end,
			set = function(v)
				SetCVar("CombatLogRangeParty", v)
				SetCVar("CombatLogRangePartyPet", v)
			end,
		},
		[L["friend"]] = {
			type = "range",
			name = L["Friendlies"],
			desc = L["Friendly players combat log range."],
			order = 2,
			min = 5,
			max = 200,
			step = 5,
			get = function() return GetCVar("CombatLogRangeFriendlyPlayers") end,
			set = function(v)
				SetCVar("CombatLogRangeFriendlyPlayers", v)
				SetCVar("CombatLogRangeFriendlyPlayersPets", v)
			end,
		},
		[L["hostile"]] = {
			type = "range",
			name = L["Hostiles"],
			desc = L["Hostile players combat log range."],
			order = 3,
			min = 5,
			max = 200,
			step = 5,
			get = function() return GetCVar("CombatLogRangeHostilePlayers") end,
			set = function(v)
				SetCVar("CombatLogRangeHostilePlayers", v)
				SetCVar("CombatLogRangeHostilePlayersPets", v)
			end,
		},
		[L["mob"]] = {
			type = "range",
			name = L["Creatures"],
			desc = L["Creature combat log range."],
			order = 4,
			min = 5,
			max = 200,
			step = 5,
			get = function() return GetCVar("CombatLogRangeCreature") end,
			set = function(v) SetCVar("CombatLogRangeCreature", v) end,
		},
		[L["death"]] = {
			type = "range",
			name = L["Deaths"],
			desc = L["Death message range."],
			order = 5,
			min = 5,
			max = 200,
			step = 5,
			get = function() return GetCVar("CombatDeathLogRange") end,
			set = function(v) SetCVar("CombatDeathLogRange", v) end,
		},
		[L["reset"]] = {
			type = "execute",
			name = L["Reset to defaults"],
			order = -1,
			desc = L["Resets all ranges to defaults."],
			func = function()
				SetCVar("CombatDeathLogRange", 200)
				SetCVar("CombatLogRangeParty", 200)
				SetCVar("CombatLogRangePartyPet", 200)
				SetCVar("CombatLogRangeFriendlyPlayers", 200)
				SetCVar("CombatLogRangeFriendlyPlayersPets", 200)
				SetCVar("CombatLogRangeHostilePlayers", 200)
				SetCVar("CombatLogRangeHostilePlayersPets", 200)
				SetCVar("CombatLogRangeCreature", 200)
			end,
		},
	},
}
