# Shared B-1B display configuration. Block D and Block E use the same core;
# only page selection and physical display metadata vary by aircraft variant.
# The original implementation was based upon display-system.nas from the F-16.

var DISPLAY_IS_BLOCK_E = getprop("/sim/variant-id") == 5;

var symbolSize = {
	hsd: {
	    contact: 1,
	    bullseye: 1,
	    ownship: 1,
	    compasFlag: 16,
	    cursor: 16,
	    cursorGhostAir: 18,
	    cursorGhostGnd: 12,
	    steerpoint: 5,
	    contactVelocity: 0.0045,
	    markpoint: 18,
	},
	bullseye: {
		eye: 1,
		ref: 1,
	},
	tfr: {
		terrain: 20,
		tick: 15,
	},
	has: {
		cursor: 1,
		tick: 10,
		crossInner: 20,
	},
	fcr: {
		blep: 10,
		track: 1.0,
		iff: 8,
		dl: 10,
		gainGaugeVert: 65,
		gainGaugeHoriz: 20,
		caret: 14,
		tick: 1.0,
		designation: 16,
		interceptCross: 10,
		designationGM: 10,
		dlzWidth: 20,
		dlzArrow: 1.0,
		horizLine: 10,
		cursorAir: 9,
		cursorGMGap: 11,
		cursorGMtick: 5,
		cursorGMtickDist: 50,
		bullseye: 1.0,
		steerpoint: 1.0,
		contactVelocity: 0.0045,
	},
};

var displayValues = {
	vsd: {
		terrainCenter: 0,
	},
	hdg: {
		indicated: 0,
		tape: {
			l1: "0",
			l2: "0",
			l3: "0",
			r1: "0",
			r2: "0",
			r3: "0",
			middleOffset: 0,
			offset: 0,
			middleText: 0,
			indicatedHdg: 0,
		},
	},
	nav: {
		gsInRange: 0,
		inRange: 0,
		gsNeedleDeflectionNorm: 0,
		hasGs: 0,
		headingNeedleDeflectionNorm: 0,
		navLoc: 0,
		selectedMhz: 0,
	},
	
};

var margin = {
	device: {
		buttonText: 15,
		feedbackRadius: 45,
		fillHeight: 1,
		outline: 1,
		# The tactical format frame is inset; SOI is a separate outer cue.
		frame: 37,
		soi: 8,
	},
	fcr: {
		trackText: 20,
		caretSide: 50,
		caretBottom: 50,
	},
	bullseye: {
		y: 50,
		x: 210,
		text: 20,
	},
	tfr: {
		sides: 20,
		bottom: 35,
	},
	has: {
		statusBox: 40,
		searchText: 45,
	},
};

var lineWidth = {
	device: {
		feedback: 2,
		outline: 2,
		x: 3,
		frame: 3,
		# Separate outer SOI cue: bright core plus a subdued bloom.
		soi: 3,
		soiGlow: 7,
	},
	fcr: {
		dlz: 2,
		rangeRings: 2,
		track:2,
		iff: 3,
		dl: 3,
		gainGauge: 2,
		caret: 5,
		tick: 3,
		designation: 2,
		designationGM: 2,
		interceptCross: 2,
		azimuthLine: 2,
		horizLine: 3,
		exp: 2,
		cursorAir: 2,
		cursorGnd: 2,
		bullseye: 3,
		steerpoint: 1,
		hotline: 1.5,
	},
	has: {
		cursor: 2,
		statusBox: 2,
		enclosure: 2,
		aim: 2,
	},
	tfr: {
		terrain: 1,
	},
	stations: {
		outline: 1.5,
	},
	bullseyeLayer: {
		eye: 2.5,
		ref: 2,
	},
	arrows: {
		triangle: 3,
	},
	hsd: {
	    bullseye: 3,
	    rangeRing: 2,
	    ownship: 2,
	    radarCone: 3,
	    threatRing: 3,
	    line: 2,
	    route: 2,
	    targetTrack: 2,
	    targetDL: 3,
	    designation: 2,
	    cursor: 2,
	    cursorGhost: 1.5,
	},
};

