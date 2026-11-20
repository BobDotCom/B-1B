#cdu900

var cdu = [];  # Gets filled in the input loop later on

var cdu_set = func(n,m){

    #n >= 0 are direct menu settings
    if (n >= 0){
      setprop("instrumentation/cdu900/menu", n);
      setprop("instrumentation/cdu900/submenu", m);
      setprop("instrumentation/cdu900/sel_subm", "");
      setprop("instrumentation/cdu900/line-selected", "");
    }

    #n == -1 are submenu toggle settings
    if (n == -1){
      var menu_set = getprop("instrumentation/cdu900/menu");
      n = menu_set;
      var nr = size(cdu[n]) - 1;
      #debug.dump(nr);
      var submenu_set = getprop("instrumentation/cdu900/submenu");
      m = submenu_set + m;
      if (m < 1){
        m = 1;
      }
      if (m > nr){
        m = nr;
      }
      setprop("instrumentation/cdu900/sel_subm", "");
      setprop("instrumentation/cdu900/line-selected", "");
    }

    #n == -2 are sub2/4/6-line2/4/6 selected
    if (n == -2){
      var submenu_set = getprop("instrumentation/cdu900/submenu");
      var menu_set = getprop("instrumentation/cdu900/menu");
      var sel_subm = cdu[menu_set][submenu_set]["sub"~ m ~""];
      setprop("instrumentation/cdu900/sel_subm", sel_subm);
      setprop("instrumentation/cdu900/line-selected", m);
      n = menu_set;
      m = submenu_set;
    }

    #n == -10 manipulate aerrow selected
    if (n == -10){
      var sel_subm = getprop("instrumentation/cdu900/sel_subm");
      if (sel_subm){
        var subm_value = getprop(""~ sel_subm ~"");
        #debug.dump(subm_value);
        subm_value = subm_value + m;
        setprop(""~ sel_subm ~"", subm_value);
      }
      #set entries
      var submenu_set = getprop("instrumentation/cdu900/submenu");
      var menu_set = getprop("instrumentation/cdu900/menu");
      n = menu_set;
      m = submenu_set;
    }

    setprop("instrumentation/cdu900/menu", n);
    setprop("instrumentation/cdu900/submenu", m);
    setprop("instrumentation/cdu900/line0", cdu[n][0]);
    setprop("instrumentation/cdu900/line1", cdu[n][m]["sub1"]);
    setprop("instrumentation/cdu900/line2", cdu[n][m]["sub2"]);
    setprop("instrumentation/cdu900/line3", cdu[n][m]["sub3"]);
    setprop("instrumentation/cdu900/line4", cdu[n][m]["sub4"]);
    setprop("instrumentation/cdu900/line5", cdu[n][m]["sub5"]);
    setprop("instrumentation/cdu900/line6", cdu[n][m]["sub6"]);

}

#var type = cdu[0]["menu0"];
#cdu[0].menu0 = "gbu-31";# set type to gbu-31

######################################################
#                Jimmy L. Miles here                 #
# This new section has been added in order to allow  #
# inputting of data from the CDU into sim properties #
#  This piece of code was inspired from my own work  #
# on the Boeing F-15EX Eagle II Upper Front Controls #
######################################################

var cdu_inputting = 0;  # Whether we're inputting data or not
var inputed_string = "";  # String input'd through the CDU stored here

# For the three following variables, check function `cdu_input`'s comments
var inputed_prop = "";
var inputed_length = 0;
var inputed_type = 0;

