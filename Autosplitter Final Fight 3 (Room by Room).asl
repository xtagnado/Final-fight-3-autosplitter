state("ares")				{}	// Auto-Split made by Xtagnado (Discord: Xtagnado#0430)	
state("bizhawk.multiclient"){}	// Feel free to use, share and change by your own purposes
state("bsnes")				{}	// Just leave the credits to future questions and updates
state("emuhawk")			{}	// I suggest you to play in BizHawk 2.8 x64 with Snes9x Core
state("higan")				{}	
state("lucia")				{}	
state("snes9x")				{}	
state("snes9x-x64")			{}	
init {
    var states = new Dictionary<int, long> {
		{	9646080		,	0x00000097EE04	},	// snes9x-rr 1.60		
		{	13565952	,	0x000140925118	},	// snes9x-rr 1.60 x64	
		{	9027584		,	0x00000094DB54	},	// snes9x 1.60			
//		{	12836864	,	0x0001408D8BE8	},	// snes9x 1.60 x64	
		{	12836864	,	0x00000497AFE2	},	// snes9x 1.60 x64	
		{	16019456	,	0x00000094D144	},	// higan v106			
		{	52056064	,	0x000000AAED7C	},	// bsnes v112			
		{	52477952	,	0x000000B16D7C	},	// bsnes v115			
		{	7061504		,	0x036F11500240	},	// BizHawk 2.3.0		BSNES
		{	4538368		,	0x036F05F94040	},	// BizHawk 2.6.0		BSNES
		{	4562944		,	0x036F05F95040	},	// BizHawk 2.7.0 x64	BSNES
//		{	4571136		,	0x036F06095040	},  // BizHawk 2.8 x64		BSNES 
//		{	4571136		,	0x036F003B815C	},  // BizHawk 2.8 x64		BSNES v115+
		{	4571136		,	0x036F004CE860	},  // BizHawk 2.8 x64		Snes9x
//		{	4571136		,	0x036F01AC9160	},  // BizHawk 2.8 x64		Faust
		{	21905408	,	0x000000C59EB0	},	// Ares v115			
		{	46374912	,	0x000000DE8678	},	// Ares v117			
		{	66867200	,	0x7FF7EF483678	},	// Ares v118			
		{	334737408	,	0x0000141D08F8	},	// Ares v121a			
		{	334901248	,	0x0000141F7FF8	},	// Ares v122			
		{	334778368	,	0x0000141D9BB8	},	// Ares v123			
		{	1409929216	,	0x0000543354B8	},	// Ares v124			
		{	1413222400	,	0x7FF76F8E50F8	},	// Ares v125			
		{	1413255168	,	0x7FF7E6ECCEB8	},	// Ares v126			
		{	472829952	,	0x7FF7BA79A3B8	},	// Ares v127			
		{	473198592	,	0X7FF73FFD6798	},	// Ares v128			
		{	473194496	,	0x7FF6BF804858	},	// Ares v129
		};
		long memoryOffset;
		if (states.TryGetValue(modules.First().ModuleMemorySize, out memoryOffset)){
		}
		vars.watchers = new MemoryWatcherList {
			new MemoryWatcher<byte> ((IntPtr)memoryOffset + 0x0018) { Name = "Begin" },
			new MemoryWatcher<byte> ((IntPtr)memoryOffset + 0x00B0) { Name = "Stage" },
			new MemoryWatcher<byte> ((IntPtr)memoryOffset + 0x075E) { Name = "Black" },
			new MemoryWatcher<byte> ((IntPtr)memoryOffset + 0x00C0) { Name = "Reset" },
			};
}
update {
    vars.watchers.UpdateAll(game);
	}
start {
    return vars.watchers["Begin"].Old == 81 && vars.watchers["Begin"].Current == 160;
	}
reset {
    return vars.watchers["Reset"].Old == 192 && vars.watchers["Reset"].Current == 0 || vars.watchers["Reset"].Old ==  81 && vars.watchers["Reset"].Current == 0 ;
	}
split {
	var Stage = vars.watchers["Stage"].Old == 13 && vars.watchers["Stage"].Current != 13;
	var Black = vars.watchers["Black"].Old == 80 && vars.watchers["Black"].Current == 0;
	return	Stage || Black;
	}