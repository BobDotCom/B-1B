# FlightGear loads this file as the single reloadable `displays` module.
# It selects only the Block D or Block E page set needed by the current variant,
# then owns all device construction, recipients, listeners, and cleanup.

io.include("config.nas");

io.include("core/controls.nas");
io.include("core/page.nas");
io.include("core/system.nas");
io.include("core/device.nas");

io.include("pages/Common/PageOSB.nas");
io.include("pages/Common/PageBlank.nas");
if (DISPLAY_IS_BLOCK_E) {
	io.include("pages/BlockE/PageTMenu.nas");
	io.include("pages/BlockE/PageSMS1.nas");
	io.include("pages/BlockE/PagePFD1.nas");
} else {
	io.include("pages/BlockD/PageInit.nas");
}

var flyupTime = 0;
var flyupVis = 0;

var cursor_pos = [100, -100];
var cursor_posHAS = [0, -256];
var cursor_pos_hsd = [0, -50];
var cursor_click = -1;
var cursor_lock = -1;
var slew_c = 0;
var exp = 0;
var fcrModeChange = 0;
var cursorFCRgps = nil;
var cursorFCRair = 1;

var hsdShowNAV1 = 1;
var hsdShowDLINK = 1;
var hsdShowRINGS = 1;
var hsdShowPRE = 1;
var hsdShowFCR = 1;

var fcrFrz = 0;
var fcrBand = 0;
var fcrChan = 2;

var flirMode = -2;
var tfrMode = 1;
var tfrFreq = 1;
var tfr_current_terr = 1000;
var tfr_range_m = 1000;
var tfr_target_altitude_m = 0;

var leftPFD = nil;
var leftMFD = nil;
var rightPFD = nil;
var rightMFD = nil;
var displayDevices = {};
var displayListeners = [];
var B1_display = nil;

var displayDebug = 0;
var printDebug = func {
	if (displayDebug) {
		call(print, arg, nil, nil, var err = []);
		if (size(err)) print(err[0]);
	}
};
var printfDebug = func {
	if (displayDebug) {
		var str = call(sprintf, arg, nil, nil, var err = []);
		if (size(err)) print(err[0]);
		else print(str);
	}
};

var cursorZero = func {
	cursor_pos = [0, -256];
};

var swapAircraftSOI = func (soi) {
	if (soi != nil) f16.SOI = soi;
};

var registerDisplayPages = func (module) {
	DisplayPageRegistry.reset();
	var namespace = module.getNamespace();
	foreach (var pageName; DISPLAY_PAGE_IDS) {
		var page = namespace[pageName];
		if (page == nil) die("Display page is not defined: " ~ pageName);
		DisplayPageRegistry.register(page);
	}
};

var forcePages = func (selector, system) {
	system.selectPage(selector == 0 ? DISPLAY_PAGE_SELECTOR.off : DISPLAY_PAGE_SELECTOR.on);
};

var assignPublicDevice = func (slot, device) {
	if (slot == "leftPFD") leftPFD = device;
	elsif (slot == "leftMFD") leftMFD = device;
	elsif (slot == "rightPFD") rightPFD = device;
	elsif (slot == "rightMFD") rightMFD = device;
};

var clearPublicDevices = func {
	leftPFD = nil;
	leftMFD = nil;
	rightPFD = nil;
	rightMFD = nil;
};

var buildOsbPositions = func (width, height) {
	return [
		[0, 0.9 * height / 7],
		[0, 1.65 * height / 7],
		[0, 2.45 * height / 7],
		[0, 3.2 * height / 7],
		[0, 4.0 * height / 7],
		[0, 4.77 * height / 7],
		[0, 5.55 * height / 7],
		[0, 6.28 * height / 7],
		[width, 0.9 * height / 7],
		[width, 1.65 * height / 7],
		[width, 2.45 * height / 7],
		[width, 3.2 * height / 7],
		[width, 4.0 * height / 7],
		[width, 4.77 * height / 7],
		[width, 5.55 * height / 7],
		[width, 6.28 * height / 7],
		[0.95 * width / 7, 0],
		[1.95 * width / 7, 0],
		[2.95 * width / 7, 0],
		[3.95 * width / 7, 0],
		[4.95 * width / 7, 0],
		[5.95 * width / 7, 0],
		[0.95 * width / 7, height],
		[1.95 * width / 7, height],
		[2.95 * width / 7, height],
		[3.95 * width / 7, height],
		[4.95 * width / 7, height],
		[5.95 * width / 7, height],
	];
};

var B1MfdRecipient = {
	new: func (_ident) {
		var recipient = emesary.Recipient.new(_ident ~ ".MFD");
		recipient.Receive = func (notification) {
			if (notification == nil) {
				print("bad notification nil");
				return emesary.Transmitter.ReceiptStatus_NotProcessed;
			}
			if (notification.NotificationType == "FrameNotification") {
				foreach (var deviceConfig; DISPLAY_DEVICES) {
					var device = displayDevices[deviceConfig.slot];
					if (device != nil) device.update(notification);
				}
				return emesary.Transmitter.ReceiptStatus_OK;
			}
			return emesary.Transmitter.ReceiptStatus_NotProcessed;
		};
		recipient.del = func {
			emesary.GlobalTransmitter.DeRegister(me);
		};
		return recipient;
	},
};

var buildDisplays = func {
	var osbPositions = buildOsbPositions(displayWidth, displayHeight);
	displayDevices = {};
	clearPublicDevices();

	foreach (var deviceConfig; DISPLAY_DEVICES) {
		var device = DisplayDevice.new(
			deviceConfig.name,
			[displayWidth, displayHeight],
			DISPLAY_UV_MAP,
			deviceConfig.placementNode,
			deviceConfig.texture
		);
		device.setColorBackground(rightPFDColorBackground);
		device.setControlTextColors(colorText1, rightPFDColorBackground);

		var system = DisplaySystem.new();
		device.setDisplaySystem(system);
		system.initDevice(deviceConfig.propertyIndex, osbPositions, font.device.main);
		device.addControlFeedback();
		system.initPages();
		forcePages(deviceConfig.initialSelector, system);

		displayDevices[deviceConfig.slot] = device;
		assignPublicDevice(deviceConfig.slot, device);
	}

	B1_display = B1MfdRecipient.new("B1-displaySystem");
	emesary.GlobalTransmitter.Register(B1_display);
};

var main = func (module) {
	print("DISPLAYS LOADING");
	if (DISPLAY_IS_BLOCK_E) setprop(DISPLAY_RUNTIME_PROPERTY_PATHS.electricalOutput, 1);
	cursorZero();
	registerDisplayPages(module);

	displayListeners = [];
	append(displayListeners, setlistener(DISPLAY_RUNTIME_PROPERTY_PATHS.cursorClick, func (node) {
		if (node.getValue()) slew_c = 1;
	}, 0, 0));

	buildDisplays();
};

var unload = func {
	if (B1_display != nil) {
		B1_display.del();
		B1_display = nil;
	}

	foreach (var deviceConfig; DISPLAY_DEVICES) {
		var device = displayDevices[deviceConfig.slot];
		if (device != nil) device.del();
	}
	displayDevices = {};
	clearPublicDevices();

	# modules.Module removes its tracked listeners before calling unload().
	displayListeners = [];
};
