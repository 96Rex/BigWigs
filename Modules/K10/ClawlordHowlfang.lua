local module, L = BigWigs:ModuleDeclaration("Clawlord Howlfang", "Karazhan")
local _,class = UnitClass("Player")

module.revision = 30037
module.enabletrigger = module.translatedName
module.toggleoptions = {"terrifyingpresence", "curse", "enrage", "bosskill"}
module.zonename = {
	AceLibrary("AceLocale-2.2"):new("BigWigs")["Tower of Karazhan"],
	AceLibrary("Babble-Zone-2.2")["Tower of Karazhan"],
}

L:RegisterTranslations("enUS", function() return {
	cmd = "ClawlordHowlfang",

	terrifyingpresence_cmd = "terrifyingpresence",
	terrifyingpresence_name = "Terrifying Presence Alert",
	terrifyingpresence_desc = "Warn for Terrifying Presence",

	curse_cmd = "curse",
	curse_name = "Curse Alert",
	curse_desc = "Warn for Curse",

	enrage_cmd = "enrage",
	enrage_name = "Enrage Alert",
	enrage_desc = "Warns for Enrage",

	trigger_engage = "So it was you I smelled! Such a foul taint.",--CHAT_MSG_MONSTER_YELL

	trigger_terrifyingPresenceSelf = "You are afflicted by Terrifying Presence %((.+)%).",--CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE
	trigger_terrifyingPresence = "(.+) is afflicted by Terrifying Presence %((.+)%).",--CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE // CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE
	bar_terrifyingPresence = "% reduced",

	trigger_curse = "afflicted by Shadowbane Curse.",--CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE // CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE // CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE
	bar_curse = "Shadowbane Curse",
	msg_curse = "Shadowbane Curse, Decurse!",

	trigger_yellEnrage = "My pack shall tear you apart, bone by bone!",--CHAT_MSG_MONSTER_YELL
	msg_enrage = "Enrage!",

	name_clawlordhowlfang = "Clawlord Howlfang",
} end )


L:RegisterTranslations("zhCN", function() return {
    cmd = "爪王嚎牙",

    terrifyingpresence_cmd = "恐怖之力",
    terrifyingpresence_name = "恐怖之力",
    terrifyingpresence_desc = "使附近敌人的护甲和伤害降低5%.最多可叠加50次.",

    curse_cmd = "魔剑诅咒",
    curse_name = "魔剑诅咒",
    curse_desc = "减少附近敌人的治疗效果50%,持续10分钟.",
    
    enrage_cmd = "激怒",
    enrage_name = "激怒",
    enrage_desc = "爪王嚎牙在生命30%时会进入激怒状态.",
    
    trigger_engage = "So it was you I smelled! Such a foul taint.",--CHAT_MSG_MONSTER_YELL

    trigger_terrifyingPresenceSelf = "你受到了恐怖之力效果的影响（(%d+)）",--CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE
    trigger_terrifyingPresence = "(.+)受到了恐怖之力效果的影响（(%d+)）",--CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE // CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE
    bar_terrifyingPresence = "(护甲降低%d%%)",
    
    trigger_curse = "受到了魔剑诅咒效果的影响",--CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE // CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE // CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE
	msg_curse = "魔剑诅咒",
    
    trigger_yellEnrage = "My pack shall tear you apart, bone by bone!",--CHAT_MSG_MONSTER_YELL
    msg_enrage = "爪王嚎牙已激怒",

	name_clawlordhowlfang = "爪王嚎牙",
} end )

local timer = {
	terrifyingPresence = 10,
}
local icon = {
	terrifyingPresence = "Spell_Shadow_VampiricAura",
	curse = "Spell_Shadow_GatherShadows",
	enrage = "Spell_Shadow_UnholyFrenzy",
}
local color = {
	terrifyingPresence = "White",
	curse = "Black",
}
local syncName = {
	terrifyingPresence2 = "ClawlordHowlfangTerrifyingPresence2"..module.revision,
	curse = "ClawlordHowlfangCurse"..module.revision,
	enrage = "ClawlordHowlfangEnrage"..module.revision,
}

function module:OnEnable()
	--self:RegisterEvent("CHAT_MSG_SAY", "Event")--Debug
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", "Event")--trigger_terrifyingPresenceSelf, trigger_curse
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", "Event")--trigger_terrifyingPresence, trigger_curse
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", "Event")--trigger_terrifyingPresence, trigger_curse

	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")--trigger_engage, trigger_yellEnrage
	
	self:ThrottleSync(0.5, syncName.terrifyingPresence2)
	self:ThrottleSync(10, syncName.curse)
	self:ThrottleSync(10, syncName.enrage)
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
		
	elseif string.find(msg, L["trigger_yellEnrage"]) then
		self:Sync(syncName.enrage)
	end
