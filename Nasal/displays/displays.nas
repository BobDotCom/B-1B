# Based upon display-system.nas from F-16

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

var margin = {
	device: {
		buttonText: 15,
		fillHeight: 1,
		outline: 1,
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
		outline: 2,
		x: 3,
		soi: 2,
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
var rightPFDColorBackground = [0.005, 0.005, 0.07, 1];
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
var FACH3 = variantID == 4 or variantID >= 6;#MLU Tape M4.3

#  ██████  ███████ ██    ██ ██  ██████ ███████ 
#  ██   ██ ██      ██    ██ ██ ██      ██      
#  ██   ██ █████   ██    ██ ██ ██      █████   
#  ██   ██ ██       ██  ██  ██ ██      ██      
#  ██████  ███████   ████   ██  ██████ ███████ 
#                                              
#                                              

var DisplayDevice = {
	new: func (name, resolution, uvMap, node, texture) {
		var device = {parents : [DisplayDevice] };
		device.canvas = canvas.new({
                			"name": name,
                           	"size": resolution,
                            "view": resolution,
                    		"mipmapping": 1
                    	});
		device.resolution = resolution;
		device.canvas.addPlacement({"node": node, "texture": texture});
		device.controls = {master:{"device": device}};
		device.controlPositions = {};
		device.listeners = [];
		device.uvMap = uvMap;
		device.name = name;
		device.system = nil;
		#device.addPullUpCue();
		device.new = func {return nil;};
		#device.timer = maketimer(0.25, device, device.loop);
		return device;
	},

	del: func {
		me.canvas.del();
		foreach(l ; me.listeners) {
			call(func removelistener(l),[],nil,nil,var err = []);
		}
		me.listeners = [];
		#call(func me.timer.stop(),[],nil,nil,err = []);
		#me.timer = nil;
		me.del = func {};
	},

	start: func {
		#me.timer.start();#timers dont really work in modules
		#me.start=func{};
	},

	loop: func {
		me.update(notifications.frameNotification);
		me.setSOI(me["aircraftSOI"] == 1);
	},

	setupProperties: func {
        me.input = {
            alt_ft:               "instrumentation/altimeter/indicated-altitude-ft",
            alt_true_ft:          "position/altitude-ft",
            heading:              "instrumentation/heading-indicator/indicated-heading-deg",
            radarStandby:         "instrumentation/radar/radar-standby",
            rad_alt:              "instrumentation/radar-altimeter/radar-altitude-ft",
            rad_alt_ready:        "instrumentation/radar-altimeter/ready",
            rmActive:             "autopilot/route-manager/active",
            rmDist:               "autopilot/route-manager/wp/dist",
            rmId:                 "autopilot/route-manager/wp/id",
            rmBearing:            "autopilot/route-manager/wp/true-bearing-deg",
            RMCurrWaypoint:       "autopilot/route-manager/current-wp",
            roll:                 "instrumentation/attitude-indicator/indicated-roll-deg",
            headTrue:             "orientation/heading-deg",
            roll:                 "orientation/roll-deg",
            pitch:                "orientation/pitch-deg",
            nav0InRange:          "instrumentation/nav[0]/in-range",
            APLockHeading:        "autopilot/locks/heading",
            APTrueHeadingErr:     "autopilot/internal/true-heading-error-deg",
            APnav0HeadingErr:     "autopilot/internal/nav1-heading-error-deg",
            APHeadingBug:         "autopilot/settings/heading-bug-deg",
            RMActive:             "autopilot/route-manager/active",
            nav0Heading:          "instrumentation/nav[0]/heading-deg",
            ias:                  "instrumentation/airspeed-indicator/indicated-speed-kt",
            tas:                  "instrumentation/airspeed-indicator/true-speed-kt",
            gearsPos:             "gear/gear/position-norm",
            latitude:             "position/latitude-deg",
            longitude:            "position/longitude-deg",
            mach:                 "instrumentation/airspeed-indicator/indicated-mach",
            inhg:                 "instrumentation/altimeter/setting-inhg",
            tacanCh:              "instrumentation/tacan/display/channel",
            ilsCh:                "instrumentation/nav[0]/frequencies/selected-mhz",
            servStatic:				 "systems/static/serviceable",
            servPitot:				 "systems/pitot/serviceable",
            servAtt                   : "instrumentation/attitude-indicator/serviceable",
            servHead                  : "instrumentation/heading-indicator/serviceable",
            servTurn                  : "instrumentation/turn-indicator/serviceable",
        };

        foreach(var name; keys(me.input)) {
            me.input[name] = props.globals.getNode(me.input[name], 1);
        }
    },

	setColorBackground: func (colorBackground) {
		me.canvas.setColorBackground(colorBackground);
	},

	addControls: func (type, prefix, from, to, property, positions) {
		if (contains(DisplayDevice, prefix)) {print("Illegal prefix");return;}
		me[prefix] = func (node) {
			me.tempActionValue = node.getValue();
			
			if (me.tempActionValue > 0) {
				#printDebug(me.name,": ",prefix, " action :", me.tempActionValue);
				me.cntlFeedback.setTranslation(me.controlPositions[prefix][me.tempActionValue-1]);
				me.cntlFeedback.setVisible(FACH3);
				me.cntlFeedback.update();
				#print("fb ON  ",me.controlPositions[prefix][me.tempActionValue-1][0],",",me.controlPositions[prefix][me.tempActionValue-1][1]);
				me.controlAction(type, prefix~(me.tempActionValue), me.tempActionValue);
			} else {
				me.cntlFeedback.hide();
				me.cntlFeedback.update();
				#print("fb OFF  ");
			}
		};
		me.controlPositions[prefix] = positions;
		for(var i = from; i <= to; i += 1) {
			me.controls[prefix~i] = {
				parents: [me.controls.master],
				name: prefix~i,
			};
		}
		if (me["controlGrp"] == nil) {
			me.controlGrp = me.canvas.createGroup()
								.set("z-index", zIndex.device.osb)
								.set("font","GordonURW-Med.ttf");
		}
		me.controls.master.setControlText = func (text, positive = 1, outline = 0, rear = 0, blink = 0) {
			# rear is adjustment of the fill in x axis

			# store for later SWAP option
			me.contentText = text;
			me.contentPositive = positive;
			me.contentOutline = outline;

			if (text == nil or text == "") {
				me.letters.setVisible(0);
				me.outline.setVisible(0);
				me.fill.setVisible(0);
				#me.fill.setColor((!positive)?me.device.colorFront:me.device.colorBack);
				#me.fill.setColorFill((!positive)?me.device.colorFront:me.device.colorBack);
				return;
			}
			me.letters.setVisible(1);
			me.letters.setText(text);
			me.letters.setColor(positive?me.device.colorFront:me.device.colorBack);
			me.outline.setVisible(positive and outline);
			me.fill.setVisible(1);
			me.fill.setColor((!positive)?me.device.colorFront:me.device.colorBack);
			me.fill.setColorFill((!positive)?me.device.colorFront:me.device.colorBack);
			me.linebreak = find("\n", text) != -1?2:1;
			me.lettersCount = size(text);
			if (me.linebreak == 2) {
				me.split = split("\n", text);
				if (size(me.split)>1) me.lettersCount = math.max(size(me.split[0]),size(me.split[1]));
			}
			me.fill.setScale(me.lettersCount/4,me.linebreak);
			me.outline.setScale(1.05*me.lettersCount/4,me.linebreak);
		};
		append(me.listeners, setlistener(property, me[prefix],0,0));
	},

	resetControls: func {
		me.tempKeys = keys(me.controls);
		foreach(var key; me.tempKeys) {
			if (me.controls[key]["parents"]!= nil) me.controls[key].setControlText("");
		}
	},

	update: func (noti) {
		if (me.system.supportSOI()) {
			# Lines or text
			me.setSOI(me["aircraftSOI"] == 1);
		} else {
			# Neither
			me.setSOI(-1);
		}
		me.system.update(noti);
	},

	controlAction: func {},

	setDisplaySystem: func (system) {
		me.system = system;
		system.setDevice(me);
	},

	addControlText: func (prefix, controlName, pos, posIndex, alignmentH=0, alignmentV=0) {
		me.tempX = me.controlPositions[prefix][posIndex][0]+pos[0];
		me.tempY = me.controlPositions[prefix][posIndex][1]+pos[1];

		me.alignment  = alignmentH==0?"center-":(alignmentH==-1?"left-":"right-");
		me.alignment ~= alignmentV==0?"center":(alignmentV==-1?"top":"bottom");
		me.letterWidth  = 0.6 * me.fontSize;
		me.letterHeight = 0.8 * me.fontSize;
		me.myCenter = [me.tempX, me.tempY];
		me.controls[controlName].letters = me.controlGrp.createChild("text")
				.set("z-index", zIndex.deviceObs.text)
				.setAlignment(me.alignment)
				.setTranslation(me.tempX, me.tempY)
				.setFontSize(me.fontSize, 1)
				.setText(right(controlName,4))
				.setColor(me.colorFront);
		me.controls[controlName].outline = me.controlGrp.createChild("path")
				.set("z-index", zIndex.deviceObs.outline)
				.setStrokeLineJoin("round") # "miter", "round" or "bevel"
				.moveTo(me.tempX-me.letterWidth*2*alignmentH-me.letterWidth*2-me.myCenter[0]-margin.device.outline, me.tempY-me.letterHeight*alignmentV*0.5-me.letterHeight*0.5-margin.device.outline-me.myCenter[1])
				.horiz(me.letterWidth*4+margin.device.outline*2)
				.vert(me.letterHeight*1.0+margin.device.outline*2)
				.horiz(-me.letterWidth*4-margin.device.outline*2)
				.vert(-me.letterHeight*1.0-margin.device.outline*2)
				.close()
				.setColor(me.colorFront)
				.hide()
				.setStrokeLineWidth(lineWidth.device.outline)
				.setTranslation(me.myCenter);
		me.controls[controlName].fill = me.controlGrp.createChild("path")
				.set("z-index", zIndex.deviceObs.fill)
				.setStrokeLineJoin("round") # "miter", "round" or "bevel"
				.moveTo(me.tempX-me.letterWidth*2*alignmentH-me.letterWidth*2-me.myCenter[0], me.tempY-me.letterHeight*alignmentV*0.5-me.letterHeight*0.5-margin.device.fillHeight-me.myCenter[1])
				.horiz(me.letterWidth*4)
				.vert(me.letterHeight*1.0+margin.device.fillHeight)
				.horiz(-me.letterWidth*4)
				.vert(-me.letterHeight*1.0-margin.device.fillHeight)
				.close()
				.setColorFill(me.colorBack)
				.setColor(me.colorBack)
				.setStrokeLineWidth(lineWidth.device.outline)
				.setTranslation(me.myCenter);
	},

	addPullUpCue: func {
        me.pullup_cue = me.canvas.createGroup().set("z-index", zIndex.device.pullUp);
        me.pullup_cue.createChild("path")
           .moveTo(0, 0)
           .lineTo(me.uvMap[0]*me.resolution[0], me.uvMap[1]*me.resolution[1])
           .moveTo(0, me.uvMap[1]*me.resolution[1])
           .lineTo(me.uvMap[0]*me.resolution[0], 0)
           .setStrokeLineWidth(lineWidth.device.x)
           .setColor(colorCircle1);
    },

    pullUpCue: func (vis) {
    	me.pullup_cue.setVisible();
    },

    addControlFeedback: func {
    	me.feedbackRadius = 35;
    	me.cntlFeedback = me.controlGrp.createChild("path")
	            .moveTo(-me.feedbackRadius,0)
	            .arcSmallCW(me.feedbackRadius,me.feedbackRadius, 0,  me.feedbackRadius*2, 0)
	            .arcSmallCW(me.feedbackRadius,me.feedbackRadius, 0, -me.feedbackRadius*2, 0)
	            .close()
	            .setStrokeLineWidth(2)
	            .set("z-index",zIndex.deviceObs.feedback)
	            .setColor(colorDot2[0],colorDot2[1],colorDot2[2],0.15)
	            .setColorFill(colorDot2[0],colorDot2[1],colorDot2[2],0.3)
	            .hide();
    },

	addSOILines: func () {
		me.tempMarginX = 11;
		me.tempMarginY = 10;
		me.soiLine = me.controlGrp.createChild("path")
				.set("z-index", zIndex.deviceObs.soi)
				.moveTo(me.tempMarginX,me.tempMarginY)
				.horiz(me.uvMap[0]*me.resolution[0]-me.tempMarginX*2)
				.vert(me.resolution[1]-me.tempMarginY*2)
				.horiz(-me.uvMap[0]*me.resolution[0]+me.tempMarginX*2)
				.lineTo(me.tempMarginX,me.tempMarginY)
				.setColor(me.colorFront)
				.hide()
				.setStrokeLineWidth(lineWidth.device.soi);
		return me.soiLine;
	},

	addSOIText: func (info) {
		me.soiText = me.controlGrp.createChild("text")
				.set("z-index", zIndex.deviceObs.soiText)
				.setColor(me.colorFront)
				.setAlignment("center-center")
				.setTranslation(me.uvMap[0]*me.resolution[0]*0.5, me.uvMap[1]*me.resolution[1]*0.30)
				.setFontSize(me.fontSize)
				.setText(info);
		return me.soiText;
	},

	setSOI: func (soi) {
		# -1 will remove both text and square
		me.soiLine.setVisible(soi == 1);
		me.soiText.setVisible(soi == 0);
		me.soi = soi;
	},

	setF16SOI: func (no) {
		# What number f16 regards this device as
		me.aircraftSOI = no;
	},

	getSOIPrio: func {
		return me.system.getSOIPrio();
	},

	setControlTextColors: func (foreground, background) {
		me.colorFront = foreground;
		me.colorBack  = background;
	},

	initPage: func (page) {
		printDebug(me.name," init page ",page.name);
		if (page.needGroup) {
			me.tempGrp = me.canvas.createGroup()
							.set("z-index", zIndex.device.page)
							.set("font","GordonURW-Med.ttf")
							.hide();
			page.group = me.tempGrp;
		}
		page.device = me;
	},

	initLayer: func (layer) {
		printDebug(me.name," init layer ",layer.name);
		me.tempGrp = me.canvas.createGroup()
						.set("z-index", zIndex.device.layer)
						.set("font","GordonURW-Med.ttf")
						.hide();
		layer.group = me.tempGrp;
		layer.device = me;
		layer.setup();
	},

	setSwapDevice: func (swapper) {
		me.swapWith = swapper;
	},

	swap: func {
		var myPageName = me.system.currPage.name;
		var otherPageName = me.swapWith.system.currPage.name;
		var mySoi = me.soi;
		var otherSoi = me.swapWith.soi;
		me.system.selectPage(otherPageName);
		me.swapWith.system.selectPage(myPageName);
		me.setSOI(otherSoi);
		me.swapWith.setSOI(mySoi);
		# The ==1 must be here below since soi can be -1 in the device:
		swapAircraftSOI(otherSoi == 1?me.aircraftSOI:mySoi==1?(me.swapWith.aircraftSOI):nil);
	},
};


#  ███████ ██    ██ ███████ ████████ ███████ ███    ███ 
#  ██       ██  ██  ██         ██    ██      ████  ████ 
#  ███████   ████   ███████    ██    █████   ██ ████ ██ 
#       ██    ██         ██    ██    ██      ██  ██  ██ 
#  ███████    ██    ███████    ██    ███████ ██      ██ 
#                                                       
#                                                       

var DisplaySystem = {
	new: func () {
		var system = {parents : [DisplaySystem] };
		system.new = func {return nil;};
		return system;
	},

	del: func {
		
	},

	setDevice: func (device) {
		me.device = device;
	},

	initDevice: func (propertyNum, controlPositions, fontSize) {
		me.device.addControls(PUSHBUTTON,  "OSB", 1, 28, "controls/MFD["~propertyNum~"]/button-pressed", controlPositions);
		#me.device.addControls(ROCKERSWITCH,"GAIN", 0, 1, "f16/avionics/mfd-"~(propertyNum?"r":"l")~"-gain", controlPositions);
		me.device.fontSize = fontSize;

		for (var i = 1; i <= 8; i+= 1) {
			me.device.addControlText("OSB", "OSB"~i, [margin.device.buttonText, 0], i-1,-1);
		}
		for (var i = 9; i <= 16; i+= 1) {
			me.device.addControlText("OSB", "OSB"~i, [-margin.device.buttonText, 0], i-1,1);
		}
		for (var i = 17; i <= 22; i+= 1) {
			me.device.addControlText("OSB", "OSB"~i, [0, margin.device.buttonText], i-1,0,-1);
		}
		for (var i = 23; i <= 28; i+= 1) {
			me.device.addControlText("OSB", "OSB"~i, [0, -margin.device.buttonText], i-1,0,1);
		}
		me.device.addSOILines();
		me.device.addSOIText("NOT SOI");
		me.device.setSOI(-1);
	},

	getSOIPrio: func {
		return me.currPage.supportSOI?me.currPage.soiPrio:-1;
	},

	initPage: func (pageName) {
		if (DisplaySystem[pageName] == nil) {print(pageName," does not exist");return;}
		me.tempPageInstance = DisplaySystem[pageName].new();
		me.device.initPage(me.tempPageInstance);
		me.pages[me.tempPageInstance.name] = me.tempPageInstance;
	},

	initLayer: func (layerName) {
		me.tempLayerInstance = DisplaySystem[layerName].new();
		me.device.initLayer(me.tempLayerInstance);
		me.layers[me.tempLayerInstance.name] = me.tempLayerInstance;
	},

	initPages: func () {
		me.pages = {};
		me.layers = {};

		me.initPage("PageTMenu");
		me.initPage("PagePFD1");
		me.initPage("PageSMS1");
		me.initPage("PageBlank");

#		me.device.doubleTimerRunning = nil;
		me.device.controlAction = func (type, controlName, propvalue) {
			me.tempLink = me.system.currPage.links[controlName];
			me.system.currPage.controlAction(controlName);
			if (me.tempLink != nil) {
#				if (me.doubleTimerRunning == nil) {
#					settimer(func me.controlActionDouble(), 0.25);
#					me.doubleTimerRunning = me.tempLink;
#					printDebug("Timer starting: ",me.doubleTimerRunning);
#				} elsif (me.doubleTimerRunning == me.tempLink) {
#					me.doubleTimerRunning = nil;
#					me.system.osbSelect = [me.tempLink, me.system.currPage];
#					me.system.selectPage("PageOSB");
#					printDebug("Doubleclick special");
#				} else {
#					me.doubleTimerRunning = nil;
					me.system.selectPage(me.tempLink);
#					printDebug("Timer interupted. Going to ",me.tempLink);
#				}
			}
		};

#		me.device.controlActionDouble = func {
#			printDebug("Timer ran: ",me.doubleTimerRunning);
#			if (me.doubleTimerRunning != nil) {
#				me.system.selectPage(me.doubleTimerRunning);
#				me.doubleTimerRunning = nil;
#			}
#		};

		append(me.device.listeners, setlistener("/sim/bools/bit", func(node) {
            forcePages(node.getValue(), me);
        },0,0));
	},

	fetchLayer: func (layerName) {
		if (me.layers[layerName] == nil) {
			print("\n",me.device.name,": no such layer ",layerName);
			print("Available layers: ");
			foreach(var layer; keys(me.layers)) {
				print(layer);
			}
			print();
		}
		return me.layers[layerName];
	},

	supportSOI: func {
		return me.currPage.supportSOI;
	},

	update: func (noti) {
		me.currPage.update(noti);
		foreach(var layer; me.currPage.layers) {
			me.fetchLayer(layer).update(noti);
		}
	},

	selectPage: func (pageName) {
		if (me.pages[pageName] == nil) {print(me.device.name," page not found: ",pageName);return;}
		me.wasSOI = me.device.soi == 1;# The ==1 must be here since soi can be -1 in the device
		if (me["currPage"] != nil) {
			if(me.currPage.needGroup) me.currPage.group.hide();
			me.currPage.exit();
			foreach(var layer; me.currPage.layers) {
				me.fetchLayer(layer).group.hide();
			}
		}
		me.currPage = me.pages[pageName];
		if(me.currPage.needGroup) me.currPage.group.show();
		me.currPage.enter();
		#me.currPage.update(nil);
		foreach(var layer; me.currPage.layers) {
			me.fetchLayer(layer).group.show();
		}
	},

	PageOSB: {
		name: "PageOSB",
		isNew: 1,
		supportSOI: 0,
		needGroup: 1,
		new: func {
			me.instance = {parents:[DisplaySystem.PageOSB]};
			me.instance.group = nil;
			return me.instance;
		},
		setup: func {
			printDebug(me.name," on ",me.device.name," is being setup");
			me.pageText = me.group.createChild("text")
				.set("z-index", 10)
				.setColor(colorText1)
				.setAlignment("center-center")
				.setTranslation(displayWidthHalf, displayHeight*0.30)
				.setFontSize(me.device.fontSize)
				.setText("Select desired OSB");
		},
		enter: func {
			printDebug("Enter ",me.name~" on ",me.device.name);
			if (me.isNew) {
				me.setup();
				me.isNew = 0;
			}
			me.device.resetControls();
			me.device.controls["OSB10"].setControlText("FCR");
			me.device.controls["OSB11"].setControlText("WPN");
			me.device.controls["OSB12"].setControlText("SMS");
			me.device.controls["OSB13"].setControlText("HSD");
			me.device.controls["OSB14"].setControlText("DTE");
			me.device.controls["OSB15"].setControlText("HAS");
			me.device.controls["OSB16"].setControlText("FCR\nMODE");
			me.device.controls["OSB17"].setControlText("MENU");
			me.device.controls["OSB19"].setControlText("CANCEL");
		},
		controlAction: func (controlName) {
			printDebug(me.name,": ",controlName," activated on ",me.device.name);
			if (controlName == "OSB19") {
				me.device.system.selectPage(me.device.system.osbSelect[1].name);
			} elsif (controlName == "OSB10") {
                me.device.system.osbSelect[1].links[me.device.system.osbSelect[0]] = "PageFCR";
                me.device.system.selectPage(me.device.system.osbSelect[1].name);
            } elsif (controlName == "OSB11") {
                me.device.system.osbSelect[1].links[me.device.system.osbSelect[0]] = "PageSMSWPN";
                me.device.system.selectPage(me.device.system.osbSelect[1].name);
            } elsif (controlName == "OSB12") {
                me.device.system.osbSelect[1].links[me.device.system.osbSelect[0]] = "PageSMSINV";
                me.device.system.selectPage(me.device.system.osbSelect[1].name);
            } elsif (controlName == "OSB13") {
                me.device.system.osbSelect[1].links[me.device.system.osbSelect[0]] = "PageHSD";
                me.device.system.selectPage(me.device.system.osbSelect[1].name);
            } elsif (controlName == "OSB14") {
                me.device.system.osbSelect[1].links[me.device.system.osbSelect[0]] = "PageDTE";
                me.device.system.selectPage(me.device.system.osbSelect[1].name);
            } elsif (controlName == "OSB15") {
                me.device.system.osbSelect[1].links[me.device.system.osbSelect[0]] = "PageHAS";
                me.device.system.selectPage(me.device.system.osbSelect[1].name);
            } elsif (controlName == "OSB16") {
                me.device.system.osbSelect[1].links[me.device.system.osbSelect[0]] = "PageFCRMode";
                me.device.system.selectPage(me.device.system.osbSelect[1].name);
            } elsif (controlName == "OSB17") {
                me.device.system.osbSelect[1].links[me.device.system.osbSelect[0]] = "PageTMenu";
                me.device.system.selectPage(me.device.system.osbSelect[1].name);
            }
		},
		update: func (noti = nil) {			
		},
		exit: func {
			printDebug("Exit ",me.name~" on ",me.device.name);
		},
		links: {
		},
		layers: [],
	},



# 88888888888     d8888  .d8888b.  888b     d888 8888888888 888b    888 888     888 
#     888        d88888 d88P  Y88b 8888b   d8888 888        8888b   888 888     888 
#     888       d88P888 888    888 88888b.d88888 888        88888b  888 888     888 
#     888      d88P 888 888        888Y88888P888 8888888    888Y88b 888 888     888 
#     888     d88P  888 888        888 Y888P 888 888        888 Y88b888 888     888 
#     888    d88P   888 888    888 888  Y8P  888 888        888  Y88888 888     888 
#     888   d8888888888 Y88b  d88P 888   "   888 888        888   Y8888 Y88b. .d88P 
#     888  d88P     888  "Y8888P"  888       888 8888888888 888    Y888  "Y88888P"                                 

	PageTMenu: {
		name: "PageTMenu",
		isNew: 1,
		supportSOI: 0,
		needGroup: 0,
		new: func {
			me.instance = {parents:[DisplaySystem.PageTMenu]};
			me.instance.group = nil;
			return me.instance;
		},
		setup: func {
			printDebug(me.name," on ",me.device.name," is being setup");
		},
		enter: func {
			printDebug("Enter ",me.name~" on ",me.device.name);
			if (me.isNew) {
				me.setup();
				me.isNew = 0;
			}
			me.device.resetControls();
			me.device.controls["OSB1"].setControlText("P\nF\nD");
			me.device.controls["OSB2"].setControlText("S\nM\nS");
			me.device.controls["OSB28"].setControlText("BLANK")

		},
		controlAction: func (controlName) {
			printDebug(me.name,": ",controlName," activated on ",me.device.name);
		},
		update: func (noti = nil) {
			
		},
		exit: func {
			printDebug("Exit ",me.name~" on ",me.device.name);
		},
		links: {
			"OSB1":  "PagePFD1",
			# "OSB2":  "PageSMS1",
			"OSB28": "PageBlank",
		},
		layers: [],
	},


#  .d8888b.  888b     d888  .d8888b.        d888   
# d88P  Y88b 8888b   d8888 d88P  Y88b      d8888   
# Y88b.      88888b.d88888 Y88b.             888   
#  "Y888b.   888Y88888P888  "Y888b.          888   
#     "Y88b. 888 Y888P 888     "Y88b.        888   
#       "888 888  Y8P  888       "888        888   
# Y88b  d88P 888   "   888 Y88b  d88P        888   
#  "Y8888P"  888       888  "Y8888P"       8888888


	PageSMS1: {
		name: "PageSMS1",
		isNew: 1,
		supportSOI: 0,
		needGroup: 1,
		new: func {
			me.instance = {parents:[DisplaySystem.PageSMS1]};
			me.instance.group = nil;
			return me.instance;
		},
		setup: func {
			printDebug(me.name," on ",me.device.name," is being setup");
			data.type_update.start();
			me.fwdGrp = me.group.createChild("group")
				.setTranslation((displayWidthHalf/2)-90,displayHeight/7);
			me.midGrp = me.group.createChild("group")
				.setTranslation(displayWidthHalf+25,displayHeight/7);
			me.aftGrp = me.group.createChild("group")
				.setTranslation(displayWidthHalf+270,displayHeight/7);

			me.fwdLabel = me.fwdGrp.createChild("text")
				.setText("Fwd Bay")
				.setTranslation(0,-50);
			me.fwd1 = me.fwdGrp.createChild("text")
				.setFontSize(font.sms.default)
				.setText("Weapon 1: EMPTY");
			me.fwd2 = me.fwdGrp.createChild("text")
				.setText("Weapon 2: EMPTY")
				.setFontSize(font.sms.default)
				.setTranslation(0,25);
			me.fwd3 = me.fwdGrp.createChild("text")
				.setText("Weapon 3: EMPTY")
				.setFontSize(font.sms.default)
				.setTranslation(0,50);
			me.fwd4 = me.fwdGrp.createChild("text")
				.setText("Weapon 4: EMPTY")
				.setFontSize(font.sms.default)
				.setTranslation(0,75);
			me.fwd5 = me.fwdGrp.createChild("text")
				.setText("Weapon 5: EMPTY")
				.setFontSize(font.sms.default)
				.setTranslation(0,100);
			me.fwd6 = me.fwdGrp.createChild("text")
				.setText("Weapon 6: EMPTY")
				.setFontSize(font.sms.default)
				.setTranslation(0,125);
			me.fwd7 = me.fwdGrp.createChild("text")
				.setText("Weapon 7: EMPTY")
				.setFontSize(font.sms.default)
				.setTranslation(0,150);
			me.fwd8 = me.fwdGrp.createChild("text")
				.setText("Weapon 8: EMPTY")
				.setFontSize(font.sms.default)
				.setTranslation(0,175);


			me.midLabel = me.midGrp.createChild("text")
				.setText("Mid Bay")
				.setTranslation(0,-50);
			me.mid1 = me.midGrp.createChild("text")
				.setFontSize(font.sms.default)
				.setText("Weapon 1: EMPTY");
			me.mid2 = me.midGrp.createChild("text")
				.setText("Weapon 2: EMPTY")
				.setFontSize(font.sms.default)
				.setTranslation(0,25);
			me.mid3 = me.midGrp.createChild("text")
				.setText("Weapon 3: EMPTY")
				.setFontSize(font.sms.default)
				.setTranslation(0,50);
			me.mid4 = me.midGrp.createChild("text")
				.setText("Weapon 4: EMPTY")
				.setFontSize(font.sms.default)
				.setTranslation(0,75);
			me.mid5 = me.midGrp.createChild("text")
				.setText("Weapon 5: EMPTY")
				.setFontSize(font.sms.default)
				.setTranslation(0,100);
			me.mid6 = me.midGrp.createChild("text")
				.setText("Weapon 6: EMPTY")
				.setFontSize(font.sms.default)
				.setTranslation(0,125);
			me.mid7 = me.midGrp.createChild("text")
				.setText("Weapon 7: EMPTY")
				.setFontSize(font.sms.default)
				.setTranslation(0,150);
			me.mid8 = me.midGrp.createChild("text")
				.setText("Weapon 8: EMPTY")
				.setFontSize(font.sms.default)
				.setTranslation(0,175);


			me.aftLabel = me.aftGrp.createChild("text")
				.setText("Aft Bay")
				.setTranslation(0,-50);
			me.aft1 = me.aftGrp.createChild("text")
				.setFontSize(font.sms.default)
				.setText("Weapon 1: EMPTY");
			me.aft2 = me.aftGrp.createChild("text")
				.setText("Weapon 2: EMPTY")
				.setFontSize(font.sms.default)
				.setTranslation(0,25);
			me.aft3 = me.aftGrp.createChild("text")
				.setText("Weapon 3: EMPTY")
				.setFontSize(font.sms.default)
				.setTranslation(0,50);
			me.aft4 = me.aftGrp.createChild("text")
				.setText("Weapon 4: EMPTY")
				.setFontSize(font.sms.default)
				.setTranslation(0,75);
			me.aft5 = me.aftGrp.createChild("text")
				.setText("Weapon 5: EMPTY")
				.setFontSize(font.sms.default)
				.setTranslation(0,100);
			me.aft6 = me.aftGrp.createChild("text")
				.setText("Weapon 6: EMPTY")
				.setFontSize(font.sms.default)
				.setTranslation(0,125);
			me.aft7 = me.aftGrp.createChild("text")
				.setText("Weapon 7: EMPTY")
				.setFontSize(font.sms.default)
				.setTranslation(0,150);
			me.aft8 = me.aftGrp.createChild("text")
				.setText("Weapon 8: EMPTY")
				.setFontSize(font.sms.default)
				.setTranslation(0,175);


		},
		enter: func {
			printDebug("Enter ",me.name~" on ",me.device.name);
			if (me.isNew) {
				me.setup();
				me.isNew = 0;
			}

			me.device.resetControls();
			me.device.controls["OSB18"].setControlText("MENU");

		},
		controlAction: func (controlName) {
			printDebug(me.name,": ",controlName," activated on ",me.device.name);
		},
		update: func (noti = nil) {

			print("DEBUG:UPDATE RAN");

			me.fwd1.setText(sprintf("Weapon 1: %s", getprop("/ai/guided/bay0/bomb/weapon-type")));
			me.fwd2.setText(sprintf("Weapon 2: %s", getprop("/ai/guided/bay0/bomb[1]/weapon-type")));
			me.fwd3.setText(sprintf("Weapon 3: %s", getprop("/ai/guided/bay0/bomb[2]/weapon-type")));
			me.fwd4.setText(sprintf("Weapon 4: %s", getprop("/ai/guided/bay0/bomb[3]/weapon-type")));
			me.fwd5.setText(sprintf("Weapon 5: %s", getprop("/ai/guided/bay0/bomb[4]/weapon-type")));
			me.fwd6.setText(sprintf("Weapon 6: %s", getprop("/ai/guided/bay0/bomb[5]/weapon-type")));
			me.fwd7.setText(sprintf("Weapon 7: %s", getprop("/ai/guided/bay0/bomb[6]/weapon-type")));
			me.fwd8.setText(sprintf("Weapon 8: %s", getprop("/ai/guided/bay0/bomb[7]/weapon-type")));
			
		},
		exit: func {
			printDebug("Exit ",me.name~" on ",me.device.name);
			data.type_update.stop();
		},
		links: {
			"OSB18":  "PageTMenu",
		},
		layers: [],
	},


# 8888888b.  8888888888 8888888b.  		8888888b.   d888   
# 888   Y88b 888        888  "Y88b 		888   Y88b d8888   
# 888    888 888        888    888 		888    888   888   
# 888   d88P 8888888    888    888 		888   d88P   888   
# 8888888P"  888        888    888 		8888888P"    888   
# 888        888        888    888 		888          888   
# 888        888        888  .d88P 		888          888   
# 888        888        8888888P"  		888        8888888

	PagePFD1: {
		name: "PagePFD1",
		isNew: 1,
		supportSOI: 0,
		needGroup: 1,
		new: func {
			me.instance = {parents:[DisplaySystem.PagePFD1]};
			me.instance.group = nil;
			return me.instance;
		},
		setup: func {
			printDebug(me.name," on ",me.device.name," is being setup");
			canvas.parsesvg(me.group, "Nasal/displays/PFD1.svg");
            me.altimeterPressure = me.group.getElementById("altimeterPressure").set("font","GordonURW-Med.ttf");
            me.airspeed = me.group.getElementById("airspeed").set("font","GordonURW-Med.ttf");
            me.altitude_1k = me.group.getElementById("altitude-1k").set("font","GordonURW-Med.ttf");
            me.altitude = me.group.getElementById("altitude").set("font","GordonURW-Med.ttf");
            me.taltitude_1k = me.group.getElementById("taltitude-1k").set("font","GordonURW-Med.ttf");
            me.taltitude = me.group.getElementById("taltitude").set("font","GordonURW-Med.ttf");
            me.asi = me.group.getElementById("asi");
            me.roll_pointer = me.group.getElementById("roll_pointer");
            #me.asi.setCenter(384, 256);
            me.gravity = me.group.getElementById("gravity").set("font","GordonURW-Med.ttf");
            me.hdg = me.group.getElementById("hdg").set("font","GordonURW-Med.ttf");
            me.mach = me.group.getElementById("mach").set("font","GordonURW-Med.ttf");
            me.tmach = me.group.getElementById("tmach").set("font","GordonURW-Med.ttf");
            me.ladder = me.group.getElementById("ladder");
            me.ground = me.group.getElementById("ground");
            me.horizon = me.group.getElementById("horizon");
            me.tspeed = me.group.getElementById("tspeed").set("font","GordonURW-Med.ttf");
            me.fpmIndicator = me.group.getElementById("fpm-indicator");
            me.gforce = me.group.getElementById("gforce").set("clip", "rect(117px, 156px, 396px, 0px)");
            me.speed = me.group.getElementById("speed").set("clip", "rect(117px, 156px, 396px, 0px)");

            foreach (var child; me.group.getElementById("ladder-text").getChildren()) {
                child.set("font","GordonURW-Med.ttf");
            }
            foreach (var child; me.group.getElementById("ib-ladder-text").getChildren()) {
                child.set("font","GordonURW-Med.ttf");
            }
            foreach (var child; me.group.getElementById("it-ladder-text").getChildren()) {
                child.set("font","GordonURW-Med.ttf");
            }
            foreach (var child; me.group.getElementById("vfpm-text").getChildren()) {
                child.set("font","GordonURW-Med.ttf");
            }
            foreach (var child; me.group.getElementById("gforce-text").getChildren()) {
                child.set("font","GordonURW-Med.ttf");
            }
            foreach (var child; me.group.getElementById("speed-text").getChildren()) {
                child.set("font","GordonURW-Med.ttf");
            }
            me.machFunc = func (mach) {
                if (substr(mach, 0, 1) == "0") {
                    return substr(mach, 1);
                }
                return mach;
            }

            # HSI
            me.group.getElementById("hsi-hdg").set("font","GordonURW-Med.ttf");
            me.group.getElementById("hsi-crs").set("font","GordonURW-Med.ttf");
            me.targetHdg = me.group.getElementById("target-hdg").set("font","GordonURW-Med.ttf");
            me.targetCrs = me.group.getElementById("target-crs").set("font","GordonURW-Med.ttf");

            # Enable text updates (updateText is more efficient than setText, but needs initialization)
            me.altimeterPressure.enableUpdate();
            me.airspeed.enableUpdate();
            me.altitude_1k.enableUpdate();
            me.altitude.enableUpdate();
            me.taltitude_1k.enableUpdate();
            me.taltitude.enableUpdate();
            me.gravity.enableUpdate();
            me.hdg.enableUpdate();
            me.mach.enableUpdate();
            me.tmach.enableUpdate();
            me.tspeed.enableUpdate();
            me.targetHdg.enableUpdate();
            me.targetCrs.enableUpdate();
		},
		enter: func {
			printDebug("Enter ",me.name~" on ",me.device.name);
			if (me.isNew) {
				me.setup();
				me.isNew = 0;
			}
			me.device.resetControls();
			me.device.controls["OSB18"].setControlText("MENU");

		},
		controlAction: func (controlName) {
			printDebug(me.name,": ",controlName," activated on ",me.device.name);
		},
		update: func (noti = nil) {
		    me.altimeterPressure.updateText(sprintf("%.2f", noti.getproper("inhg")));
		    me.airspeed.updateText(sprintf("%d", noti.getproper("ias")));
		    me.altitude_1k.updateText(sprintf("%d", noti.getproper("alt_ft") / 1000)); # XXxxx
		    #me.altitude.setText(sprintf("%03d", math.fmod(noti.getproper("alt_ft"), 1000)));  # xxXXX
		    me.altitude.updateText(sprintf("%02d0", math.fmod(noti.getproper("alt_ft"), 1000) / 10));  # xxXX0
		    me.taltitude_1k.updateText(sprintf("%d", noti.getproper("targetAltitude") / 1000)); # XXxxx
		    me.taltitude.updateText(sprintf("%02d0", math.fmod(noti.getproper("targetAltitude"), 1000) / 10));  # xxXX0
            me.gravity.updateText(sprintf("%.1f", noti.getproper("Nz")));
            me.hdg.updateText(sprintf("%03d", noti.getproper("heading")));

            # If <1 we want to hide the leading 0, but sprintf doesn't support that directly
            me.mach.updateText(me.machFunc(sprintf("%.2f/", noti.getproper("mach"))));
            me.tmach.updateText(me.machFunc(sprintf("%.2f", noti.getproper("targetMach"))));

            # ASI is about 116px per 10deg of pitch
		    #me.asi.setTranslation(0, noti.getproper("pitch")*11.6);
		    me.ladder.setTranslation(0, noti.getproper("pitch")*11.6);
            me.ground.setTranslation(0, noti.getproper("pitch")*11.6);
            me.horizon.setTranslation(0, noti.getproper("pitch")*11.6);
		    #me.asiTicks.setTranslation(0, noti.getproper("pitch")*11.6);
		    #me.asi.setCenter(0, noti.getproper("pitch")*11.6);
		    me.asi.setRotation(-noti.getproper("roll")*D2R);
		    #me.roll_pointer.setRotation(-noti.getproper("roll")*D2R);
		    me.roll_pointer.setRotation(-math.clamp(noti.getproper("roll"), -45, 45)*D2R);
		    #print(me.roll_pointer.getCenter());
		    me.tspeed.updateText(sprintf("%d", noti.getproper("targetSpeed")));

            me.fpmIndicator.setTranslation(0, -math.clamp(math.clamp(noti.getproper("vFpm"), -1000, 1000) + noti.getproper("vFpm"), -4000, 4000) / 1000 * 35);
            me.gforce.setTranslation(0, (noti.getproper("Nz")-1)*29);
            me.speed.setTranslation(0, (noti.getproper("ias")-50)/20*28);

		    # HSI
		    me.targetHdg.updateText(sprintf("%03d", noti.getproper("APHeadingBug")));
		},
		exit: func {
			printDebug("Exit ",me.name~" on ",me.device.name);
		},
		links: {
			"OSB18": "PageTMenu",
		},
		layers: [],
	},

                                                                        
# 888888b.   888             d8888 888b    888 888    d8P  
# 888  "88b  888            d88888 8888b   888 888   d8P   
# 888  .88P  888           d88P888 88888b  888 888  d8P    
# 8888888K.  888          d88P 888 888Y88b 888 888d88K     
# 888  "Y88b 888         d88P  888 888 Y88b888 8888888b    
# 888    888 888        d88P   888 888  Y88888 888  Y88b   
# 888   d88P 888       d8888888888 888   Y8888 888   Y88b  
# 8888888P"  88888888 d88P     888 888    Y888 888    Y88b

	PageBlank: {
		name: "PageBlank",
		isNew: 1,
		supportSOI: 0,
		needGroup: 1,
		new: func {
			me.instance = {parents:[DisplaySystem.PageBlank]};
			me.instance.group = nil;
			return me.instance;
		},
		setup: func {
			printDebug(me.name," on ",me.device.name," is being setup");
			me.pageText = me.group.createChild("text")
				.set("z-index", 10)
				.setColor(colorText1)
				.setAlignment("center-center")
				.setTranslation(displayWidthHalf, displayHeightHalf)
				.setFontSize(me.device.fontSize*3)
				.setText("OFF");
		},
		enter: func {
			printDebug("Enter ",me.name~" on ",me.device.name);
			if (me.isNew) {
				me.setup();
				me.isNew = 0;
			}
			me.device.resetControls();
			me.device.controls["OSB18"].setControlText("MENU");
		},
		controlAction: func (controlName) {
			printDebug(me.name,": ",controlName," activated on ",me.device.name);
            if (controlName == "OSB16") {
                me.device.swap();
            }
		},
		update: func (noti = nil) {			
		},
		exit: func {
			printDebug("Exit ",me.name~" on ",me.device.name);
		},
		links: {
			"OSB17": "PageBlank",
			"OSB18": "PageTMenu",
		},
		layers: [],
	},



#  ███████ ███    ██ ██████       ██████  ███████     ██████   █████   ██████  ███████ ███████ 
#  ██      ████   ██ ██   ██     ██    ██ ██          ██   ██ ██   ██ ██       ██      ██      
#  █████   ██ ██  ██ ██   ██     ██    ██ █████       ██████  ███████ ██   ███ █████   ███████ 
#  ██      ██  ██ ██ ██   ██     ██    ██ ██          ██      ██   ██ ██    ██ ██           ██ 
#  ███████ ██   ████ ██████       ██████  ██          ██      ██   ██  ██████  ███████ ███████ 
#                                                                                              
#                                                                                              

};

var flyupTime = 0;
var flyupVis = 0;
# updateFlyup = func(notification=nil) {
#     #if (me.current_page != nil) {
#         flyupTime = getprop("instrumentation/radar/time-till-crash");
#         if (flyupTime != nil and flyupTime > 0 and flyupTime < 8) {
#             flyupVis = math.mod(getprop("sim/time/elapsed-sec"), 0.50) < 0.25;
#         } else {
#             flyupVis = 0;
#         }
#         leftPFD.pullUpCue(flyupVis);
#         leftMFD.pullUpCue(flyupVis);
#     #}
# }

# Cursor stuff
var cursor_pos = [100,-100];
var cursor_posHAS = [0,-256];
var cursor_pos_hsd = [0, -50];
var cursor_click = -1;
var cursor_lock = -1;
var slew_c = 0;
var exp = 0;
var fcrModeChange = 0;
var cursorFCRgps = nil;
var cursorFCRair = 1;


setlistener("controls/displays/cursor-click", func (node) {if (node.getValue()) {slew_c = 1;}},0,0);

var cursorZero = func {
    cursor_pos = [0,-256];
}
cursorZero();

var hsdShowNAV1 = 1;
var hsdShowDLINK = 1;
var hsdShowRINGS = 1;
var hsdShowPRE = 1;
var hsdShowFCR = 1;

var fcrFrz = 0;
var fcrBand = 0;
var fcrChan = 2;

var flirMode = -2;
var tfrMode  =  1;
var tfrFreq  =  1;
var tfr_current_terr = 1000;
var tfr_range_m = 1000;
var tfr_target_altitude_m = 0;

var leftPFD = nil;
var leftMFD = nil;
var rightPFD = nil;
var rightMFD = nil;

var swapAircraftSOI = func (soi) {
	if (soi != nil) {
		f16.SOI = soi;
	}
}

var B1MfdRecipient =
{
    new: func(_ident)
    {
        var new_class = emesary.Recipient.new(_ident~".MFD");

        new_class.Receive = func(notification)
        {
            if (notification == nil)
            {
                print("bad notification nil");
                return emesary.Transmitter.ReceiptStatus_NotProcessed;
            }

            if (notification.NotificationType == "FrameNotification")
            {
                leftPFD.update(notification);
                leftMFD.update(notification);
                rightPFD.update(notification);
                rightMFD.update(notification);
                return emesary.Transmitter.ReceiptStatus_OK;
            }
            return emesary.Transmitter.ReceiptStatus_NotProcessed;
        };
        new_class.del = func {
        	emesary.GlobalTransmitter.DeRegister(me);
        };
        return new_class;
    },
};
var B1_display = nil;

var displayWidth     = 512;#552 * 0.795;
var displayHeight    = 1024;#482 * 1;
var displayWidthHalf = displayWidth  *  0.5;
var displayHeightHalf= displayHeight  *  0.5;

var forcePages = func (v, system) {
	if (v == 0) {
        system.selectPage("PageBlank");
    } elsif (v == 1) {
        system.selectPage("PagePFD1");
    }
}

var main = func (module) {
	# TEST CODE:
	var height = 1024;#482;
	var width  = 768;#552;

	leftPFD = DisplayDevice.new("leftPFD", [width,height], [1, 1], "MFD1_Canvas", "Front_MFD1_Canvas.png");
	leftPFD.setColorBackground(rightPFDColorBackground);

	leftMFD = DisplayDevice.new("LeftMFD", [width,height], [1, 1], "MFD2_Canvas", "Front_MFD1_Canvas.png");
	leftMFD.setColorBackground(rightPFDColorBackground);

	rightPFD = DisplayDevice.new("RightPFD", [width,height], [1, 1], "MFD3_Canvas", "Front_MFD1_Canvas.png");
	rightPFD.setColorBackground(rightPFDColorBackground);

	rightMFD = DisplayDevice.new("RightMFD", [width,height], [1, 1], "MFD4_Canvas", "Front_MFD1_Canvas.png");
	rightMFD.setColorBackground(rightPFDColorBackground);

	leftPFD.setControlTextColors(colorText1, rightPFDColorBackground);
	leftMFD.setControlTextColors(colorText1, rightPFDColorBackground);
	rightPFD.setControlTextColors(colorText1, rightPFDColorBackground);
	rightMFD.setControlTextColors(colorText1, rightPFDColorBackground);

	width *= 1;#0.795;

	var osbPositions = [
		[0, 0.9*height/7],
		[0, 1.65*height/7],
		[0, 2.45*height/7],
		[0, 3.2*height/7],
		[0, 4.0*height/7],
		[0, 4.77*height/7],
		[0, 5.55*height/7],
		[0, 6.28*height/7],

		[width, 0.9*height/7],
		[width, 1.65*height/7],
		[width, 2.45*height/7],
		[width, 3.2*height/7],
		[width, 4.0*height/7],
		[width, 4.77*height/7],
		[width, 5.55*height/7],
		[width, 6.28*height/7],


		[0.95*width/7, 0],
		[1.95*width/7, 0],
		[2.95*width/7, 0],
		[3.95*width/7, 0],
		[4.95*width/7, 0],
		[5.95*width/7, 0],

		[0.95*width/7, height],
		[1.95*width/7, height],
		[2.95*width/7, height],
		[3.95*width/7, height],
		[4.95*width/7, height],
		[5.95*width/7, height],
	];


	var mfdSystem1 = DisplaySystem.new();
	var mfdSystem2 = DisplaySystem.new();
	var mfdSystem3 = DisplaySystem.new();
	var mfdSystem4 = DisplaySystem.new();

	leftPFD.setDisplaySystem(mfdSystem1);
	leftMFD.setDisplaySystem(mfdSystem2);
	rightPFD.setDisplaySystem(mfdSystem3);
	rightMFD.setDisplaySystem(mfdSystem4);

	mfdSystem1.initDevice(0, osbPositions, font.device.main);
	mfdSystem2.initDevice(1, osbPositions, font.device.main);
	mfdSystem3.initDevice(2, osbPositions, font.device.main);
	mfdSystem4.initDevice(3, osbPositions, font.device.main);

	leftPFD.addControlFeedback();
	leftMFD.addControlFeedback();
	rightPFD.addControlFeedback();
	rightMFD.addControlFeedback();

	mfdSystem1.initPages();
	mfdSystem2.initPages();
	mfdSystem3.initPages();
	mfdSystem4.initPages();

	forcePages(1, mfdSystem1);
	forcePages(0, mfdSystem2);
	forcePages(1, mfdSystem3);
	forcePages(0, mfdSystem4);

	B1_display = B1MfdRecipient.new("B1-displaySystem");
	emesary.GlobalTransmitter.Register(B1_display);
}

#var theMaster = nil;

var unload = func {
	if (leftPFD != nil) {
		leftPFD.del();
		leftPFD = nil;
	}
	if (leftMFD != nil) {
		leftMFD.del();
		leftMFD = nil;
	}
	if (rightPFD != nil) {
		rightPFD.del();
		rightPFD = nil;
	}
	if (rightMFD != nil) {
		rightMFD.del();
		rightMFD = nil;
	}
	DisplayDevice = nil;
	DisplaySystem = nil;

	B1_display.del();
}

var displayDebug = 0;
var printDebug = func {if (displayDebug) {call(print,arg,nil,nil,var err = []); if(size(err)) print (err[0]);}};
var printfDebug = func {if (displayDebug) {var str = call(sprintf,arg,nil,nil,var err = []);if(size(err))print (err[0]);else print (str);}};
# Note calling printf directly with call() will sometimes crash the sim, so we call sprintf instead.


# main(nil);# disable this line if running as module