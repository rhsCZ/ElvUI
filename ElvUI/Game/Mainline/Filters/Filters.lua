local E, L, V, P, G = unpack(ElvUI)

local List = E.Filters.List
local Aura = E.Filters.Aura

-- This used to be standalone and is now merged into G.unitframe.aurafilters.Whitelist
G.unitframe.aurafilters.PlayerBuffs = nil

--[[
Long-term Raid Buffs
	1126 - Mark of the Wild
	1459 - Arcane Intellect
	6673 - Battle Shout
	21562 - Power Word: Fortitude
	369459 - Source of Magic
	462854 - Skyfury
	474754 – Symbiotic Relationship

Blessing of the Bronze Auras
	381732 - Death Knight
	381741 - Demon Hunter
	381746 – Druid
	381748 – Evoker
	381749 – Hunter
	381750 – Mage
	381751 – Monk
	381752 – Paladin
	381753 – Priest
	381754 – Rogue
	381756 – Shaman
	381757 – Warlock
	381758 - Warrior

Long-term Self Buffs
	433568 - Rite of Sanctification
	433583 - Rite of Adjuration

Rogue Poisons
	2823 - Deadly Poison
	8679 - Wound Poison
	3408 - Crippling Poison
	5761 - Numbing Poison
	315584 - Instant Poison
	381637 - Atrophic Poison
	381664 - Amplifying Poison

Shaman Imbuements
	319773 – Windfury Weapon
	319778 – Flametongue Weapon
	382021, 382022 – Earthliving Weapon
	457496, 457481 – Tidecaller's Guard
	462757, 462742 – Thunderstrike Ward
]]

G.unitframe.aurafilters.ClassDebuffs = {
	type = 'Whitelist',
	desc = L["Only important debuffs which influence your action priority. Recommended to be paired with 'Non Personal' set to 'Block'."],
	spells = {}
}

G.unitframe.aurafilters.ImportantCC = {
	type = 'Whitelist',
	desc = L["Only important CC debuffs like Polymorph, Hex, Stuns. Also includes important cc-like debuffs, for example Mind Soothe and Solar Beam."],
	spells = {}
}

G.unitframe.aurafilters.CCDebuffs = {
	type = 'Whitelist',
	desc = L["Debuffs that are some form of CC. This can be stuns, roots, slows, etc."],
	spells = {}
}

G.unitframe.aurafilters.TurtleBuffs = {
	type = 'Whitelist',
	desc = L["Immunity buffs like Bubble and Ice Block, but also most major defensive class cooldowns."],
	spells = {}
}

G.unitframe.aurafilters.Blacklist = {
	type = 'Blacklist',
	desc = L["Auras you don't want to see on your frames."],
	spells = {}
}

G.unitframe.aurafilters.Whitelist = {
	type = 'Whitelist',
	desc = L["Auras which should always be displayed."],
	spells = {}
}

G.unitframe.aurafilters.RaidDebuffs = {
	type = 'Whitelist',
	desc = L["List of important Dungeon and Raid debuffs. Includes affixes and utility on dead players like pending resurrection and available reincarnation."],
	spells = {}
}

-- Buffs applied by bosses, adds or trash
G.unitframe.aurafilters.RaidBuffsElvUI = {
	type = 'Whitelist',
	desc = L["List of important Dungeon and Raid buffs."],
	spells = {}
}

--[[
Preservation Evoker
	355941 - Dream Breath
	363502 - Dream Flight
	364343 - Echo
	366155 - Reversion
	367364 - Echo Reversion
	373267 - Lifebind
	376788 - Echo Dream Breath

Augmentation Evoker
	360827 - Blistering Scales
	395152 - Ebon Might
	410089 - Prescience
	410263 - Inferno's Blessing
	410686 - Symbiotic Bloom
	413984 - Shifting Sands

Resto Druid
	774 - Rejuv
	8936 - Regrowth
	33763 - Lifebloom
	48438 - Wild Growth
	155777 - Germination

Disc Priest
	17 - Power Word: Shield
	194384 - Atonement
	1253593 - Void Shield

Holy Priest
	139 - Renew
	41635 - Prayer of Mending
	77489 - Echo of Light

Mistweaver Monk
	115175 - Soothing Mist
	119611 - Renewing Mist
	124682 - Enveloping Mist
	450769 - Aspect of Harmony

Restoration Shaman
	974, 383648 - Earth Shield
	61295 - Riptide

Holy Paladin
	53563 - Beacon of Light
	156322 - Eternal Flame
	156910 - Beacon of Faith
	1244893 - Beacon of the Savior
	200025 - Beacon of Virtue
]]

-- Aura indicators on UnitFrames (Hots, Shields, Externals)
G.unitframe.aurawatch = {
	GLOBAL = {},
	EVOKER = {},
	ROGUE = {},
	WARRIOR = {},
	PRIEST = {},
	DRUID = {},
	PALADIN = {},
	SHAMAN = {},
	HUNTER = {},
	MONK = {},
	PET = {}
}

-- List of spells to display ticks
G.unitframe.ChannelTicks = {
	-- Racials
	[291944]	= 6, -- Regeneratin (Zandalari)
	-- Evoker
	[356995]	= 3, -- Disintegrate
	-- Warlock
	[198590]	= 4, -- Drain Soul
	[755]		= 5, -- Health Funnel
	[234153]	= 5, -- Drain Life
	-- Priest
	[64843]		= 4, -- Divine Hymn
	[15407]		= 6, -- Mind Flay
	[48045]		= 6, -- Mind Sear
	[47757]		= 3, -- Penance (heal)
	[47758]		= 3, -- Penance (dps)
	[373129]	= 3, -- Penance (Dark Reprimand, dps)
	[400171]	= 3, -- Penance (Dark Reprimand, heal)
	[64902]		= 5, -- Symbol of Hope (Mana Hymn)
	-- Mage
	[5143]		= 4, -- Arcane Missiles
	[12051]		= 6, -- Evocation
	[205021]	= 5, -- Ray of Frost
	-- Druid
	[740]		= 4, -- Tranquility
	-- DK
	[206931]	= 3, -- Blooddrinker
	-- DH
	[198013]	= 10, -- Eye Beam
	[212084]	= 10, -- Fel Devastation
	-- Hunter
	[120360]	= 15, -- Barrage
	[257044]	= 7, -- Rapid Fire
	-- Monk
	[113656]	= 4, -- Fists of Fury
}

-- Spells that chain, ticks to add
G.unitframe.ChainChannelTicks = {
	-- Evoker
	[356995]	= 1, -- Disintegrate
}

-- Window to chain time (in seconds); usually the channel duration
G.unitframe.ChainChannelTime = {
	-- Evoker
	[356995]	= 3, -- Disintegrate
}

-- Spells Effected By Talents
G.unitframe.TalentChannelTicks = {
	[356995]	= { [1219723] = 4 }, -- Disintegrate (Azure Celerity)
}

-- Increase ticks from auras
G.unitframe.AuraChannelTicks = {
	-- Priest
	[47757]		= { filter = 'HELPFUL', spells = { [373183] = 6 } }, -- Harsh Discipline: Penance (heal)
	[47758]		= { filter = 'HELPFUL', spells = { [373183] = 6 } }, -- Harsh Discipline: Penance (dps)
}

-- Spells Effected By Haste, value is Base Tick Size
G.unitframe.HastedChannelTicks = {
	-- [spellID] = true, -- SpellName
}

-- This should probably be the same as the whitelist filter + any personal class ones that may be important to watch
G.unitframe.AuraBarColors = {}

-- Auras which should change the color of the UnitFrame
G.unitframe.AuraHighlightColors = {}