end

function module:Event(msg)
	if string.find(msg, L["trigger_terrifyingPresenceSelf"]) then
		local _,_, tpQty, _ = string.find(msg, L["trigger_terrifyingPresenceSelf"])
		-- if UnitName("target") ~= nil and UnitName("targettarget") ~= nil then
			-- if UnitName("target") == L["name_clawlordhowlfang"] and UnitName("targettarget") == UnitName("Player") then
				-- local tpPlayerAndQty = UnitName("Player") .. " " .. tpQty
				-- self:Sync(syncName.terrifyingPresence2 .. " " .. tpPlayerAndQty)
			-- end
		-- end
		local tpPlayerAndQty = UnitName("Player") .. " " .. tpQty
		self:Sync(syncName.terrifyingPresence2 .. " " .. tpPlayerAndQty)
	elseif string.find(msg, L["trigger_curse"]) then
		self:Sync(syncName.curse)
	end
end


function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.terrifyingPresence2 and rest and self.db.profile.terrifyingpresence then
		self:TerrifyingPresence(rest)
	elseif sync == syncName.curse and self.db.profile.curse then
		self:Curse()
	elseif sync == syncName.enrage and self.db.profile.enrage then
		self:Enrage()
	end
end

--恐怖之力
function module:TerrifyingPresence(rest)
	local tpPlayer = strsub(rest,0,strfind(rest," ") - 1)

	local tpQty = tonumber(strsub(rest,strfind(rest," "),strlen(rest)))

	local currentReduction = tpQty * 5
	
	for i = 5, 245, 5 do
		self:RemoveBar(tpPlayer..string.format(L["bar_terrifyingPresence"],i))
	end
	
self:Bar(tpPlayer..string.format(L["bar_terrifyingPresence"],currentReduction), timer.terrifyingPresence, icon.terrifyingPresence, true, color.terrifyingPresence)
end
--魔剑诅咒
function module:Curse()
	self:Message(L["msg_curse"], "Urgent", false, nil, false)
	if class == "MAGE" then
		self:WarningSign(icon.curse, 0.7)
	elseif class == "DRUID" then
		self:WarningSign(icon.curse, 0.7)
	end
end
--激怒
function module:Enrage()
	self:Message(L["msg_enrage"], "Attention", false, nil, false)
	self:WarningSign(icon.enrage, 0.7)
end

function module:Test()
	BigWigs:ToggleActive(true)
	self:Engage()
	local events = {
		{ time = 1, func = function()
			print("Test: 战斗开始")
			self:TriggerEvent("CHAT_MSG_MONSTER_YELL", "So it was you I smelled! Such a foul taint.")
		end },
		--恐怖之力需要检测目标和目标的目标 需要手动去注释发送端
		{ time = 1, func = function()
			print("Test: 恐怖之力(受到)")
			self:TriggerEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", "你受到了恐怖之力效果的影响（1）")
			self:TriggerEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", "东海受到了恐怖之力效果的影响（1）")
		end },
		{ time = 2, func = function()
			print("Test: 恐怖之力(受到)")
			self:TriggerEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", "你受到了恐怖之力效果的影响（2）")
			self:TriggerEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", "东海受到了恐怖之力效果的影响（2）")
		end },
		{ time = 3, func = function()
			print("Test: 恐怖之力(受到)")
			self:TriggerEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", "你受到了恐怖之力效果的影响（3）")
			self:TriggerEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", "东海受到了恐怖之力效果的影响（3）")
		end },
		{ time = 4, func = function()
			print("Test: 恐怖之力(受到)")
			self:TriggerEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", "你受到了恐怖之力效果的影响（4）")
			self:TriggerEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", "东海受到了恐怖之力效果的影响（4）")
		end },
		{ time = 8, func = function()
			print("Test: 魔剑诅咒(受到)")
			self:TriggerEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", "你受到了魔剑诅咒效果的影响")
		end },
		{ time = 8, func = function()
			print("Test: 激怒")
			self:TriggerEvent("CHAT_MSG_MONSTER_YELL", "My pack shall tear you apart, bone by bone!")
		end },
		{ time = 15, func = function()
			print("Test: 战斗结束")
			module:Disengage()
		end },
	}
	for i, event in ipairs(events) do
		self:ScheduleEvent("RexTest" .. i, event.func, event.time)
	end

	self:Message(module.translatedName .. " 模拟测试开始", "Positive")
end
-- /run BigWigs:GetModule("Clawlord Howlfang"):Test()
-- /run BigWigs:GetModule("爪王嚎牙"):Test()
