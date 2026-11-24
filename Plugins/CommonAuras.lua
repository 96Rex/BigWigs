local name = "Common Auras"
local L = AceLibrary("AceLocale-2.2"):new("BigWigs" .. name)
local BS = AceLibrary("Babble-Spell-2.2")

local has_superwow = SUPERWOW_STRING or SetAutoloot
local _, class = UnitClass("player")

L:RegisterTranslations("enUS", function()
	return {
		iconPrefix = "Interface\\Icons\\",

		msg_fearward = " Gain FearWard",
		bar_fearward = " FearWard CD",

		msg_shieldwall = " Shield Wall",
		bar_shieldwall = " Shield Wall",

		msg_laststand = " Last Stand",
		bar_laststand = " Last Stand",

		msg_lifegivingGem = " Lifegiving Gem",
		bar_lifegivingGem = " Lifegiving Gem",

		msg_challengingShout = " Challenging Shout",
		bar_challengingShout = " Challenging Shout",

		msg_challengingRoar = " Challenging Roar",
		bar_challengingRoar = " Challenging Roar",

		msg_spiritLink = "Spirit Link on ",
		bar_spiritLink = " Spirit Link",

		msg_divineIntervention = "Divine Intervention on ",
		bar_divineIntervention = " Divine Intervention",

		trigger_orange = "begins to conjure a refreshment table.",
		bar_orange = "Oranges!",
		msg_orange = "Oranges! Get your Vitamin C",

		trigger_soulwell = "begins a Soulwell ritual.",
		bar_soulwell = "Soulwell!",
		msg_soulwell = "Soulwell! Get your Cookie",

		["Toggle %s display."] = true,
		["Spells"] = "Important spells",
		["SpellsDesc"] = "Notification bars during important spells",
		["Orange"] = true,
		["Soulwell"] = true,

		["Gives timer bars and raid messages about common buffs and debuffs."] = true,
		["Common Auras"] = true,
		["commonauras"] = true,

	}
end)
L:RegisterTranslations("zhCN", function()
	return {
		iconPrefix = "Interface\\Icons\\",

		msg_fearward = " 获得 反恐结界",
		bar_fearward = "反恐结界冷却",

		msg_shieldwall = " 开启 盾墙",
		bar_shieldwall = "(盾墙)",

		msg_laststand = " 使用 破釜沉舟",
		bar_laststand = "(破釜沉舟)",

		msg_lifegivingGem = " 使用 生命宝石",
		bar_lifegivingGem = "(生命宝石)",

		msg_challengingShout = " 施放 群嘲",
		bar_challengingShout = "(挑战怒吼)",

		msg_challengingRoar = " 施放 群嘲",
		bar_challengingRoar = "(挑战咆哮)",

		msg_spiritLink = " 获得 灵魂链接",
		bar_spiritLink = "(灵魂链接)",

		msg_divineIntervention = " 获得 神圣干涉",
		bar_divineIntervention = "(神圣干涉)",

		trigger_orange = "begins to conjure a refreshment table.",
		bar_orange = "餐桌",
		msg_orange = "餐桌 已开放",

		trigger_soulwell = "begins a Soulwell ritual.",
		bar_soulwell = "灵魂之井",
		msg_soulwell = "灵魂之井 已开放",

		["Toggle %s display."] = "%s",
		["Spells"] = "重要法术",
		["SpellsDesc"] = "重要法术的计时条",
		["Orange"] = "餐桌(法师橘子)",
		["Soulwell"] = "灵魂之井(术士马桶)",

		["Gives timer bars and raid messages about common buffs and debuffs."] = "为普通的增/减益提供团队消息和计时条.",
		["Common Auras"] = "光环提醒",
		["commonauras"] = "光环提醒",

	}
end)

