### radar visibility calculator

var radis = func {

### this part calculates my radar range properties
var myaircraft = getprop("/sim/aircraft");
var myacname = aircraftData[myaircraft];
if (myacname == nil){
var myacname = 0;
}
var my_radar_area = radarData[myacname][7];
var my_radar_range = radarData[myacname][5];
var my_radarcorr = my_radar_range / my_radar_area;
#var my_plane = radarData[myacname][2];
#print (my_plane);
#print (my_radar_area);

#####  calculate other aircraft detection range
### first get the multiplayer aircraft name

var i = 0;
var mpname = getprop("ai/models/multiplayer[" ~ i ~ "]/sim/model/path");
if (mpname == nil) {
settimer(radis, 0.2);
} else {
var splitname = split("/", mpname);
#debug.dump(splitname);
var cutname = splitname[1];
print (cutname);

### then calculate the rcs detection range
# if aircraft is not found in list, 0(generic) will be used

var acname = aircraftData[cutname];
if (acname == nil){
var acname = 0;
}
var rcs_4r = radarData[acname][3];
var radartype = radarData[acname][1];

# now add a correction factor for altitude, as lower alt means shorter radar distance (due to air turbulence)
var alt_corr = 1;
var alt_ac = getprop("ai/models/multiplayer[" ~ i ~ "]/position/altitude-ft");
if (alt_ac <= 1000) {
var alt_corr = 0.7;
} elsif ((alt_ac > 1000) and (alt_ac <= 5000)) {
var alt_corr = 0.85;
}

# here we can add a correction factor for altitude agl

# then calculate the detection distance
var det_range = my_radarcorr * rcs_4r * alt_corr / 1.852;
print (radartype);
print (rcs_4r);
print (det_range);

### now compare if aircraft is in detection range and set property

var act_range = getprop("ai/models/multiplayer[" ~ i ~ "]/radar/range-nm");
if ((act_range == nil) or (act_range == 0)) {
var act_range = 500;
}
if ((det_range) >= act_range) {
setprop("ai/models/multiplayer[" ~ i ~ "]/radar/in-radar-range", 1);
} else {
setprop("ai/models/multiplayer[" ~ i ~ "]/radar/in-radar-range", 0);
}

#var pow = func(x, y) { exp(y * ln(x)) }

settimer(radis, 2);
 }
}

### convert aircraft to lookup number for table below

aircraftData = {
"generic" : "0",
"707" : "1",
"737-300" : "2",
"747" : "3",
"787" : "4","777" : "4",
"A24-Viking" : "5",
"A-10" : "6",
"A300" : "7",
"A320" : "8",
"A380" : "9",
"a4" : "10",
"A-6E" : "11",
"A6M2" : "12",
"Albatross" : "13",
"Aerostar-700" : "14",
"Alouette-II" : "15",
"Alouette-III" : "16",
"Alphajet" : "17",
"an-2" : "18",
"AN-225" : "19",
"apache" : "20",
"ASK21" : "21","asw20" : "21","bocian" : "21",
"b1900d" : "22",
"B-1B" : "23",
"B-2" : "24",
"b29" : "25",
"B-52F" : "26",
"BAC-TSR2" : "27",
"beaufighter" : "28",
"bf109" : "29",
"Buccaneer" : "30",
"c310" : "31","c310u3a" : "31",
"c172" : "32","c172p" : "32","c172r" : "32",
"c182" : "32","c182rg" : "32",
"dhc6" : "33",
"E3B" : "34",
"F-86" : "35",
"f104" : "36",
"f-14b" : "37",
"f-14d" : "38",
"f15" : "39","f15c" : "39",
"f16" : "40",
"f18" : "41",
"f22" : "42",
"f35" : "43",
"f117" : "44",
"fokker50" : "45",
"harrier" : "46",
"hunter" : "47",
"j22" : "48",
"KC135" : "49",
"Lightning" : "50",
"SR71-Blackbird" : "51",
"MiG-21" : "52",
"Mig-29" : "53",
"mirage2000" : "54",
"MPCarrier" : "55",
"Tornado" : "56"
};

### radar lookup table , consisting aircraft name, RCS(m2), 4th root of RCS, radar type, max. radar range(km), max. radar range target seize(RCS)m2, 4th root of radar RCS

