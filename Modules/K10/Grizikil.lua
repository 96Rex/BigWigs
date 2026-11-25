local module, L = BigWigs:ModuleDeclaration("Grizikil", "Karazhan")

module.revision = 30024
module.enabletrigger = module.translatedName
module.toggleoptions = {"rainoffire", "flamewave", "bosskill"}
module.zonename = {
	AceLibrary("AceLocale-2.2"):new("BigWigs")["Tower of Karazhan"],
	AceLibrary("Babble-Zone-2.2")["Tower of Karazhan"],
}

L:RegisterTranslations("enUS", function() return {
	cmd = "Grizikil",

	rainoffire_cmd = "rainoffire",
	rainoffire_name = "Rain of Fire Alert",
	rainoffire_desc = "Warn for Rain of Fire",

	flamewave_cmd = "flamewave",
	flamewave_name = "Flamewave Alert",
	flamewave_desc = "Warn for Flamewave",

	trigger_rainOfFireYou = "You suffer (.+) Fire damage from Grizikil's Grellkin Rain of Fire.",--CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE
	msg_rainOfFireYou = "Get out of Rain of Fire!",

	trigger_flamewave = "Grizikil is afflicted by Flamewave.",--CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE
	trigger_flamewaveFade = "Flamewave fades from Grizikil.",--CHAT_MSG_SPELL_AURA_GONE_OTHER
	bar_flamewave = "Flamewave",
	msg_flamewave = "Flamewave, melee run out!",

	trigger_yellSmt = "You-you-you no defeat me, I am strong!",--CHAT_MSG_MONSTER_YELL

	trigger_engage = "Whats this? You're here for the orb?! ITS MINE, Grellkin, get them!",--CHAT_MSG_MONSTER_YELL

	msg_pullAll = "Pull --ALL-- imp packs before engaging Grizikil!",
} end )
L:RegisterTranslations("zhCN", function() return {
    cmd = "格里齐基尔",

    rainoffire_cmd = "劣魔火雨",
    rainoffire_name = "劣魔火雨",
    rainoffire_desc = "在20秒内对目标区域内的所有敌人造成3233点火焰伤害.",

    flamewave_cmd = "烈焰波",
    flamewave_name = "烈焰波",
    flamewave_desc = "点燃施法者周围的区域,对其造成200火焰伤害;每3秒对附近所有敌人造成1200火焰伤害,持续9 秒.",

    trigger_rainOfFireYou = "你受到(%d+)点火焰伤害（格里齐基尔的劣魔火雨）",--CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE
    msg_rainOfFireYou = "离开火焰之雨区域！",

    trigger_flamewave = "格里齐基尔获得了烈焰波的效果",--CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE
    trigger_flamewaveFade = "烈焰波效果从格里齐基尔身上消失",--CHAT_MSG_SPELL_AURA_GONE_OTHER
    bar_flamewave = "烈焰波",
    msg_flamewave = "近战远离",

    trigger_yellSmt = "You-you-you no defeat me, I am strong!",--CHAT_MSG_MONSTER_YELL

    trigger_engage = "Whats this? You're here for the orb?! ITS MINE, Grellkin, get them!",--CHAT_MSG_MONSTER_YELL

    msg_pullAll = "与格里兹基尔战斗前需要消灭所有小鬼",
} end )

local timer = {
	flamewave = 9,
}
local icon = {
	rainOfFire = "spell_shadow_rainoffire",
	flamewave = "spell_fire_incinerate",
}
local color = {
	flamewave = "Red"
}
local syncName = {
	flamewave = "GrizikilFlamewave"..module.revision,
	flamewaveFade = "GrizikilFlamewaveFade"..module.revision,
}

function module:OnEnable()
	self:Message(L["msg_pullAll"], "Urgent", false, nil, false)
	
	self:RegisterEvent("CHAT_MSG_SAY", "Event")--Debug
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", "Event")--trigger_rainOfFireYou
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE", "Event")--trigger_flamewave
	self:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER", "Event")--trigger_flamewaveFade
	
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")--trigger_engage
	
	self:ThrottleSync(5, syncName.flamewave)
	self:ThrottleSync(5, syncName.flamewaveFade)
end

function module:OnSetup()
	self.started = nil
end

function module:OnEngage()
end

function module:OnDisengage()
end

function module:CHAT_MSG_MONSTER_YELL(msg, sender)
	if msg == L["trigger_engage"] then
		module:SendEngageSync()
	end
end

function module:Event(msg)
	if string.find(msg, L["trigger_rainOfFireYou"]) then
		self:WarningSign(icon.rainOfFire, 0.7)
		self:Message(L["msg_rainOfFireYou"], "Important", false, nil, false)
		self:Sound("Info")
	
	elseif msg == L["trigger_flamewave"] then
		self:Sync(syncName.flamewave)
	
	elseif msg == L["trigger_flamewaveFade"] then
		self:Sync(syncName.flamewaveFade)
	
	end
end

function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.flamewave and self.db.profile.flamewave then
		self:Flamewave()
	elseif sync == syncName.flamewaveFade and self.db.profile.flamewave then
		self:FlamewaveFade()
	end
end

function module:Flamewave()
	self:Bar(L["bar_flamewave"], timer.flamewave, icon.flamewave, true, color.flamewave)
	self:Message(L["msg_flamewave"], "Urgent", false, nil, false)
	self:WarningSign(icon.flamewave, 1)
	self:Sound("Beware")
end

function module:FlamewaveFade()
	self:RemoveBar(L["bar_flamewave"])
end

function module:Test()
	BigWigs:ToggleActive(true)
	self:Engage()
	local events = {
		{ time = 1, func = function()
			print("Test: 战斗开始")
			self:TriggerEvent("CHAT_MSG_MONSTER_YELL", "Whats this? You're here for the orb?! ITS MINE, Grellkin, get them!")
		end },
		{ time = 1, func = function()
			print("Test: 火焰之雨")
			self:TriggerEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", "你受到500点火焰伤害（格里齐基尔的劣魔火雨）")
		end },
		{ time = 5, func = function()
			print("Test: 烈焰波")
			self:TriggerEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE", "格里齐基尔获得了烈焰波的效果")
		end },
		{ time = 8, func = function()
			print("Test: 烈焰波(结束)")
			self:TriggerEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER", "烈焰波效果从格里齐基尔身上消失")
		end },
		{ time = 10, func = function()
			print("Test: 战斗结束")
			module:Disengage()
		end },
	}
	for i, event in ipairs(events) do
		self:ScheduleEvent("RexTest" .. i, event.func, event.time)
	end

	self:Message(module.translatedName .. " 模拟测试开始", "Positive")
end
-- /run BigWigs:GetModule("Grizikil"):Test()
-- /run BigWigs:GetModule("格里齐基尔"):Test()