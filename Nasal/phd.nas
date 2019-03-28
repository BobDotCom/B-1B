# Simulates a Terrain Clearance Radar Mode on the B-1B pilots mfd display.
# Script originally from the A-6E by XIII aka Alexis Bory. Many Thanks!



var disp_length	= 0.0856; # lenght of the plots line in m (3D model).
var disp_def	= 50; # number of plots in the line (3D model).
var dev_calibration = 2.75; # factors vert. deviation for better readability (5.5).

var UPDATE_PERIOD = 0.2;

var TCrealistic = props.globals.getNode("/sim/model/A-6E/controls/PHD/TCrealistic-shadow", 1);
var TCon_off    = props.globals.getNode("/sim/model/A-6E/controls/PHD/off-stdby-on", 1);
var instr       = props.globals.getNode("/sim/model/A-6E/instrumentation/PHD");
var phdTCrng    = props.globals.getNode("/sim/model/A-6E/instrumentation/PHD/TCrange");
var v_rng_dev   = props.globals.getNode("/sim/model/A-6E/instrumentation/PHD/v-deviation");
var h_rng_dev   = props.globals.getNode("/sim/model/A-6E/instrumentation/PHD/h-deviation");
var plots_out   = props.globals.getNode("/sim/model/A-6E/instrumentation/PHD/plots-out-of-range");
var ac_hdg      = props.globals.getNode("/orientation/heading-deg");
var pitch       = props.globals.getNode("/orientation/pitch-deg");
var ac_lon      = props.globals.getNode("/position/longitude-deg");
var ac_lat      = props.globals.getNode("/position/latitude-deg");
var ac_alt      = props.globals.getNode("/position/altitude-ft");
var ac_agl	= props.globals.getNode("/position/altitude-agl-ft");
var view_name   = props.globals.getNode("sim/current-view/name");
var view_pitch  = props.globals.getNode("sim/current-view/pitch-offset-deg");

var rng_m        = 0;
var phd_scale    = 0;
var interval_m   = 0;
var tc_real      = 0;
var i_shadow     = 0;
var elevs_list   = []; 
var counter      = 0;
var ac_alt_m     = 0;
var hdg          = 0;
var ptch_deg     = 0;
var disp_in_rng  = 0;
var disp_dev_max = 0;
var own_coord    = nil;
var v_dev        = 0;
var sin   = math.sin;
var atan2 = math.atan2;
var D2R   = math.pi / 180;
var FT2M  = 0.3048;
var NM2M  = 1852;


# loop ####################
update_loop = func {
	var viewn = view_name.getValue();
	#var viewp = view_pitch.getValue();
	var on = TCon_off.getValue();
	if ( viewn == "Cockpit View" and on == 2) {
		make_beam();
	}
	settimer(update_loop, UPDATE_PERIOD);
}


