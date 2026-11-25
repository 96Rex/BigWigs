local module, L = BigWigs:ModuleDeclaration("Lord Blackwald II", "Karazhan")
local _,class = UnitClass("Player") 

module.revision = 30029
module.enabletrigger = module.translatedName
module.toggleoptions = { "boon", "empoweredsoul", "summon", "bosskill"}
module.zonename = {
	AceLibrary("AceLocale-2.2"):new("BigWigs")["Tower of Karazhan"],
	AceLibrary("Babble-Zone-2.2")["Tower of Karazhan"],
}

L:RegisterTranslations("enUS", function() return {
	cmd = "LordBlackwaldII",

	trigger_engage = "You dare disturb the Dark Rider Lord?",--CHAT_MSG_MONSTER_YELL

	boon_cmd = "boon",
	boon_name = "Blackwalds Boon Alert",
	boon_desc = "Warn for Blackwalds Boon",

	empoweredsoul_cmd = "empoweredsoul",
	empoweredsoul_name = "Empowered Soul Alert",
	empoweredsoul_desc = "Warns for Empowered Soul",

	summon_cmd = "summon",
	summon_name = "Summon Alert",
	summon_desc = "Warns for Summon",

	trigger_boonYou = "You are afflicted by Blackwalds Boon.",--CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE
	trigger_boonOther = "(.+) is afflicted by Blackwalds Boon.",--CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE // CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE
	trigger_boonFade = "Blackwalds Boon fades from (.+).",--CHAT_MSG_SPELL_AURA_GONE_SELF // CHAT_MSG_SPELL_AURA_GONE_PARTY // CHAT_MSG_SPELL_AURA_GONE_OTHER
	bar_boon = "Boon on ",

	trigger_empoweredSoulYou = "You are afflicted by Empowered Soul.",--CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE
	trigger_empoweredSoulOther = "(.+) is afflicted by Empowered Soul.",--CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE // CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE
	bar_empoweredSoul = " Empowered",

	trigger_yellSummon = "I call upon the Scythe of Elune, grant me your power!",--CHAT_MSG_MONSTER_YELL
	bar_summon = "Summons add",

	msg_yellSummon = "Shadowbane Ragefang Summoned!",
    you = "you",
} end )
L:RegisterTranslations("zhCN", function() return {
    cmd = "布莱克沃尔德勋爵二世",

    trigger_engage = "You dare disturb the Dark Rider Lord?",--CHAT_MSG_MONSTER_YELL

    boon_cmd = "布莱克沃尔德的恩赐",
    boon_name = "布莱克沃尔德的恩赐",
    boon_desc = "使敌人的属性降低20%.(诅咒,施法1.5秒,持续60分钟)",

    empoweredsoul_cmd = "赋予灵魂力量",
    empoweredsoul_name = "赋予灵魂力量",
    empoweredsoul_desc = "将敌方目标的攻击速度和体型提高25%,同时每2秒对其造成900点暗影伤害.(引导10秒)",

    summon_cmd = "召唤狼人",
    summon_name = "召唤狼人",
    summon_desc = "从影刺狼人中的一种随机召唤一只帮助自身战斗.",

    trigger_boonYou = "你受到了布莱克沃尔德的恩赐效果的影响",--CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE
    trigger_boonOther = "(.+)受到了布莱克沃尔德的恩赐效果的影响",--CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE // CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE
    trigger_boonFade = "布莱克沃尔德的恩赐效果从(.+)身上消失",--CHAT_MSG_SPELL_AURA_GONE_SELF // CHAT_MSG_SPELL_AURA_GONE_PARTY // CHAT_MSG_SPELL_AURA_GONE_OTHER
    bar_boon = "(四维降低)",

    trigger_empoweredSoulYou = "你受到了赋予灵魂力量效果的影响",--CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE
    trigger_empoweredSoulOther = "(.+)受到了赋予灵魂力量效果的影响",--CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE // CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE
    bar_empoweredSoul = "(攻速提高)",

    trigger_yellSummon = "I call upon the Scythe of Elune, grant me your power!",--CHAT_MSG_MONSTER_YELL
    bar_summon = "召唤狼人",

    msg_yellSummon = "影刺狼人已被召唤",
    you = "你",
} end )