var font = {
	device: {
		main: 17,
		# The original B-1B controls used the device font size for OSB labels.
		osbLabels: 25,
	},
	hsd: {
		threat: 17,
		beyeCursor: 18,
	},
	fcr: {
		silent: 18,
		bit: 18,
		cursorAlt: 18,
		beyeCursor: 18,
	},
	bullseye: {
		center: 18,
		below: 18,
	},
	stations: {
		station: 17,
	},
	cube: {
		bit: 22,
	},
	sms: {
		default: 23,
	},
};

var zIndex = {
	device: {
		# Above page artwork (5), below OSB/control labels (100).
		frameFill: 50,
		osb: 100,
		page: 5,
		pullUp: 20000,
		layer: 200,
	},
	deviceObs: {
		text: 10,
		outline: 11,
		fill: 9,
		feedback: 7,
		frame: 10001,
		soi: 8,
		soiText: 10,
	},
	hsd: {
		rdrCone: 5,# and route
		rings: 2,
		ghostCursor: 2000,
		cursor: 2000,
		track: 11,
		dl: 11,
		designation: 12,
		ownship: 1,
		threat: 2,
		markpoint: 2,
		beyeCursor: 2,
		bullseye: 5,
	},
	fcr: {
		blep: 10,
		track: 11,
		iff: 12,
		dl: 11,
		gainGauge: 2,
		caret: 1,
		tick: 1,
		designation: 12,
		infoText: 1,
		interceptCross: 14,
		designationGM: 20,
		dlz: 11,
		azimuthLine: 13,
		horizLine: 15,
		silent: 16,
		bit: 16,
		expBox: 1,
		cursor: 1000,
		bullseye: 1,
		steerpoint: 1,
		beyeCursor: 1,
		ring: 1,
	},
	has: {

	},
};


# OSB text
var colorText1 = [getprop("/sim/model/MFD-color/text1/red"), getprop("/sim/model/MFD-color/text1/green"), getprop("/sim/model/MFD-color/text1/blue"), 1];

# Info text
var colorText2 = [getprop("/sim/model/MFD-color/text2/red"), getprop("/sim/model/MFD-color/text2/green"), getprop("/sim/model/MFD-color/text2/blue"), 1];

# red threat circles
var colorCircle1 = [getprop("/sim/model/MFD-color/circle1/red"), getprop("/sim/model/MFD-color/circle1/green"), getprop("/sim/model/MFD-color/circle1/blue")];

# yellow threat circles
var colorCircle2 = [getprop("/sim/model/MFD-color/circle2/red"), getprop("/sim/model/MFD-color/circle2/green"), getprop("/sim/model/MFD-color/circle2/blue")];

# green threat circles
var colorCircle3 = [getprop("/sim/model/MFD-color/circle3/red"), getprop("/sim/model/MFD-color/circle3/green"), getprop("/sim/model/MFD-color/circle3/blue")];

# Not used
var colorDot1 = [getprop("/sim/model/MFD-color/dot1/red"), getprop("/sim/model/MFD-color/dot1/green"), getprop("/sim/model/MFD-color/dot1/blue")];

# White/green radar search targets
var colorDot2 = [getprop("/sim/model/MFD-color/dot2/red"), getprop("/sim/model/MFD-color/dot2/green"), getprop("/sim/model/MFD-color/dot2/blue")];

# Datalink wingman
var colorDot4 = [getprop("/sim/model/MFD-color/dot4/red"), getprop("/sim/model/MFD-color/dot4/green"), getprop("/sim/model/MFD-color/dot4/blue")];

# Bullseye and STPT symbol on FCR
var colorBullseye = [getprop("/sim/model/MFD-color/bullseye/red"), getprop("/sim/model/MFD-color/bullseye/green"), getprop("/sim/model/MFD-color/bullseye/blue")];

