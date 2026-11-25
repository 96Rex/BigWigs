
----------------------------------
--      Module Declaration      --
----------------------------------
local module, L = BigWigs:ModuleDeclaration("Onyxia", "Onyxia's Lair")

module.revision = 20004 -- To be overridden by the module!
module.enabletrigger = module.translatedName -- string or table {boss, add1, add2}
module.toggleoptions = {"flamebreath", "deepbreath", "wingbuffet", "fireball", "phase", "onyfear", "bosskill"}
module.zonename = {
	AceLibrary("AceLocale-2.2"):new("BigWigs")["Onyxia's Lair"],
	AceLibrary("Babble-Zone-2.2")["Onyxia's Lair"],
}


----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Onyxia",
	engage_trigger = "must leave my lair to feed",

	deepbreath_cmd = "deepbreath",
	deepbreath_name = "Deep Breath",
	deepbreath_desc = "Warn when Onyxia begins to cast Deep Breath.",

	flamebreath_cmd = "flamebreath",
	flamebreath_name = "Flame Breath",
	flamebreath_desc = "Warn when Onyxia begins to cast Flame Breath.",

	wingbuffet_cmd = "wingbuffet",
	wingbuffet_name = "Wing Buffet",
	wingbuffet_desc = "Warn for Wing Buffet.",

	fireball_cmd = "fireball",
	fireball_name = "Fireball",
	fireball_desc = "Warn for Fireball.",

	phase_cmd = "phase",
	phase_name = "Phase",
	phase_desc = "Warn for Phase Change.",

	onyfear_cmd = "onyfear",
	onyfear_name = "Fear",
	onyfear_desc = "Warn for Bellowing Roar in phase 3.",

	deepbreath_trigger = "takes in a deep breath",
	flamebreath_trigger = "Onyxia begins to cast Flame Breath.",
	wingbuffet_trigger = "Onyxia begins to cast Wing Buffet.",
	fireball_trigger = "Onyxia begins to cast Fireball.",
	phase2_trigger = "from above",
	phase3_trigger = "It seems you'll need another lesson",
	fear_trigger = "Onyxia begins to cast Bellowing Roar.",
	fear_over_trigger = "Bellowing Roar",

	warn1 = "Deep Breath incoming!",
	phase1text = "Phase 1",
	phase2text = "Phase 2",
	phase3text = "Phase 3",
	feartext = "Fear soon!",
	fear_cast = "Fear",
	fear_next = "Next Fear",
	deepbreath_cast = "Deep Breath",
	flamebreath_cast = "Flame Breath",
	wingbuffet_cast = "Wing Buffet",
	fireball_cast = "Fireball on %s",
} end )

