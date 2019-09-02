#################################################################################
#		Lake of Constance Hangar												#
#		Boeing 707 for Flightgear												#
#		Copyright (C) 2013 M.Kraus												#	
#																				#
#		This program is free software: you can redistribute it and/or modify	#
#		it under the terms of the GNU General Public License as published by	#
#		the Free Software Foundation, either version 3 of the License, or		#
#		(at your option) any later version.										#
#																				#
#		This program is distributed in the hope that it will be useful,			#
#		but WITHOUT ANY WARRANTY; without even the implied warranty of			#
#		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the			#
#		GNU General Public License for more details.							#
#																				#
#		You should have received a copy of the GNU General Public License		#
#		along with this program.  If not, see <http://www.gnu.org/licenses/>.	#
#																				#
#		Every software has a developer, also free software. 					#
#		As a gesture of courtesy and respect, I would be delighted 				#		
#		if you contacted me before making any changes to this software. 		#
#		<info (at) marc-kraus.de> April, 2017									#
#################################################################################
###################### from the brakesystem.nas #####################

setlistener("gear/brake-smoke", func (brakesmoke){
	var brakesmoke = brakesmoke.getValue() or 0;
	if(brakesmoke){
		setprop("controls/special/tyresmoke", 2);
	}else{
		setprop("controls/special/tyresmoke", 0);
	}
},1,0);

setlistener("gear/gear[0]/wow", func (wow_0){
	setprop("autopilot/switches/ap", 0);
	var wow_0 = wow_0.getValue() or 0;
	var state = props.globals.getNode("controls/special/tyresmoke");
	var ias = getprop("instrumentation/airspeed-indicator/indicated-speed-kt") or 0;
	if(wow_0 and ias > 100){
		setprop("controls/special/tyresmoke", 3);
		settimer( func { setprop("controls/special/tyresmoke",0); }, 2);
	}
},1,0);

setlistener("gear/gear[1]/wow", func (wow_1){
	setprop("autopilot/switches/ap", 0);
	var wow_1 = wow_1.getValue() or 0;
	var state = props.globals.getNode("controls/special/tyresmoke");
	var ias = getprop("instrumentation/airspeed-indicator/indicated-speed-kt") or 0;
	if(wow_1 and ias > 100){
	  var state_nr = (state.getValue() > 2) ? 3 : 2;
	  state.setValue(state_nr);
		settimer( func { setprop("controls/special/tyresmoke",0); }, 2);
	}
},1,0);