BigWigsCommonAuras = BigWigs:NewModule(name, "AceHook-2.1")
BigWigsCommonAuras.synctoken = name
BigWigsCommonAuras.defaultDB = {
	fearward = true,
	shieldwall = true,
	laststand = true,
	lifegivinggem = true,
	challengingshout = true,
	challengingroar = true,
	spiritlink = true,
	di = true,
	orange = true,
	soulwell = true,
}
BigWigsCommonAuras.consoleCmd = L["commonauras"]
BigWigsCommonAuras.revision = 30066
BigWigsCommonAuras.external = true
BigWigsCommonAuras.consoleOptions = {
	type = "group",
	name = L["Common Auras"],
	desc = L["Gives timer bars and raid messages about common buffs and debuffs."],
	args = {
		["orange"] = {
			type = "toggle",
			name = L["Orange"],
			desc = string.format(L["Toggle %s display."], L["Orange"]),
			get = function()
				return BigWigsCommonAuras.db.profile.orange
			end,
			set = function(v)
				BigWigsCommonAuras.db.profile.orange = v
			end,
		},
		["soulwell"] = {
			type = "toggle",
			name = L["Soulwell"],
			desc = string.format(L["Toggle %s display."], L["Soulwell"]),
			get = function()
				return BigWigsCommonAuras.db.profile.soulwell
			end,
			set = function(v)
				BigWigsCommonAuras.db.profile.soulwell = v
			end,
		},
		["spells"] = {
			type = "group",
			name = L["Spells"],
			desc = L["SpellsDesc"],
			order = 6,
			args = {
				["challengingshout"] = {
					type = "toggle",
					name = BS["Challenging Shout"],
					desc = string.format(L["Toggle %s display."], BS["Challenging Shout"]),
					get = function()
						return BigWigsCommonAuras.db.profile.challengingshout
					end,
					set = function(v)
						BigWigsCommonAuras.db.profile.challengingshout = v
					end,
				},
				["challengingroar"] = {
					type = "toggle",
					name = BS["Challenging Roar"],
					desc = string.format(L["Toggle %s display."], BS["Challenging Roar"]),
					get = function()
						return BigWigsCommonAuras.db.profile.challengingroar
					end,
					set = function(v)
						BigWigsCommonAuras.db.profile.challengingroar = v
					end,
				},
				["spiritlink"] = {
					type = "toggle",
					name = BS["Spirit Link"],
					desc = string.format(L["Toggle %s display."], BS["Spirit Link"]),
					get = function()
						return BigWigsCommonAuras.db.profile.spiritlink
					end,
					set = function(v)
						BigWigsCommonAuras.db.profile.spiritlink = v
					end,
				},
				["di"] = {
					type = "toggle",
					name = BS["Divine Intervention"],
					desc = string.format(L["Toggle %s display."], BS["Divine Intervention"]),
					get = function()
						return BigWigsCommonAuras.db.profile.di
					end,
					set = function(v)
						BigWigsCommonAuras.db.profile.di = v
					end,
				},
				["fearward"] = {
					type = "toggle",
					name = BS["Fear Ward"],
					desc = string.format(L["Toggle %s display."], BS["Fear Ward"]),
					get = function()
						return BigWigsCommonAuras.db.profile.fearward
					end,
					set = function(v)
						BigWigsCommonAuras.db.profile.fearward = v
					end,
				},
				["laststand"] = {
					type = "toggle",
					name = BS["Last Stand"],
					desc = string.format(L["Toggle %s display."], BS["Last Stand"]),
					get = function()
						return BigWigsCommonAuras.db.profile.laststand
					end,
					set = function(v)
						BigWigsCommonAuras.db.profile.laststand = v
					end,
				},
				["lifegivinggem"] = {
					type = "toggle",
					name = BS["Lifegiving Gem"],
					desc = string.format(L["Toggle %s display."], BS["Lifegiving Gem"]),
					get = function()
						return BigWigsCommonAuras.db.profile.lifegivinggem
					end,
					set = function(v)
						BigWigsCommonAuras.db.profile.lifegivinggem = v
					end,
				},
				["shieldwall"] = {
					type = "toggle",
					name = BS["Shield Wall"],
					desc = string.format(L["Toggle %s display."], BS["Shield Wall"]),
					get = function()
						return BigWigsCommonAuras.db.profile.shieldwall
					end,
					set = function(v)
						BigWigsCommonAuras.db.profile.shieldwall = v
					end,
				},
			}
		}
	}
}

