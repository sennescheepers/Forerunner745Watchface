using Toybox.System;
using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.Time.Gregorian;
using Toybox.Time;
using Toybox.Lang as Lang;
using Toybox.ActivityMonitor;
using Toybox.Math;
using Toybox.Application;

module BatteryText {

	function drawBattery(label, locX, locY) {
		
		// Get battery information
		var stats = System.getSystemStats();
		var battery = (stats != null) ? stats.battery.toNumber() : 0;
		var batteryString = Lang.format("BAT: $1$%", [battery]);
		
		// Set text
		label.setColor(Graphics.COLOR_WHITE);
		label.setFont(Graphics.FONT_TINY);
		label.setText(batteryString);
		label.setLocation(locX, locY + 3);
		
	}

}