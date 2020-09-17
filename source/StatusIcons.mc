using Toybox.System;
using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.Time.Gregorian;
using Toybox.Time;
using Toybox.Lang as Lang;
using Toybox.ActivityMonitor;
using Toybox.Math;
using Toybox.Application;

module StatusIcons {

	var settings = System.getDeviceSettings();
	var isConnected = settings.phoneConnected;
	var alarmEnabled = settings.alarmCount > 0;
	var doNotDisturb = settings.doNotDisturb;
	var hasNotification = settings.notificationCount > 0;
	
	var phoneIcon = WatchUi.loadResource(Rez.Drawables.PhoneIcon);
	var alarmIcon = WatchUi.loadResource(Rez.Drawables.AlarmIcon);
	var notificationIcon = WatchUi.loadResource(Rez.Drawables.NotificationIcon);
	var doNotDisturbIcon = WatchUi.loadResource(Rez.Drawables.DoNotDisturbIcon);
	
	var icons = new [4];

	function drawIcons(dc) {
	
		var numberToDisplay = 0;
	
		if (isConnected) {
			icons[numberToDisplay] = phoneIcon;
			numberToDisplay++;
		}
		if (alarmEnabled) {
			icons[numberToDisplay] = alarmIcon;
			numberToDisplay++;
		}
		if (doNotDisturb) {
			icons[numberToDisplay] = doNotDisturbIcon;
			numberToDisplay++;
		}
		if (hasNotification) {
			icons[numberToDisplay] = notificationIcon;
			numberToDisplay++;
		}
		
		if (numberToDisplay == 1) {
			dc.drawBitmap(dc.getWidth() / 2 - 5, dc.getHeight() - 10, icons[0]);
		} else if (numberToDisplay == 2) {
		
			var x = dc.getWidth() / 2 - 12;
			dc.drawBitmap(x, getYOnCircle(x, dc.getWidth() / 2) - 10, icons[0]);
			dc.drawBitmap(x + 14, getYOnCircle(x, dc.getWidth() / 2) - 10, icons[1]);
			
		} else if (numberToDisplay == 3) {
			
			var x = dc.getWidth() / 2;
			dc.drawBitmap(x - 5, dc.getHeight() - 10, icons[0]);
			dc.drawBitmap(x - 20, getYOnCircle(x - 20, dc.getWidth() / 2) - 10, icons[1]);
			dc.drawBitmap(x + 10, getYOnCircle(x + 10, dc.getWidth() / 2) - 10, icons[2]);
			
		} else if (numberToDisplay == 4) {
			
			var x = dc.getWidth() / 2;
			dc.drawBitmap(x - 24, getYOnCircle(x - 24, dc.getWidth() / 2) - 10, icons[0]);
			dc.drawBitmap(x - 12, getYOnCircle(x - 12, dc.getWidth() / 2) - 10, icons[1]);
			dc.drawBitmap(x + 2, getYOnCircle(x + 2, dc.getWidth() / 2) - 10, icons[2]);
			dc.drawBitmap(x + 14, getYOnCircle(x + 14, dc.getWidth() / 2) - 10, icons[3]);
			
		}
	
	}
	
	function getYOnCircle(x, radius) {
		x = x - radius;
		var y = Math.sqrt((radius * radius) - (x * x));
		return y + radius;
	}

}