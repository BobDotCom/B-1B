
# start generic radar system
var baser = AIToNasal.new();
var omni = OmniRadar.new(1.0, 150, 55);
var terrain = TerrainChecker.new(0.1, 1, 30);# 0.05 or 0.10 is fine here
#var dlnkRadar = DatalinkRadar.new(0.03, 90);# 3 seconds because cannot be too slow for DLINK targets

var getCompleteList = func {
	return baser.vector_aicontacts_last;
}


# var rwr_fc = compat_failure_modes.set_unserviceable("instrumentation/rwr");
# FailureMgr.add_failure_mode("instrumentation/rwr", "RWR", rwr_fc);