# functions ###############
make_beam = func {
	if ( counter > 7 ) { counter = 0 }
	var shadow_lim	= 0;

	if (counter == 0 ) {
		disp_in_rng = 1;
		disp_dev_max = 0.2;
		# Define the position of the whole plots line at Sea Level.
		# The plots line pitch rotation is made directly in the animation xml file. 
		ptch_deg = pitch.getValue();
		var  rng_mls = phdTCrng.getValue();
		# Define conditions where the plots should'nt be displayed outside display.
		if ( rng_mls == 1.5 ) {
			if ( ptch_deg > 45 ) {
				disp_in_rng = 0;
				plots_out.setBoolValue(1);
			} elsif ( ptch_deg < 20 ) {
				disp_dev_max = 0.1025;
			} else {
				# print ( "pitch: " ~ ptch_deg ~ " between 20 and 45");
				disp_dev_max = 0.0850;
			}
		}
	}

	if ( disp_in_rng ) {
		if ( counter == 1 ) {
			var ptch_rad = D2R * ptch_deg;
			var pitch_sin = sin(ptch_rad);
			ac_alt_m = FT2M * ac_alt.getValue();
			ac_agl_m = FT2M * ac_agl.getValue();
			v_dev = ac_agl_m * phd_scale / 2 * dev_calibration;
			var h_dev = pitch_sin * v_dev;
			plots_out.setBoolValue(0);
			v_rng_dev.setDoubleValue(v_dev);
			h_rng_dev.setDoubleValue(h_dev);
			var a_lon = ac_lon.getValue();
			var a_lat = ac_lat.getValue();
			hdg	= ac_hdg.getValue();
			own_coord = geo.Coord.new().set_latlon(a_lat, a_lon);

			# Radar shadow on/off (for tests purpose).
			tc_real = TCrealistic.getValue();
		} elsif ( counter == 2 ) {
			for (var i = 0; i < 10; i += 1) {
				elevs_list[i] = get_remote_elev( int(i * interval_m), hdg, own_coord );
			}
		} elsif ( counter == 3 ) {
			for (var i = 10; i < 20; i += 1) {
				elevs_list[i] = get_remote_elev( int(i * interval_m), hdg, own_coord );
			}
		} elsif ( counter == 4 ) {
			for (var i = 20; i < 30; i += 1) {
				elevs_list[i] = get_remote_elev( int(i * interval_m), hdg, own_coord );
			}
		} elsif ( counter == 5 ) {
			for (var i = 30; i < 40; i += 1) {
				elevs_list[i] = get_remote_elev( int(i * interval_m), hdg, own_coord );
			}
		} elsif ( counter == 6 ) {
			for (var i = 40; i < 50; i += 1) {
				elevs_list[i] = get_remote_elev( int(i * interval_m), hdg, own_coord );
			}
		} elsif ( counter == 7 ) {
			for (var i = 0; i < 50; i += 1) {
				# Define coords and elev of each plot.
				var name = "/sim/model/A-6E/instrumentation/PHD/s[" ~ i ~ "]";
				var s = props.globals.getNode(name, 1);
				var i_elev = elevs_list[i];
				var i_agl = elevs_list[i] - ac_alt_m;
				var i_dev = i_elev * phd_scale;
				var i_dev_agl = i_agl * phd_scale;
				s.getNode("elevation_m", 1).setDoubleValue(i_dev_agl / 2 * dev_calibration);
				# Some plots are invisible because in the radar beam's shadow
				# or displayed outside the case of radar screen .
				if (tc_real == 1) {
					var total_dev = v_dev - i_dev;
					v = 0;
					i_shadow =  -atan2((ac_alt_m - i_elev), int(i * interval_m));
					if (i == 0 ) { shadow_lim = i_shadow; }
					if (( i_shadow >= shadow_lim ) and ( total_dev < disp_dev_max )) {
						shadow_lim = i_shadow;
						v = 1;
					}
				} else {
					v = 1;
				}
				s.getNode("visible", 1).setBoolValue(v);
			}
		}
	}
	counter += 1;
}


var get_remote_elev = func(d, h, o) {
	# dist, hdg, own_coord
	var i_coord = o.apply_course_distance(h, d);
	return geo.elevation(i_coord.lat(), i_coord.lon()) or 0;
}

var TCsettings = func {
	# radar display scale.
	var  rng_mls = phdTCrng.getValue();
	 print("     rng_mls:" ~ rng_mls);
	rng_m = NM2M * rng_mls;
	phd_scale = disp_length / rng_m;
        # 0.0856 / 2700 = 0.0000317
	## print("     phd_scale: " ~ phd_scale ~ " rng_m: " ~ rng_m);
	interval_m = rng_m / disp_def / 10;
}


# init #################
init = func {
	print("Initializing Terrain Clearance E-scan");
	setlistener("/sim/model/A-6E/instrumentation/PHD/TCrange", TCsettings);
	for (var i = 0; i < 50; i += 1) { append(elevs_list, 0) }
	TCsettings();
	update_loop();
}

setlistener("/sim/signals/fdm-initialized", init);