local timer = {
	fearward = 30,
	laststand = 20,
	lifegivingGem = 20,
	challenging = 6,
	spiritLink = 20,
	di = 180,
	orange = 60,
	soulwell = 60,
}
local icon = {
	fearward = L["iconPrefix"] .. "spell_holy_excorcism",
	shieldwall = L["iconPrefix"] .. "ability_warrior_shieldwall",
	laststand = L["iconPrefix"] .. "spell_holy_ashestoashes",
	lifegivingGem = L["iconPrefix"] .. "inv_misc_gem_pearl_05",
	challengingShout = L["iconPrefix"] .. "ability_bullrush",
	challengingRoar = L["iconPrefix"] .. "ability_druid_challangingroar",
	spiritLink = L["iconPrefix"] .. "spell_shaman_spiritlink",
	di = L["iconPrefix"] .. "spell_nature_timestop",
	orange = L["iconPrefix"] .. "inv_misc_food_41",
	soulwell = L["iconPrefix"] .. "inv_stone_04",
}
local color = {
	fearward = "Cyan",
	shieldwall = "Red",
	laststand = "Red",
	lifegivingGem = "Red",
	challengingShout = "Red",
	challengingRoar = "Red",
	spiritLink = "Cyan",
	di = "Blue",
	orange = "Green",
	soulwell = "Green",
}

function BigWigsCommonAuras:OnEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS")

	if class == "WARRIOR" or class == "DRUID" or class == "PRIEST" or class == "SHAMAN" then
		if has_superwow then
			self:RegisterEvent("UNIT_CASTEVENT")
		else
			self:RegisterEvent("SpellStatusV2_SpellCastInstant")
		end
	end

	local throttle_delta = 0.4
	self:RegisterEvent("BigWigs_RecvSync")
	self:TriggerEvent("BigWigs_ThrottleSync", "BWCAFW", throttle_delta) -- Fear Ward
	self:TriggerEvent("BigWigs_ThrottleSync", "BWCASW", throttle_delta) -- Shield Wall
	self:TriggerEvent("BigWigs_ThrottleSync", "BWCALS", throttle_delta) -- Last Stand
	self:TriggerEvent("BigWigs_ThrottleSync", "BWCALG", throttle_delta) -- Lifegiving Gem
	self:TriggerEvent("BigWigs_ThrottleSync", "BWCACS", throttle_delta) -- Challenging Shout
	self:TriggerEvent("BigWigs_ThrottleSync", "BWCACR", throttle_delta) -- Challenging Roar
	self:TriggerEvent("BigWigs_ThrottleSync", "BWCASL", throttle_delta) -- Spirit Link
	self:TriggerEvent("BigWigs_ThrottleSync", "BWCAOR", throttle_delta) -- Orange
	self:TriggerEvent("BigWigs_ThrottleSync", "BWCAWL", throttle_delta) -- Soulwell
end

function BigWigsCommonAuras:UNIT_CASTEVENT(caster, target, action, spell_id, cast_time)
	if not (action == "CAST" and UnitIsUnit(caster, "player")) then return end
	local name, rank = SpellInfo(spell_id)
	local fullname = rank == "" and name or format("%s(%s)", name, rank)
	self:SpellStatusV2_SpellCastInstant(spell_id, name, rank, fullname, cast_time, nil, nil, nil, target and UnitName(target))
end

function BigWigsCommonAuras:SpellStatusV2_SpellCastInstant(sId, sName, sRank, sFullName, sCastTime, sStopTime, sDuration, sDelay, target)
	local targetName = target
	if sName == BS["Fear Ward"] then
		if not targetName then
			if UnitExists("target") and UnitIsPlayer("target") and not UnitIsEnemy("target", "player") then
				targetName = UnitName("target")
			else
				targetName = UnitName("player")
			end
		end
		self:TriggerEvent("BigWigs_SendSync", "BWCAFW " .. targetName)
	elseif sName == BS["Shield Wall"] then
		local shieldWallDuration
		local talentName, _, _, _, currentRank, _, _, _ = GetTalentInfo(3, 13)
		if currentRank == 0 then
			shieldWallDuration = 10
		elseif currentRank == 1 then
			shieldWallDuration = 13
		else
			shieldWallDuration = 15
		end
		self:TriggerEvent("BigWigs_SendSync", "BWCASW " .. tostring(shieldWallDuration))
	elseif sName == BS["Last Stand"] then
		self:TriggerEvent("BigWigs_SendSync", "BWCALS")
	elseif sName == BS["Challenging Shout"] then
		self:TriggerEvent("BigWigs_SendSync", "BWCACS")
	elseif sName == BS["Challenging Roar"] then
		self:TriggerEvent("BigWigs_SendSync", "BWCACR")
	elseif sName == BS["Spirit Link"] then
		if not targetName then
			if UnitExists("target") and UnitIsPlayer("target") and not UnitIsEnemy("target", "player") then
				targetName = UnitName("target")
			else
				targetName = UnitName("player")
			end
		end
		self:TriggerEvent("BigWigs_SendSync", "BWCASL " .. targetName)
	end