# Bulleye direction to ownship text
var colorBetxt = [getprop("/sim/model/MFD-color/betxt/red"), getprop("/sim/model/MFD-color/betxt/green"), getprop("/sim/model/MFD-color/betxt/blue")];

# Own ship in HSD
var colorLine1  = [getprop("/sim/model/MFD-color/line1/red"), getprop("/sim/model/MFD-color/line1/green"), getprop("/sim/model/MFD-color/line1/blue")];

# Horizon in FCR
var colorLine2  = [getprop("/sim/model/MFD-color/line2/red"), getprop("/sim/model/MFD-color/line2/green"), getprop("/sim/model/MFD-color/line2/blue")];

# Steerpoints, cursor and many other symbols
var colorLine3  = [getprop("/sim/model/MFD-color/line3/red"), getprop("/sim/model/MFD-color/line3/green"), getprop("/sim/model/MFD-color/line3/blue")];

# EXP square
var colorLine4  = [getprop("/sim/model/MFD-color/line4/red"), getprop("/sim/model/MFD-color/line4/green"), getprop("/sim/model/MFD-color/line4/blue")];

# Range rings in HSD
var colorLine5  = [getprop("/sim/model/MFD-color/line5/red"), getprop("/sim/model/MFD-color/line5/green"), getprop("/sim/model/MFD-color/line5/blue")];

# FCR range rings and steerpoint legs
var colorLines  = [getprop("/sim/model/MFD-color/lines/red"), getprop("/sim/model/MFD-color/lines/green"), getprop("/sim/model/MFD-color/lines/blue")];

# Not used
var colorLines2 = [getprop("/sim/model/MFD-color/lines2/red"), getprop("/sim/model/MFD-color/lines2/green"), getprop("/sim/model/MFD-color/lines2/blue")];


var colorCubeRed = [255,0,0];
var colorCubeGreen = [0,255,0];
var colorCubeCyan = [0,255,255];

var colorBackground = [0.005,0.2,0.005, 1];
var rightPFDColorBackground = DISPLAY_IS_BLOCK_E ? [0.005, 0.005, 0.07, 1] : [0.005, 0.2, 0.005, 1];
var displayFrameFillColor = [0, 0, 0, 1];
var variantID = 1;
var COLOR_YELLOW     = [1.00,1.00,0.00];
var COLOR_BLUE_LIGHT = [0.50,0.50,1.00];
var COLOR_SKY_LIGHT  = [0.30,0.30,1.00];
var COLOR_RED        = [1.00,0.00,0.00];
var COLOR_WHITE      = [1.00,1.00,1.00];
var COLOR_BROWN      = [0.71,0.40,0.11];
var COLOR_BROWN_DARK = [0.56,0.32,0.09];
var COLOR_GRAY       = [0.25,0.25,0.25,0.50];
var COLOR_GRAY_LIGHT = [0.75,0.75,0.75,0.50];
var COLOR_SKY_DARK   = [0.15,0.15,0.60];
var COLOR_BLACK      = [0.00,0.00,0.00];

var str = func (d) {return ""~d};

var MM2TEX = 2;
var texel_per_degree = 2*MM2TEX;
var KT2KMH = 1.85184;


var PUSHBUTTON   = 0;
var ROCKERSWITCH = 1;

var CursorHSD = 1;
# var FACH3 = variantID == 4 or variantID >= 6;#MLU Tape M4.3
var FACH3 = 1;

var roundAbout = func(x) {
	var y = x - int(x);
	return y < 0.5 ? int(x) : 1 + int(x);
}

var hdgOutput = "";
var hdgText = func(x) {
	if (x == 0) {
		return "N";
	} else if (x == 9) {
		return "E";
	} else if (x == 18) {
		return "S";
	} else if (x == 27) {
		return "W";
	} else {
		hdgOutput = sprintf("%d", x);
		return hdgOutput;
	}
}