var edit_check = func() {
    # This function is triggered by the `EDIT` button on the CDU's keyboard
    # This will run checks and determine whether input should be triggered, depending on what
    # menu we're on and what's selected on the CDU
    
    # Used for debugging
    
    if (getprop("instrumentation/cdu900/menu") == 0) {  # We're in the COMMs Menu
        if (getprop("instrumentation/cdu900/submenu") == 1) {  # COMM1
            if (getprop("instrumentation/cdu900/line-selected") == 2) {  # Second line selected (COMM1 MHZ frequency)
                cdu_input("instrumentation/comm[0]/frequencies/selected-mhz", 6, 1);
            } elsif (getprop("instrumentation/cdu900/line-selected") == 4) {  # Third line selected (COMM1 STBY MHZ frequency)
                cdu_input("instrumentation/comm[0]/frequencies/standby-mhz", 6, 1);
            }
        } elsif (getprop("instrumentation/cdu900/submenu") == 2) {  # COMM2
            if (getprop("instrumentation/cdu900/line-selected") == 2) {  # Second line selected (COMM2 MHZ frequency)
                cdu_input("instrumentation/comm[1]/frequencies/selected-mhz", 6, 1);
            } elsif (getprop("instrumentation/cdu900/line-selected") == 4) {  # Third line selected (COMM2 STBY MHZ frequency)
                cdu_input("instrumentation/comm[1]/frequencies/standby-mhz", 6, 1);
            
            }
        }
    } elsif (getprop("instrumentation/cdu900/menu") == 1) {  # We're in the NAVs Menu
        if (getprop("instrumentation/cdu900/submenu") == 1) {  # NAV1
            if (getprop("instrumentation/cdu900/line-selected") == 2) {  # Second line selected (NAV1 MHZ frequency)
                cdu_input("instrumentation/nav[0]/frequencies/selected-mhz", 6, 1);
            } elsif (getprop("instrumentation/cdu900/line-selected") == 4) {  # Second line selected (NAV1 STBY MHZ frequency)
                cdu_input("instrumentation/nav[0]/frequencies/standby-mhz", 6, 1);
            } elsif (getprop("instrumentation/cdu900/line-selected") == 6) {  # Third line selected (NAV1 RADIAL deg)
                cdu_input("instrumentation/nav[0]/frequencies/radials/selected-deg", 6, 1);
            }
        } elsif (getprop("instrumentation/cdu900/submenu") == 2) {  # NAV2
            if (getprop("instrumentation/cdu900/line-selected") == 2) {  # Second line selected (NAV2 MHZ frequency)
                cdu_input("instrumentation/nav[1]/frequencies/selected-mhz", 6, 1);
            } elsif (getprop("instrumentation/cdu900/line-selected") == 4) {  # Second line selected (NAV2 STBY MHZ frequency)
                cdu_input("instrumentation/nav[1]/frequencies/standby-mhz", 6, 1);
            } elsif (getprop("instrumentation/cdu900/line-selected") == 6) {  # Third line selected (NAV2 RADIAL deg)
                cdu_input("instrumentation/nav[1]/frequencies/radials/selected-deg", 6, 1);
            }
        } elsif (getprop("instrumentation/cdu900/submenu") == 3) {  # ADF1
            if (getprop("instrumentation/cdu900/line-selected") == 2) {  # Second line selected (ADF1 KHZ frequency)
                cdu_input("instrumentation/adf[0]/frequencies/selected-khz", 6, 1);
            } elsif (getprop("instrumentation/cdu900/line-selected") == 4) {  # Second line selected (ADF1 STBY KHZ frequency)
                cdu_input("instrumentation/adf[0]/frequencies/standby-khz", 6, 1);
            } elsif (getprop("instrumentation/cdu900/line-selected") == 6) {  # Third line selected (ADF1 RADIAL deg)
                cdu_input("instrumentation/adf[0]/rotation-deg", 6, 1);
            }
        }
    }
}

var cdu_input = func(prop, length, type=0) {
    # Its purpose is to easily trigger inputs from the CDU's keyboard and apply it to a sim property.
    # `prop` is a string of the sim property's path
    # `length` is the maximum amount of characters in the input'd data (decimal point counts)
    # `type` if set to 0, it's an integer that's input'd, set to 1 and it's a floating number, set to 2 and it's a generic string (can be any character available on the CDU keyboard)
    # Note : with that method, we can only input to sim properties, and not Nasal variables, though if needed, it could
    # easily be done

    cdu_inputting = 1;  # We reset every input'd info, canceling the last input if any
    inputed_string = "";
    inputed_prop = prop;
    inputed_length = length;
    inputed_type = type;
}

