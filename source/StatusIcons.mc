using Toybox.System;
using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.Lang as Lang;
using Toybox.ActivityMonitor;
using Toybox.Math;
using Toybox.Application;

module StatusIcons {

	/*
	*
	* Shittiest code you'll ever see, please dont judge me.
	*
	*/

	var left;
	var right;

	var _dc;
	var bigFontHeight;
	var smallFontHeight;
	//var bigFont = WatchUi.loadResource(Rez.Fonts.big_filled_font);
	//var smallFont = Graphics.FONT_SMALL;
	//var iconFont = WatchUi.loadResource(Rez.Fonts.icon_font);
	var iconHeight;
	
	var phoneIcon = "A";
	var alarmIcon = "C";
	var notificationIcon = "H";
	var doNotDisturbIcon = "G";
	
	var settings;
	
	var isConnected;
	var alarmEnabled;
	var doNotDisturb;
	var notificationCount;
	
	var showConnected;
	var showNotifications;
	var showAlarm;
	var showDoNotDisturb;
	
	var numberToDisplay;
	var icons;

	function drawIcons(dc) {
	
		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
	
		settings = System.getDeviceSettings();
	
		isConnected = settings.phoneConnected;
		alarmEnabled = settings.alarmCount > 0;
		doNotDisturb = (settings has :doNotDisturb) ? settings.doNotDisturb : false;
		notificationCount = settings.notificationCount;
	
		numberToDisplay = 0;
		icons = new [4];
	
		_dc = dc;
		bigFontHeight = dc.getFontHeight(Fonts.bigFilledFont);
		smallFontHeight = dc.getFontHeight(Graphics.FONT_SMALL);
		iconHeight = dc.getFontHeight(Fonts.iconFont);
	
		if (isConnected && showConnected) {
			icons[numberToDisplay] = phoneIcon;
			numberToDisplay++;
		}
		if (alarmEnabled && showAlarm) {
			icons[numberToDisplay] = alarmIcon;
			numberToDisplay++;
		}
		if (doNotDisturb && showDoNotDisturb) {
			icons[numberToDisplay] = doNotDisturbIcon;
			numberToDisplay++;
		}
		if (notificationCount > 0 && showNotifications) {
			icons[numberToDisplay] = notificationIcon;
			numberToDisplay++;
		}
		
		var textWidths = new [icons.size()];
			
		// Get width of each icon
		for (var i = 0; i < icons.size(); i++) {
			if (icons[i] != null) {textWidths[i] = dc.getTextWidthInPixels(icons[i], Fonts.iconFont);}
		}
		
		if (left) {
			// Draw icons
			for (var i = 0; i < numberToDisplay; i++) {
				// Get locX
				var locX = dc.getWidth() / 2 - 10 - ((numberToDisplay - i) * 2);
				for (var j = 0; j < numberToDisplay - i; j++) {
					locX -= textWidths[j];
				}
				var locY = (dc.getHeight() - bigFontHeight) / 2 - 5;
				
				dc.drawText(locX, locY, Fonts.iconFont, icons[i], Graphics.TEXT_JUSTIFY_LEFT);
			}
		}
		
		if (right) {
			// Draw icons
			for (var i = 0; i < numberToDisplay; i++) {
				// Get locX
				var locX = dc.getWidth() / 2 + 10 + (i * 2);
				for (var j = 0; j < i; j++) {
					locX += textWidths[j];
				}
				var locY = (dc.getHeight() - bigFontHeight) / 2 - 5;
				
				dc.drawText(locX, locY, Fonts.iconFont, icons[i], Graphics.TEXT_JUSTIFY_LEFT);
			}
		
		}
		
		if (left || right || System.getDeviceSettings().screenHeight < 240) {return;}
		
		if (numberToDisplay == 1) {
			var textWidth = dc.getTextWidthInPixels(icons[0], Fonts.iconFont);
			var x = dc.getWidth() / 2 - textWidth / 2;
			dc.drawText(x, getY(x, dc.getHeight() / 2), Fonts.iconFont, icons[0], Graphics.TEXT_JUSTIFY_LEFT);
		} else if (numberToDisplay == 2) {
			var x = dc.getWidth() / 2;
			var iconWidths = [dc.getTextWidthInPixels(icons[0], Fonts.iconFont), dc.getTextWidthInPixels(icons[1], Fonts.iconFont)];
			dc.drawText(x - iconWidths[0] - 2, getY(x - iconWidths[0] - 2, dc.getHeight() / 2), Fonts.iconFont, icons[0], Graphics.TEXT_JUSTIFY_LEFT);
			dc.drawText(x + 2, getY(x - iconWidths[0] - 2, dc.getHeight() / 2), Fonts.iconFont, icons[1], Graphics.TEXT_JUSTIFY_LEFT);
			
		} else if (numberToDisplay == 3) {
			var iconWidths = [dc.getTextWidthInPixels(icons[0], Fonts.iconFont), dc.getTextWidthInPixels(icons[1], Fonts.iconFont), dc.getTextWidthInPixels(icons[2], Fonts.iconFont)];
			var x = dc.getWidth() / 2 - iconWidths[0] / 2;
			dc.drawText(x, getY(x, dc.getHeight() / 2), Fonts.iconFont, icons[0], Graphics.TEXT_JUSTIFY_LEFT);
			dc.drawText(x - iconWidths[1] - 2, getY(x - iconWidths[1] - 2, dc.getHeight() / 2), Fonts.iconFont, icons[1], Graphics.TEXT_JUSTIFY_LEFT);
			dc.drawText(x + 2 + iconWidths[0], getY(x - iconWidths[1] - 2, dc.getHeight() / 2), Fonts.iconFont, icons[2], Graphics.TEXT_JUSTIFY_LEFT);
			
		} else if (numberToDisplay == 4) {	
			var x = dc.getWidth() / 2;
			var iconWidths = [dc.getTextWidthInPixels(icons[0], Fonts.iconFont), dc.getTextWidthInPixels(icons[1], Fonts.iconFont), dc.getTextWidthInPixels(icons[2], Fonts.iconFont), dc.getTextWidthInPixels(icons[3], Fonts.iconFont)];
			dc.drawText(x - iconWidths[0] - iconWidths[1] - 4, getY(x - iconWidths[0] - iconWidths[1] - 4, dc.getHeight() / 2), Fonts.iconFont, icons[0], Graphics.TEXT_JUSTIFY_LEFT);
			dc.drawText(x - iconWidths[1] - 2, getY(x - iconWidths[1] - 2, dc.getHeight() / 2), Fonts.iconFont, icons[1], Graphics.TEXT_JUSTIFY_LEFT);
			dc.drawText(x + 2, getY(x - iconWidths[1] - 2, dc.getHeight() / 2), Fonts.iconFont, icons[2], Graphics.TEXT_JUSTIFY_LEFT);
			dc.drawText(x + 4 + iconWidths[2], getY(x - iconWidths[0] - iconWidths[1] - 4, dc.getHeight() / 2), Fonts.iconFont, icons[3], Graphics.TEXT_JUSTIFY_LEFT);
			
		}
	
	}
	
	function getY(x, radius) {
		x = x - radius;
		var y = Math.sqrt((radius * radius) - (x * x));
		return y + radius - iconHeight;
	}
	
	function setSettings() {
	
		left = Application.getApp().getProperty("LeftComplication") == 4;
		right = Application.getApp().getProperty("RightComplication") == 4;
		
		showConnected = Application.getApp().getProperty("ShowPhoneConnected");
		showNotifications = Application.getApp().getProperty("ShowNotifications");
		showAlarm = Application.getApp().getProperty("ShowAlarm");
		showDoNotDisturb = Application.getApp().getProperty("ShowDoNotDisturb");
	
	}

}