L:RegisterTranslations("zhCN", function() return {
    cmd = "奥妮克希亚",
    engage_trigger = "必须离开巢穴去觅食",

    deepbreath_cmd = "吐息",
    deepbreath_name = "吐息",
    deepbreath_desc = "4秒内每0.3秒造成1274点火焰伤害.",

    flamebreath_cmd = "火息术",
    flamebreath_name = "火息术",
    flamebreath_desc = "对施法者面前一个锥形区域中的敌人造成3063至3938点火焰伤害.",

    wingbuffet_cmd = "wingbuffet",
    wingbuffet_name = "龙翼攻击",
    wingbuffet_desc = "对施法者面前一个锥形区域中的敌人造成563至938点伤害,并击退它们.",

    fireball_cmd = "fireball",
    fireball_name = "火球术",
    fireball_desc = "对指定区域内的所有敌人造成801至1200点火焰伤害.",

    phase_cmd = "phase",
    phase_name = "阶段切换",
    phase_desc = "进入战斗为第一阶段,66%血量升空进入第二阶段,40%血量落地进入第三阶段.",

    onyfear_cmd = "onyfear",
    onyfear_name = "低沉咆哮",
    onyfear_desc = "使周围100码范围内的敌人因恐惧而逃跑.",

    deepbreath_trigger = "深吸了一口气",
    flamebreath_trigger = "奥妮克希亚开始施放火息术。",
    wingbuffet_trigger = "奥妮克希亚开始施放龙翼攻击。",
    fireball_trigger = "奥妮克希亚开始施放火球术。",
    phase2_trigger = "从上面把你们",
    phase3_trigger = "看来你们还需要再上一课",
    fear_trigger = "奥妮克希亚开始施放低沉咆哮。",
    fear_over_trigger = "低沉咆哮效果从(.+)身上消失。" ,

    warn1 = "奥妮克希亚5秒后吐息",
    phase1text = "第一阶段",
    phase2text = "第二阶段",
    phase3text = "第三阶段",
    feartext = "即将恐惧",
    fear_cast = "低沉咆哮",
    fear_next = "下一次低沉咆哮",
    deepbreath_cast = "吐息",
    flamebreath_cast = "火息术",
    wingbuffet_cast = "龙翼攻击",
	fireball_cast = "火球术(%s)",
} end )
local timer = {
	firstFear = 5,
	fear = 15,
	fearCast = 1.5,
	wingbuffet = 1,
}
local icon = {
	wingbuffet = "INV_Misc_MonsterScales_14",
	fear = "Spell_Shadow_Possession",
	deepbreath = "Spell_Fire_SelfDestruct",
	deepbreath_sign = "Spell_Fire_Lavaspawn",
	fireball = "Spell_Fire_FlameBolt",
}
local syncName = {
	deepbreath = "OnyDeepBreath"..module.revision,
	phase2 = "OnyPhaseTwo"..module.revision,
	phase3 = "OnyPhaseThree"..module.revision,
	flamebreath = "OnyFlameBreath"..module.revision,
	fireball = "OnyFireball"..module.revision,
	fear = "OnyBellowingRoar"..module.revision,
}

local transitioned = false
local phase = 0

local fireballTarget = nil
local iconNumber = 8

------------------------------
--      Initialization      --
------------------------------

module:RegisterYellEngage(L["engage_trigger"])

-- called after module is enabled
function module:OnEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
	self:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE")
	self:RegisterEvent("UNIT_HEALTH")
	self:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF")

	self:ThrottleSync(10, syncName.deepbreath)
	self:ThrottleSync(10, syncName.phase2)
	self:ThrottleSync(10, syncName.phase3)
	self:ThrottleSync(5, syncName.flamebreath)
	self:ThrottleSync(2, syncName.fireball)
	self:ThrottleSync(5, syncName.fear)
end

-- called after module is enabled and after each wipe
function module:OnSetup()
	transitioned = false
	self.started = false
	phase = 0
	fireballTarget = nil
	iconNumber = 8
end

-- called after boss is engaged
function module:OnEngage()
	if self.db.profile.phase and not self.started then
		self:Message(L["phase1text"], "Attention")
	end
	phase = 1
end

-- called after boss is disengaged (wipe(retreat) or victory)
function module:OnDisengage()
end

------------------------------
--      Event Handlers      --
------------------------------
--深呼吸
function module:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if string.find(msg, L["deepbreath_trigger"]) then
		self:Sync(syncName.deepbreath)
	end
end
--阶段切换
function module:CHAT_MSG_MONSTER_YELL(msg)
	if (string.find(msg, L["phase2_trigger"])) then
		self:Sync(syncName.phase2)
	elseif (string.find(msg, L["phase3_trigger"])) then
		self:Sync(syncName.phase3)
	end
end
--血量判断
function module:UNIT_HEALTH(arg1) --temporary workaround until Phase2 yell gets fixed
	if UnitName(arg1) == module.translatedName then
		local health = UnitHealth(arg1)
		if health > 60 and health <= 65 and not transitioned then
			self:Sync(syncName.phase2)
		elseif health > 65 then
			transitioned = false
		end