# The following variables are used to determine whether a key's been pressed or ain't
var one_key = 0;
var two_key = 0;
var three_key = 0;
var four_key = 0;
var five_key = 0;
var six_key = 0;
var seven_key = 0;
var eight_key = 0;
var nine_key = 0;
var zero_key = 0;
var dec_key = 0;
var hyphen_key = 0;
var a_key = 0;
var b_key = 0;
var c_key = 0;
var d_key = 0;
var e_key = 0;
var f_key = 0;
var g_key = 0;
var h_key = 0;
var i_key = 0;
var j_key = 0;
var k_key = 0;
var l_key = 0;
var m_key = 0;
var n_key = 0;
var o_key = 0;
var p_key = 0;
var q_key = 0;
var r_key = 0;
var s_key = 0;
var t_key = 0;
var u_key = 0;
var v_key = 0;
var w_key = 0;
var x_key = 0;
var y_key = 0;
var z_key = 0;
var input_loop = func() {
    # This loop handles inputs through the CDU's keyboard
    if (cdu_inputting) {  # Don't gotta check nothing if we ain't inputting data through the CDU
        if (size(inputed_string) < inputed_length) {  # If we ain't reached the max amount of characters for the input
            if (inputed_type == 0) {  # Integer
                if (one_key == 1) {
                    inputed_string = inputed_string~"1";
                    one_key = 0;
                } elsif (two_key == 1) {
                    inputed_string = inputed_string~"2";
                    two_key = 0;
                } elsif (three_key == 1) {
                    inputed_string = inputed_string~"3";
                    three_key = 0;
                } elsif (four_key == 1) {
                    inputed_string = inputed_string~"4";
                    four_key = 0;
                } elsif (five_key == 1) {
                    inputed_string = inputed_string~"5";
                    five_key = 0;
                } elsif (six_key == 1) {
                    inputed_string = inputed_string~"6";
                    six_key = 0;
                } elsif (seven_key == 1) {
                    inputed_string = inputed_string~"7";
                    seven_key = 0;
                } elsif (eight_key == 1) {
                    inputed_string = inputed_string~"8";
                    eight_key = 0;
                } elsif (nine_key == 1) {
                    inputed_string = inputed_string~"9";
                    nine_key = 0;
                } elsif (zero_key == 1) {
                    inputed_string = inputed_string~"0";
                    zero_key = 0;
                }
            } elsif (inputed_type == 1) {  # Floating number
                if (one_key == 1) {
                    inputed_string = inputed_string~"1";
                    one_key = 0;
                } elsif (two_key == 1) {
                    inputed_string = inputed_string~"2";
                    two_key = 0;
                } elsif (three_key == 1) {
                    inputed_string = inputed_string~"3";
                    three_key = 0;
                } elsif (four_key == 1) {
                    inputed_string = inputed_string~"4";
                    four_key = 0;
                } elsif (five_key == 1) {
                    inputed_string = inputed_string~"5";
                    five_key = 0;
                } elsif (six_key == 1) {
                    inputed_string = inputed_string~"6";
                    six_key = 0;
                } elsif (seven_key == 1) {
                    inputed_string = inputed_string~"7";
                    seven_key = 0;
                } elsif (eight_key == 1) {
                    inputed_string = inputed_string~"8";
                    eight_key = 0;
                } elsif (nine_key == 1) {
                    inputed_string = inputed_string~"9";
                    nine_key = 0;
                } elsif (zero_key == 1) {
                    inputed_string = inputed_string~"0";
                    zero_key = 0;
                } elsif (dec_key == 1 and no_existing_decimal()) {
                    inputed_string = inputed_string~".";
                    dec_key = 0;
                }
            }
        }
    }
    
    # At the end of every check, we reset every key trigger variable
    one_key = 0;
    two_key = 0;
    three_key = 0;
    four_key = 0;
    five_key = 0;
    six_key = 0;
    seven_key = 0;
    eight_key = 0;
    nine_key = 0;
    zero_key = 0;
    dec_key = 0;
    hyphen_key = 0;
    a_key = 0;
    b_key = 0;
    c_key = 0;
    d_key = 0;
    e_key = 0;
    f_key = 0;
    g_key = 0;
    h_key = 0;
    i_key = 0;
    j_key = 0;
    k_key = 0;
    l_key = 0;
    m_key = 0;
    n_key = 0;
    o_key = 0;
    p_key = 0;
    q_key = 0;
    r_key = 0;
    s_key = 0;
    t_key = 0;
    u_key = 0;
    v_key = 0;
    w_key = 0;
    x_key = 0;
    y_key = 0;
    z_key = 0;
    
    # Update some strings or the displays
    setprop("controls/cdu-900/date-string", sprintf("%02d-%02d-%04d", getprop("sim/time/demand-month-idx"), getprop("sim/time/demand-day"),getprop("sim/time/demand-year")));
    setprop("controls/cdu-900/dec-string", sprintf("%03.05f %03.05f ", getprop("position/latitude-deg"), getprop("position/longitude-deg")));
    setprop("controls/cdu-900/dms-string", sprintf("%s %s", getprop("position/latitude-string"), getprop("position/longitude-string")));
    
    if (getprop("autopilot/route-manager/current-wp") != -1) {  # Route Manager's active
        setprop("controls/cdu-900/curr-stpt-id-string", sprintf("%s", getprop("autopilot/route-manager/wp["~getprop("autopilot/route-manager/current-wp")~"]/id")));
        setprop("controls/cdu-900/curr-stpt-dist-string", sprintf("N %04.02f", getprop("autopilot/route-manager/wp["~getprop("autopilot/route-manager/current-wp")~"]/dist")));
        setprop("controls/cdu-900/curr-stpt-bear-string", sprintf("%03d *", getprop("autopilot/route-manager/wp["~getprop("autopilot/route-manager/current-wp")~"]/bearing-deg")));
    } else {
        setprop("controls/cdu-900/curr-stpt-id-string", "");
        setprop("controls/cdu-900/curr-stpt-dist-string", "N XXX");
        setprop("controls/cdu-900/curr-stpt-bear-string", "XXX*");
    }
    
    var flight_plan_data = ["FLIGHTPLAN"];  # We load it depending on how many steerpoints/waypoints/whateveryoucallit there are
    var plan = flightplan();
    var planSize = plan.getPlanSize();
    for (var idx = 0; idx < planSize; idx += 1) {
        var wp = plan.getWP(idx);
        wp_id = wp.id;
        wp_lat = wp.lat;
        wp_lon = wp.lon;
        wp_alt = 00000.00;  # code for "no altitude"
        if (wp.alt_cstr != nil) {  # steerpoints don't necessarily got an altitude
            wp_alt = wp.alt_cstr;
        }
        
        append(flight_plan_data, { sub1: wp_id, sub2: "DMS", sub3: "---", sub4: "DEC", sub5: sprintf("%03.03f %03.03f", wp_lat, wp_lon), sub6: sprintf("%05.02f ft", wp_alt) });
    }
    
    if (size(flight_plan_data) == 1) {  # No steerpoints in the flightplan
        append(flight_plan_data, { sub1: "EMPTY", sub2: "", sub3: "", sub4: "", sub5: "", sub6: "" });
    }
    
    cdu = [  # We update it cuz some props need to be updated
    #com1 and 2 entries
      [ "COM SET", 
        { sub1: "COM1 MHZ", sub2: sprintf("%03.02f", getprop("instrumentation/comm/frequencies/selected-mhz")), sub3: "COM1 STBY", sub4: sprintf("%03.02f", getprop("instrumentation/comm/frequencies/standby-mhz")), sub5: "---", sub6: ""},
        { sub1: "COM2 MHZ", sub2: sprintf("%03.02f", getprop("instrumentation/comm[1]/frequencies/selected-mhz")), sub3: "COM2 STBY", sub4: sprintf("%03.02f", getprop("instrumentation/comm[1]/frequencies/standby-mhz")), sub5: "---", sub6: ""},
      ],
    #nav1 and 2,adf entries
      [ "NAV SET", 
        { sub1: "NAV1 MHZ", sub2: sprintf("%03.02f", getprop("instrumentation/nav[0]/frequencies/selected-mhz")), sub3: "NAV1 STBY", sub4: sprintf("%03.02f", getprop("instrumentation/nav[0]/frequencies/standby-mhz")), sub5: "NAV1 HDG", sub6: sprintf("%03.01f", getprop("instrumentation/nav[0]/radials/selected-deg"))},
        { sub1: "NAV2 MHZ", sub2: sprintf("%03.02f", getprop("instrumentation/nav[1]/frequencies/selected-mhz")), sub3: "NAV2 STBY", sub4: sprintf("%03.02f", getprop("instrumentation/nav[1]/frequencies/standby-mhz")), sub5: "NAV2 HDG", sub6: sprintf("%03.01f", getprop("instrumentation/nav[1]/radials/selected-deg"))},
        { sub1: "ADF1 KHZ", sub2: sprintf("%03.02f", getprop("instrumentation/adf[0]/frequencies/selected-khz")), sub3: "ADF1 STBY", sub4: sprintf("%03.02f", getprop("instrumentation/adf[0]/frequencies/standby-khz")), sub5: "ADF1 HDG", sub6: sprintf("%03.01f", getprop("instrumentation/adf[0]/rotation-deg"))},
      ],
    #IFF(identify friend foe) entries
      [ "IDFY FRI-FOE", 
        { sub1: "M3/A",sub2: sprintf("%d", getprop("instrumentation/transponder/id-code")), sub3: "CALLSIGN", sub4: getprop("sim/multiplay/callsign"), sub5: "ENJOY", sub6: ""},

      ],
    #M3(ATHS) entries
      [ "ATHS", 
        { sub1: "NONE",sub2: "", sub3: "---", sub4: "", sub5: "NOT AVAILABLE", sub6: ""},
      ],
    #STR(TGT) entries
      [ "CODE", 
        { sub1: "LISTING",sub2: "", sub3: "---", sub4: "", sub5: "NOT AVAILABLE", sub6: ""},
      ],
    #FLPN(CODE) entries
      flight_plan_data,
    #PSN(FDLS) entries
      [ "POS INFO", 
        { sub1: "ZULU", sub2: sprintf("%sZ", getprop("sim/time/gmt-string")), sub3: "DATE", sub4: getprop("controls/cdu-900/date-string"), sub5: "---", sub6: ""},
        { sub1: "DMS", sub2: getprop("controls/cdu-900/dms-string"), sub3: "DEC", sub4: getprop("controls/cdu-900/dec-string"), sub5: "ALT", sub6: sprintf("%05d", getprop("instrumentation/altimeter/indicated-altitude-ft"))},
        { sub1: getprop("controls/cdu-900/curr-stpt-id-string") ,sub2: sprintf("%d", getprop("autopilot/route-manager/current-wp")), sub3: "BEAR", sub4: getprop("controls/cdu-900/curr-stpt-bear-string"), sub5: "DIST", sub6: getprop("controls/cdu-900/curr-stpt-dist-string")},
      ],
    #DVR(DATA) entries
      [ "DATA", 
        { sub1: "TOT FUEL %", sub2: sprintf("%03d", getprop("consumables/fuel/total-fuel-norm") * 100)~"%", sub3: "TOT FUEL LBS", sub4: sprintf("%d", getprop("consumables/fuel/total-fuel-lbs")), sub5: "GROSS WGT LBS", sub6: sprintf("%d", getprop("yasim/gross-weight-lbs"))},
      ],
];
    
}