var DISPLAY_FONT_FILE = "HornetDisplay-Bold.ttf";
var DISPLAY_SVG_FONT_FILE = "DULarge.ttf";
var DISPLAY_DEVICE_PROPERTY_PATHS = {};

var displayWidth = DISPLAY_IS_BLOCK_E ? 768 : 1024;
var displayHeight = DISPLAY_IS_BLOCK_E ? 1024 : 512;
var displayWidthHalf = displayWidth * 0.5;
var displayHeightHalf = displayHeight * 0.5;
var DISPLAY_UV_MAP = [1, 1];
var DISPLAY_CONTROL_PROPERTY_PATH = func (propertyIndex) {
	return "controls/MFD[" ~ propertyIndex ~ "]/button-pressed";
};

var DISPLAY_PAGES = {
	osb: "PageOSB",
	blank: "PageBlank",
	init: "PageInit",
	menu: "PageTMenu",
	sms: "PageSMS1",
	pfd: "PagePFD1",
};

# Legacy OSB-assignment targets retained from the original code. These pages
# are not implemented or registered by the current B-1B display system.
var DISPLAY_OSB_ASSIGNMENT_PAGES = {
	fcr: "PageFCR",
	weapons: "PageSMSWPN",
	stores: "PageSMSINV",
	hsd: "PageHSD",
	dte: "PageDTE",
	has: "PageHAS",
	fcrMode: "PageFCRMode",
};

var DISPLAY_PAGE_IDS = DISPLAY_IS_BLOCK_E
	? [DISPLAY_PAGES.osb, DISPLAY_PAGES.menu, DISPLAY_PAGES.sms, DISPLAY_PAGES.pfd, DISPLAY_PAGES.blank]
	: [DISPLAY_PAGES.osb, DISPLAY_PAGES.blank, DISPLAY_PAGES.init];

var DISPLAY_INITIAL_PAGE_IDS = DISPLAY_IS_BLOCK_E
	? [DISPLAY_PAGES.menu, DISPLAY_PAGES.pfd, DISPLAY_PAGES.sms, DISPLAY_PAGES.blank]
	: [DISPLAY_PAGES.blank, DISPLAY_PAGES.init];

var DISPLAY_PAGE_SELECTOR = DISPLAY_IS_BLOCK_E
	? { off: DISPLAY_PAGES.blank, on: DISPLAY_PAGES.pfd }
	: { off: DISPLAY_PAGES.init, on: DISPLAY_PAGES.init };

var DISPLAY_DEVICES = DISPLAY_IS_BLOCK_E ? [
	{ slot: "leftPFD",  name: "leftPFD",  propertyIndex: 0, placementNode: "MFD1_Canvas", texture: "Front_MFD1_Canvas.png", initialSelector: 1 },
	{ slot: "leftMFD",  name: "LeftMFD",  propertyIndex: 1, placementNode: "MFD2_Canvas", texture: "Front_MFD1_Canvas.png", initialSelector: 0 },
	{ slot: "rightPFD", name: "RightPFD", propertyIndex: 2, placementNode: "MFD3_Canvas", texture: "Front_MFD1_Canvas.png", initialSelector: 1 },
	{ slot: "rightMFD", name: "RightMFD", propertyIndex: 3, placementNode: "MFD4_Canvas", texture: "Front_MFD1_Canvas.png", initialSelector: 0 },
] : [
	{ slot: "leftPFD", name: "leftPFD", propertyIndex: 0, placementNode: "AI", texture: "vsd_canvas.png", initialSelector: 1 },
];

var DISPLAY_RUNTIME_PROPERTY_PATHS = {
	cursorClick: "controls/displays/cursor-click",
	pageSelector: "/sim/bools/bit",
	electricalOutput: "fdm/jsbsim/electric/output/tvtab2",
};