local timer = {
	boon = 15,--timer TBD
	empoweredSoul = 10,
	firstSummon = 30,
	summon = 45,
}
local icon = {
	reaverstorm = "Ability_Whirlwind",
	boon = "Spell_Shadow_ChillTouch",
	empoweredSoul = "Spell_Shadow_Haunting",
	summon = "inv_misc_bone_orcskull_01",
}
local color = {
	reaverstormCd = "White",
	reaverstormCast = "Red",
	boon = "Blue",
	empoweredSoul = "Black",
	summon = "Cyan"
}
local syncName = {
	reaverstorm = "LordBlackwaldIIReaverstorm"..module.revision,
	boon = "LordBlackwaldIIBoon"..module.revision,
	boonFade = "LordBlackwaldIIBoonFade"..module.revision,
	empoweredSoul = "LordBlackwaldIIEmpoweredSoul"..module.revision,
	summon = "LordBlackwaldIISummon"..module.revision,
}

function module:OnEnable()
	--self:RegisterEvent("CHAT_MSG_SAY", "Event")--Debug
	
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", "Event")--trigger_boonYou, trigger_empoweredSoulYou
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", "Event")--trigger_boonOther, trigger_empoweredSoulOther
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", "Event")--trigger_boonOther, trigger_empoweredSoulOther
	self:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF", "Event")--trigger_boonFade
	self:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_PARTY", "Event")--trigger_boonFade
	self:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER", "Event")--trigger_boonFade
	
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")--trigger_yellSummon
	
	self:ThrottleSync(5, syncName.reaverstorm)
	self:ThrottleSync(5, syncName.boon)
	self:ThrottleSync(5, syncName.boonFade)
	self:ThrottleSync(5, syncName.empoweredSoul)
	self:ThrottleSync(5, syncName.summon)
end

function module:OnSetup()
	self.started = nil
end

function module:OnEngage()
	self:Bar(L["bar_summon"], timer.firstSummon, icon.summon, true, color.summon)
end

function module:OnDisengage()
end

function module:CHAT_MSG_MONSTER_YELL(msg, sender)
	if msg == L["trigger_engage"] then
		module:SendEngageSync()
	
	elseif msg == L["trigger_yellSummon"] then
		self:Sync(syncName.summon)
	end
end

function module:Event(msg)
	if msg == L["trigger_boonYou"] then
		self:Sync(syncName.boon .. " " .. UnitName("Player"))
	
	elseif string.find(msg, L["trigger_boonOther"]) then
		local _,_, boonPlayer, _ = string.find(msg, L["trigger_boonOther"])
		self:Sync(syncName.boon .. " " .. boonPlayer)
	
	elseif string.find(msg, L["trigger_boonFade"]) then
		local _,_, boonFadePlayer, _ = string.find(msg, L["trigger_boonFade"])
		if boonFadePlayer == L["you"] then boonFadePlayer = UnitName("Player") end
		self:Sync(syncName.boonFade .. " " .. boonFadePlayer)

	elseif msg == L["trigger_empoweredSoulYou"] then
		self:Sync(syncName.empoweredSoul .. " " .. UnitName("Player"))
		
	elseif string.find(msg, L["trigger_empoweredSoulOther"]) then
		local _,_, empoweredSoulPlayer, _ = string.find(msg, L["trigger_empoweredSoulOther"])
		self:Sync(syncName.empoweredSoul .. " " .. empoweredSoulPlayer)
	end
end