input_loop_cdu = maketimer(.25, input_loop);  # Actually needs to be quite fast or it won't pick up keys if the pilot's pressing to quick
input_loop_cdu.start();

var confirm_input = func() {
    if (cdu_inputting) {
        # Confirms input and store it to the given sim property

        cdu_inputting = 0;  # Turns inputting OFF
        setprop(inputed_prop, inputed_string);
        
        # We update the display
        n = getprop("instrumentation/cdu900/menu");
        m = getprop("instrumentation/cdu900/submenu");
        setprop("instrumentation/cdu900/line0", cdu[n][0]);
        setprop("instrumentation/cdu900/line1", cdu[n][m]["sub1"]);
        setprop("instrumentation/cdu900/line2", cdu[n][m]["sub2"]);
        setprop("instrumentation/cdu900/line3", cdu[n][m]["sub3"]);
        setprop("instrumentation/cdu900/line4", cdu[n][m]["sub4"]);
        setprop("instrumentation/cdu900/line5", cdu[n][m]["sub5"]);
        setprop("instrumentation/cdu900/line6", cdu[n][m]["sub6"]);
    }    
}

var no_existing_decimal = func() {
    # Checks whether a decimal has already been input'd onto the string
    
    var decimal_found = 0;
    
    for (var i = 0; i < size(inputed_string); i += 1) {
        if (inputed_string[i] == "."[0]) {
            decimal_found = 1;
        }
    }
    
    
    return !decimal_found;
}