end

function BigWigsCommonAuras:CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS(msg)
	if string.find(msg, BS["Gift of Life"]) then
		self:TriggerEvent("BigWigs_SendSync", "BWCALG")
	elseif string.find(msg, BS["Divine Intervention"]) then
		self:TriggerEvent("BigWigs_SendSync", "BWCADI")
	end
end

function BigWigsCommonAuras:CHAT_MSG_MONSTER_EMOTE(msg, sender)
	if string.find(msg, L["trigger_orange"]) then
		local zone = nil
		if GetNumRaidMembers() > 0 then
			for i = 1, GetNumRaidMembers() do
				if UnitName("raid" .. i) == sender then
					zone = GetRealZoneText()
					break
				end
			end
		elseif GetNumPartyMembers() > 0 then
			for i = 1, GetNumPartyMembers() do
				if UnitName("party" .. i) == sender then
					zone = GetRealZoneText()
					break
				end
			end
		elseif sender == UnitName("player") then
			zone = GetRealZoneText()
		end

		if zone ~= nil then
			self:TriggerEvent("BigWigs_SendSync", "BWCAOR " .. zone)
		end

	elseif string.find(msg, L["trigger_soulwell"]) then
		self:TriggerEvent("BigWigs_SendSync", "BWCAWL")
	end
end

function BigWigsCommonAuras:BigWigs_RecvSync(sync, rest, nick)
	if not nick then
		nick = UnitName("player")
	end
	if self.db.profile.fearward and sync == "BWCAFW" and rest then
		self:TriggerEvent("BigWigs_Message", rest .. L["msg_fearward"] .. "(" .. nick .. ")", "Positive", false, nil, false)
		self:TriggerEvent("BigWigs_StartBar", self, L["bar_fearward"].. "(" ..nick .. ")", timer.fearward, icon.fearward, true, color.fearward)