radarData = [
[0, "generic", 5, 1.49, "APG-63", 150, 100, 3.16],
[1, "707", 80, 2.34, "none", 0, 0, 0],#guess
[2, "737", 50, 2.11, "none", 0, 0, 0],#guess
[3, "747", 100, 2.34, "none", 0, 0, 0],#guess
[4, "787", 35, 1.86, "WXR-2100", 160, 100, 3.16],#guess
[5, "A24-Viking", 2, 1.19, "none", 0, 0, 0],#guess
[6, "A-10", 25, 2.23, "none", 0, 0, 0],
[7, "A300", 80, 2.23, "none", 0, 0, 0],#guess
[8, "A320", 50, 1.96, "none", 0, 0, 0],#guess
[9, "A380", 100, 2.11, "none", 0, 0, 0],#guess
[10, "a4", 10, 1.77, "APG-53", 15, 5, 1.49],
[11, "A-6E", 14, 1.93, "APQ-112", 150, 100, 3.16],
[12, "A6M2", 15, 1.96, "none", 0, 0, 0],#guess
[13, "Albatross", 40, 2.51, "none", 0, 0, 0],#guess
[14, "Aerostar-700", 10, 1.86, "none", 0, 0, 0],#guess
[15, "Alouette-II", 15, 2.51, "none", 0, 0, 0],#guess
[16, "Alouette-III", 20, 2.11, "none", 0, 0, 0],#guess
[17, "Alphajet", 5, 1.49, "none", 0, 0, 0],#guess
[18, "an-2", 2, 1.19, "none", 0, 0, 0],#guess
[19, "AN-225", 100, 2.59, "unknown", 0, 0, 0],#guess
[20, "apache", 30, 2.34, "APG-78", 8, 1, 1],#guess
[21, "ASK21", 1, 1, "none", 0, 0, 0],#guess
[22, "b1900d", 20, 2.11, "wx500", 60, 100, 3.16],#guess
[23, "B-1B", 4, 1.41, "APQ-164", 296, 100, 3.16],
[24, "B-2", 0.0015, 0.19, "APQ-181", 333, 100, 3.16],
[25, "b29", 100, 3.16, "APQ-19", 45, 100, 3.16],
[26, "B-52F", 100, 3.16, "APQ-166", 296, 100, 3.16],
[27, "BAC-TSR2", 15, 1.86, "Blue Parrot", 46, 100, 3.16],
[28, "beaufighter", 9, 1.73, "none", 0, 0, 0],
[29, "bf109", 15, 1.96, "none", 0, 0, 0],
[30, "Buccaneer", 10, 1.77, "Blue Parrot", 46, 100, 3.16],
[31, "c310", 4, 1.41, "none", 0, 0, 0],
[32, "c172", 2, 1.19, "none", 0, 0, 0],
[33, "dhc6", 5, 1.49, "none", 0, 0, 0],
[34, "E3B", 100, 2.23, "APY-1/2", 650, 100, 3.16],
[35, "F-86", 9, 1.73, "APG-37", 50, 100, 3.16],
[36, "f104", 9, 1.73, "ASG-14", 60, 100, 3.16],
[37, "f-14b", 25, 2.23, "AWG-9", 333, 100, 3.16],
[38, "f-14d", 25, 2.23, "APG-71", 380, 100, 3.16],
[39, "f-15", 30, 2.34, "APG-70", 235, 100, 3.16],
[40, "f16", 1.5, 1.11, "APG-68", 296, 100, 3.16],
[41, "f18", 1.0, 1.00, "APG-73", 326, 100, 3.16],
[42, "f22", 0.0010, 0.17, "APG-77", 410, 100, 3.16],
[43, "f35", 0.0025, 0.22, "APG-81", 350, 100, 3.16],
[44, "f117", 0.015, 0.35, "none", 0, 0, 0],
[45, "fokker50", 40, 1.96, "none", 0, 0, 0],
[46, "harrier", 15, 1.96, "APG-65", 296, 100, 3.16],
[47, "hunter", 8, 2, "Akco", 10, 100, 3.16],
[48, "j22", 9, 1.79, "none", 0, 0, 0],
[49, "KC135", 100, 2.43, "APN-218", 160, 100, 3.16],
[50, "Lightning", 5, 1.49, "AI-23", 111, 100, 3.16],
[51, "SR71", 0.015, 0.35, "APQ-108", 200, 100, 3.16],#range classified
[52, "MiG-21", 4, 1.41, "RP-21", 18, 100, 3.16],
[53, "Mig-29", 7, 1.63, "Sapfir", 115, 100, 3.16],
[54, "mirage2000", 2, 1.19, "RDY", 220, 100, 3.16],
[55, "MPCarrier", 10000, 10, "SPS-49", 525, 100, 3.16],
[56, "Tornado", 7, 1.63, "Foxhunter", 210, 100, 3.16]
];