function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.reaverstorm and self.db.profile.reaverstorm then
		self:Reaverstorm()
	elseif sync == syncName.boon and rest and self.db.profile.boon then
		self:Boon(rest)
	elseif sync == syncName.boonFade and rest and self.db.profile.boon then
		self:BoonFade(rest)
	elseif sync == syncName.empoweredSoul and rest and self.db.profile.empoweredsoul then
		self:EmpoweredSoul(rest)
	elseif sync == syncName.summon and self.db.profile.summon then
		self:Summon()
	end
end

--布莱克沃尔德的恩赐
function module:Boon(rest)
	self:Bar(rest..L["bar_boon"], timer.boon, icon.boon, true, color.boon)
	self:SetCandyBarOnClick("BigWigsBar "..rest..L["bar_boon"], function(name, button, extra) TargetByName(extra, true) end, rest)
	if class == "MAGE" then
		self:WarningSign(icon.boon, 0.7)
	elseif class == "DRUID" then
		self:WarningSign(icon.boon, 0.7)
	end
end
--布莱克沃尔德的恩赐(消失)
function module:BoonFade(rest)
	self:RemoveBar(L["bar_boon"]..rest)
end
--赋予灵魂力量
function module:EmpoweredSoul(rest)
	for i=1,GetNumRaidMembers() do
		if UnitName("raid"..i) == rest then
			SetRaidTarget("raid"..i, 8)
		end
	end
	
	self:Bar(rest..L["bar_empoweredSoul"], timer.empoweredSoul, icon.empoweredSoul, true, color.empoweredSoul)
	self:SetCandyBarOnClick("BigWigsBar "..rest..L["bar_empoweredSoul"], function(name, button, extra) TargetByName(extra, true) end, rest)
end
--召唤狼人
function module:Summon()
	self:Message(L["msg_yellSummon"], "Urgent", false, nil, false)
	self:Bar(L["bar_summon"], timer.summon, icon.summon, true, color.summon)
end

function module:Test()
	BigWigs:ToggleActive(true)
	self:Engage()


	local events = {
		{ time = 5, func = function()
			print("Test: 布莱克沃尔德的恩赐(受到)")
			self:TriggerEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", "你受到了布莱克沃尔德的恩赐效果的影响")
			-- self:TriggerEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", "东海受到了布莱克沃尔德的恩赐效果的影响")
			-- self:TriggerEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", "东海受到了布莱克沃尔德的恩赐效果的影响")
		end },

		{ time = 10, func = function()
			print("Test: 布莱克沃尔德的恩赐(消失)")
			self:TriggerEvent("CHAT_MSG_SPELL_AURA_GONE_SELF", "布莱克沃尔德的恩赐效果从你身上消失")
			-- self:TriggerEvent("CHAT_MSG_SPELL_AURA_GONE_PARTY", "布莱克沃尔德的恩赐效果从东海身上消失")
			-- self:TriggerEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER", "布莱克沃尔德的恩赐效果从东海身上消失")
		end },
		{ time = 15, func = function()
			print("Test: 赋予灵魂力量")
			self:TriggerEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", "你受到了赋予灵魂力量效果的影响")
			-- self:TriggerEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", "东海受到了赋予灵魂力量效果的影响")
			-- self:TriggerEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", "东海受到了赋予灵魂力量效果的影响")
		end },
		{ time = 30, func = function()
			print("Test: 召唤狼人")
			self:TriggerEvent("CHAT_MSG_MONSTER_YELL", "I call upon the Scythe of Elune, grant me your power!")
		end },
		{ time = 75, func = function()
			print("Test: 召唤狼人")
			self:TriggerEvent("CHAT_MSG_MONSTER_YELL", "I call upon the Scythe of Elune, grant me your power!")
		end },

		{ time = 100, func = function()
			print("Test: 战斗结束")
			module:Disengage()
		end },
	}


	for i, event in ipairs(events) do
		self:ScheduleEvent("RexTest" .. i, event.func, event.time)
	end

	self:Message(module.translatedName .. " 模拟测试开始", "Positive")
end
-- /run BigWigs:GetModule("LordBlackwaldII"):Test()
-- /run BigWigs:GetModule("布莱克沃尔德勋爵二世"):Test()