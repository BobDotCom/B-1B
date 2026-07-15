# hooking damage into FailureMgr

var install_failures = func {
    var set_value = func(path, value) {
	var default = getprop(path);
	return {
	    parents: [FailurMgr.FailureActuator],
	      set_failure_level: func(level) setprop(path, level > 0 ? value : default),
	      get_failure_level: func { getprop(path) == default ? 0 : 1 }
        }
    }

    var failure_root = "/sim/failure-manager";

    prop = "/systems/computers/INS/heading";
    var INS_heading_failure = compat_failure_modes.set_unserviceable(prop);
    FailureMgr.add_failure_mode(prop, "Left Hyd Pump", INS_heading_failure);

    prop = "/systems/computers/INS/pitch";
    var INS_pitch_failure = compat_failure_modes.set_unserviceable(prop);
    FailureMgr.add_failure_mode(prop, "Left Hyd Pump", INS_pitch_failure);

    prop = "/systems/computers/INS/roll";
    var INS_roll_failure = compat_failure_modes.set_unserviceable(prop);
    FailureMgr.add_failure_mode(prop, "Left Hyd Pump", INS_roll_failure);

    prop = "/systems/computers/GSS/heading";
    var GSS_heading_failure = compat_failure_modes.set_unserviceable(prop);
    FailureMgr.add_failure_mode(prop, "Left Hyd Pump", GSS_heading_failure);

    prop = "/systems/computers/GSS/pitch";
    var GSS_pitch_failure = compat_failure_modes.set_unserviceable(prop);
    FailureMgr.add_failure_mode(prop, "Left Hyd Pump", GSS_pitch_failure);

    prop = "/systems/computers/GSS/roll";
    var GSS_roll_failure = compat_failure_modes.set_unserviceable(prop);
    FailureMgr.add_failure_mode(prop, "Left Hyd Pump", GSS_roll_failure);

    prop = "/systems/computers/ADC1/airspeed";
    var ADC1_airspeed_failure = compat_failure_modes.set_unserviceable(prop);
    FailureMgr.add_failure_mode(prop, "Left Hyd Pump", ADC1_airspeed_failure);

    prop = "/systems/computers/ADC1/groundspeed";
    var ADC1_groundspeed_failure = compat_failure_modes.set_unserviceable(prop);
    FailureMgr.add_failure_mode(prop, "Left Hyd Pump", ADC1_groundspeed_failure);

    prop = "/systems/computers/ADC1/mach";
    var ADC1_mach_failure = compat_failure_modes.set_unserviceable(prop);
    FailureMgr.add_failure_mode(prop, "Left Hyd Pump", ADC1_mach_failure);

    prop = "/systems/computers/ADC1/verticalspeed";
    var ADC1_vertspeed_failure = compat_failure_modes.set_unserviceable(prop);
    FailureMgr.add_failure_mode(prop, "Left Hyd Pump", ADC1_vertspeed_failure);

    prop = "/systems/computers/ADC1/baro_altitude";
    var ADC1_baro_altitude_failure = compat_failure_modes.set_unserviceable(prop);
    FailureMgr.add_failure_mode(prop, "Left Hyd Pump", ADC1_baro_altitude_failure);

    prop = "/systems/computers/ADC1/Glideslope-lateral-deflection";
    var ADC1_lateral_glidespole_failure = compat_failure_modes.set_unserviceable(prop);
    FailureMgr.add_failure_mode(prop, "Left Hyd Pump", ADC1_lateral_glidespole_failure);

    prop = "/systems/computers/ADC2/airspeed";
    var ADC2_airspeed_failure = compat_failure_modes.set_unserviceable(prop);
    FailureMgr.add_failure_mode(prop, "Left Hyd Pump", ADC2_airspeed_failure);

    prop = "/systems/computers/ADC2/groundspeed";
    var ADC2_groundspeed_failure = compat_failure_modes.set_unserviceable(prop);
    FailureMgr.add_failure_mode(prop, "Left Hyd Pump", ADC2_groundspeed_failure);

    prop = "/systems/computers/ADC2/mach";
    var ADC2_mach_failure = compat_failure_modes.set_unserviceable(prop);
    FailureMgr.add_failure_mode(prop, "Left Hyd Pump", ADC2_mach_failure);

    prop = "/systems/computers/ADC2/verticalspeed";
    var ADC2_vertspeed_failure = compat_failure_modes.set_unserviceable(prop);
    FailureMgr.add_failure_mode(prop, "Left Hyd Pump", ADC2_vertspeed_failure);

    prop = "/systems/computers/ADC2/baro_altitude";
    var ADC2_baro_altitude_failure = compat_failure_modes.set_unserviceable(prop);
    FailureMgr.add_failure_mode(prop, "Left Hyd Pump", ADC2_baro_altitude_failure);

    prop = "/systems/computers/ADC2/Glideslope-lateral-deflection";
    var ADC2_lateral_glidespole_failure = compat_failure_modes.set_unserviceable(prop);
    FailureMgr.add_failure_mode(prop, "Left Hyd Pump", ADC2_lateral_glidespole_failure);
}

var _init = func {
        removelistener(lsnr_s);
        install_failures();
    }

var lsnr_s = setlistener("sim/fdm-initialized", _init, 0, 0);