elseif self.db.profile.shieldwall and sync == "BWCASW" then
		local swTime = tonumber(rest)
		if not swTime then
			swTime = 10
		end
		self:TriggerEvent("BigWigs_Message", nick .. L["msg_shieldwall"], "Urgent", false, nil, false)
		self:TriggerEvent("BigWigs_StartBar", self, nick .. L["bar_shieldwall"], swTime, icon.shieldwall, true, color.shieldwall)
		self:SetCandyBarOnClick("BigWigsBar " .. nick .. L["bar_shieldwall"], function(name, button, extra)
			TargetByName(extra, true)
		end, nick)

	elseif self.db.profile.laststand and sync == "BWCALS" then
		self:TriggerEvent("BigWigs_Message", nick .. L["msg_laststand"], "Urgent", false, nil, false)
		self:TriggerEvent("BigWigs_StartBar", self, nick .. L["bar_laststand"], timer.laststand, icon.laststand, true, color.laststand)
		self:SetCandyBarOnClick("BigWigsBar " .. nick .. L["bar_laststand"], function(name, button, extra)
			TargetByName(extra, true)
		end, nick)

	elseif self.db.profile.lifegivinggem and sync == "BWCALG" then
		self:TriggerEvent("BigWigs_Message", nick .. L["msg_lifegivingGem"], "Urgent", false, nil, false)
		self:TriggerEvent("BigWigs_StartBar", self, nick .. L["bar_lifegivingGem"], timer.lifegivingGem, icon.lifegivingGem, true, color.lifegivingGem)
		self:SetCandyBarOnClick("BigWigsBar " .. nick .. L["bar_lifegivingGem"], function(name, button, extra)
			TargetByName(extra, true)
		end, nick)

	elseif self.db.profile.challengingshout and sync == "BWCACS" then
		self:TriggerEvent("BigWigs_Message", nick .. L["msg_challengingShout"], "Urgent", false, nil, false)
		self:TriggerEvent("BigWigs_StartBar", self, nick .. L["bar_challengingShout"], timer.challenging, icon.challengingShout, true, color.challengingShout)
		self:SetCandyBarOnClick("BigWigsBar " .. nick .. L["bar_challengingShout"], function(name, button, extra)
			TargetByName(extra, true)
		end, nick)

	elseif self.db.profile.challengingroar and sync == "BWCACR" then
		self:TriggerEvent("BigWigs_Message", nick .. L["msg_challengingRoar"], "Urgent", false, nil, false)
		self:TriggerEvent("BigWigs_StartBar", self, nick .. L["bar_challengingRoar"], timer.challenging, icon.challengingRoar, true, color.challengingRoar)
		self:SetCandyBarOnClick("BigWigsBar " .. nick .. L["bar_challengingRoar"], function(name, button, extra)
			TargetByName(extra, true)
		end, nick)

	elseif self.db.profile.spiritlink and sync == "BWCASL" and rest then
		self:TriggerEvent("BigWigs_Sound", "Info")
		self:TriggerEvent("BigWigs_Message", rest .. L["msg_spiritLink"] .. "(" .. nick .. ")", "Positive", false, nil, false)
		self:TriggerEvent("BigWigs_StartBar", self, rest..L["bar_spiritLink"], timer.spiritLink, icon.spiritLink, true, color.spiritLink)
		self:SetCandyBarOnClick("BigWigsBar " .. rest .. L["bar_spiritLink"], function(name, button, extra)
			TargetByName(extra, true)
		end, rest)

	elseif self.db.profile.di and sync == "BWCADI" then
		self:TriggerEvent("BigWigs_Message", rest..L["msg_divineIntervention"] .. "(" .. nick .. ")", "Positive", false, nil, false)
		self:TriggerEvent("BigWigs_StartBar", self, rest .. L["bar_divineIntervention"], timer.di, icon.di, true, color.di)
		self:SetCandyBarOnClick("BigWigsBar " .. rest .. L["bar_divineIntervention"], function(name, button, extra)
			TargetByName(extra, true)
		end, rest)

	elseif self.db.profile.orange and sync == "BWCAOR" then
		if rest and rest == GetRealZoneText() then
			self:TriggerEvent("BigWigs_Message", L["msg_orange"], "Positive", false, nil, false)
			self:TriggerEvent("BigWigs_StartBar", self, L["bar_orange"], timer.orange, icon.orange, true, color.orange)
			self:TriggerEvent("BigWigs_Sound", "Info")
			self:TriggerEvent("BigWigs_ShowWarningSign", icon.orange, 5)
		end

	elseif self.db.profile.soulwell and sync == "BWCAWL" then
		self:TriggerEvent("BigWigs_Message", L["msg_soulwell"], "Positive", false, nil, false)
		self:TriggerEvent("BigWigs_StartBar", self, L["bar_soulwell"], timer.soulwell, icon.soulwell, true, color.soulwell)
		self:TriggerEvent("BigWigs_Sound", "Info")
		self:TriggerEvent("BigWigs_ShowWarningSign", icon.soulwell, 5)
	end
end

SLASH_SLTEST1 = "/sltest"
SlashCmdList["SLTEST"] = function()
    local M = BigWigsCommonAuras
    if not M or not M.db or not M.db.profile then
        DEFAULT_CHAT_FRAME:AddMessage("|cffff0000[SLTest] 模块未启用|r")
        return
    end
    M.db.profile.spiritlink = true
    -- 模拟：萨满玩家 对你施放了灵魂链接BWCAFW BWCASL
    M:BigWigs_RecvSync("BWCAFW", UnitName("player"), "牧师")
    M:BigWigs_RecvSync("BWCASL", UnitName("player"), "萨满")
    M:BigWigs_RecvSync("BWCALS", UnitName("player"), UnitName("player"))
    M:BigWigs_RecvSync("BWCACS", UnitName("player"), UnitName("player"))
    M:BigWigs_RecvSync("BWCACR", UnitName("player"), UnitName("player"))
    M:BigWigs_RecvSync("BWCADI", UnitName("player"), "骑士")
end