end
end
--BOSS4个技能判断
function module:CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE(msg)
	if msg == L["fear_trigger"] then
		self:Sync(syncName.fear)
	elseif msg == L["flamebreath_trigger"] then
		self:Sync(syncName.flamebreath)
	elseif msg == L["wingbuffet_trigger"] and self.db.profile.wingbuffet then -- made local because 1s cast, with sync it would not be very accurate
		self:Bar(L["wingbuffet_cast"], timer.wingbuffet, icon.wingbuffet, true, "yellow")
	elseif msg == L["fireball_trigger"] then
		self:Sync(syncName.fireball)
	end
end
--恐惧消失
function module:CHAT_MSG_SPELL_AURA_GONE_SELF(msg)
	if string.find(msg, L["fear_over_trigger"]) then
		self:RemoveWarningSign(icon.fear)
	end
end


------------------------------
--      Synchronization	    --
------------------------------

function module:BigWigs_RecvSync(sync, rest, nick)
	if sync == syncName.phase2 then
		self:Phase2()
	elseif sync == syncName.phase3 then
		self:Phase3()
	elseif sync == syncName.deepbreath then
		self:DeepBreath()
	elseif sync == syncName.flamebreath  then
		self:FlameBreath()
	elseif sync == syncName.fireball  then
		self:Fireball()
	elseif sync == syncName.fear  then
		self:Fear()
	end
end

------------------------------
--      Sync Handlers	    --
------------------------------

function module:Phase2()
	if phase < 2 then
		transitioned = true --to stop sending new syncs
		phase = 2
		if self.db.profile.phase then
			self:Message(L["phase2text"], "Important", false, "Alarm")
		end
	end
end

function module:Phase3()
	if self.db.profile.phase and phase < 3 then
		self:Message(L["phase3text"], "Important", true, "Beware")
		self:Bar(L["fear_next"], timer.firstFear + timer.fearCast, icon.fear, true, "blue")
		phase = 3
	end
end

function module:DeepBreath()
	if self.db.profile.deepbreath then
		self:Message(L["warn1"], "Important", true, "RunAway")
		self:Bar(L["deepbreath_cast"], 5, icon.deepbreath, true, "black")
		self:WarningSign(icon.deepbreath_sign, 5)
	end
end

function module:FlameBreath()
	if self.db.profile.flamebreath then
		self:Bar(L["flamebreath_cast"], 2, "Spell_Fire_Fire", true, "red")
	end
end

function module:DelayedFireballCheck()
	local name = "Unknown"
	self:CheckTarget()
	if fireballTarget then
		name = fireballTarget
		self:Icon(name, iconNumber)
		iconNumber = iconNumber - 1
		if iconNumber < 7 then
			iconNumber = 8
		end
		if name == UnitName("player") then
			self:WarningSign(icon.fireball, 3)
		end
	end
	if self.db.profile.fireball then
		self:Bar(string.format(L["fireball_cast"], name), 3 - 0.1, icon.fireball, true, "red")
	end
end

function module:Fireball()
	self:ScheduleEvent("OnyxiaDelayedFireballCheck", self.DelayedFireballCheck, 0.1, self)
end

function module:Fear()
	if self.db.profile.onyfear then
		self:RemoveBar(L["fear_next"]) -- remove timer bar

		self:Message(L["feartext"], "Important", true, "Alarm")
		self:Bar(L["fear_cast"], timer.fearCast, icon.fear, true, "white") -- add cast bar
		self:DelayedBar(timer.fearCast, L["fear_next"], timer.fear, icon.fear, true, "blue") -- delayed timer bar
		self:WarningSign(icon.fear, 5)
	end
end

-----------------------
-- Utility Functions --
-----------------------

function module:CheckTarget()
	local i
	local newtarget = nil
	local enemy = self:ToString()

	if UnitName("playertarget") == enemy then
		newtarget = UnitName("playertargettarget")
	else
		for i = 1, GetNumRaidMembers(), 1 do
			if UnitName("Raid"..i.."target") == enemy then
				newtarget = UnitName("Raid"..i.."targettarget")
				break
			end
		end
	end
	if newtarget then
		fireballTarget = newtarget
	end
end
