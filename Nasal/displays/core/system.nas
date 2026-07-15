# Defines DisplaySystem, one page/navigation controller per B-1B display device.
# It instantiates registered pages, routes OSB actions, changes the current page,
# manages layers and page visibility, and runs page cleanup before Canvas teardown.
# This is shared display infrastructure, not code for any individual page.

var DisplaySystem = {
	new: func () {
		var system = {parents : [DisplaySystem] };
		system.new = func {return nil;};
		return system;
	},

	del: func {
		if (me["pages"] != nil) {
			foreach (var pageName; keys(me.pages)) {
				var page = me.pages[pageName];
				if (page["loopTimer"] != nil) {
					call(func page.loopTimer.stop(), [], nil, nil, var err = []);
					page.loopTimer = nil;
				}
				if (page["del"] != nil) {
					call(func page.del(), [], nil, nil, var err = []);
				}
			}
		}
		me.pages = {};
		me.layers = {};
		me.currPage = nil;
		me.device = nil;
	},

	setDevice: func (device) {
		me.device = device;
	},

	initDevice: func (propertyNum, controlPositions, fontSize) {
		me.device.addControls(PUSHBUTTON, "OSB", 1, 28, DISPLAY_CONTROL_PROPERTY_PATH(propertyNum), controlPositions);
		me.device.fontSize = fontSize;

		# B-1B numbering: OSB1..8 left, 9..16 right,
		# 17..22 top, and 23..28 bottom.
		for (var i = 1; i <= 8; i += 1) {
			me.device.addControlText("OSB", "OSB" ~ i, [margin.device.buttonText, 0], i - 1, -1);
		}
		for (var i = 9; i <= 16; i += 1) {
			me.device.addControlText("OSB", "OSB" ~ i, [-margin.device.buttonText, 0], i - 1, 1);
		}
		for (var i = 17; i <= 22; i += 1) {
			me.device.addControlText("OSB", "OSB" ~ i, [0, margin.device.buttonText], i - 1, 0, -1);
		}
		for (var i = 23; i <= 28; i += 1) {
			me.device.addControlText("OSB", "OSB" ~ i, [0, -margin.device.buttonText], i - 1, 0, 1);
		}
		me.device.addSOILines();
		me.device.addSOIText("NOT SOI");
		me.device.setSOI(-1);
	},

	getSOIPrio: func {
		return me.currPage.supportSOI?me.currPage.soiPrio:-1;
	},

	initPage: func (pageName) {
		if (DisplayPageRegistry.get(pageName) == nil) {print(pageName," does not exist");return;}
		me.tempPageInstance = DisplayPageRegistry.get(pageName).new();
		me.device.initPage(me.tempPageInstance);
		me.pages[me.tempPageInstance.name] = me.tempPageInstance;
	},

	initLayer: func (layerName) {
		me.tempLayerInstance = DisplayPageRegistry.get(layerName).new();
		me.device.initLayer(me.tempLayerInstance);
		me.layers[me.tempLayerInstance.name] = me.tempLayerInstance;
	},

	initPages: func () {
		me.pages = {};
		me.layers = {};

		foreach (var pageName; DISPLAY_INITIAL_PAGE_IDS) me.initPage(pageName);

		

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
#					me.system.selectPage(DISPLAY_PAGES.osb);
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

		append(me.device.listeners, setlistener(DISPLAY_RUNTIME_PROPERTY_PATHS.pageSelector, func(node) {
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
		me.device.setPageFrame(me.currPage.showFrame);
		#me.currPage.update(nil);
		foreach(var layer; me.currPage.layers) {
			me.fetchLayer(layer).group.show();
		}
	},
};
