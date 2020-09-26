using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Application;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.UserProfile;
using Toybox.ActivityMonitor;

class Forerunner745WatchFaceView extends WatchUi.WatchFace {

	var hasHeartRateIterator = ActivityMonitor.getInfo() has :HeartRateIterator;
	var hasFloorsClimbed = ActivityMonitor.getInfo() has :floorsClimbed;
	var hasActiveMinutesWeek = ActivityMonitor.getInfo() has :activeMinutesWeek;
	
	var bigComplication;
	var leftComplication;
	var rightComplication;

    function initialize() {
        WatchFace.initialize();
        
        setSettings();
        
        // Setting up the settings variables, may save some computing power in the long run
        StatusIcons.setSettings();
        TimeText.setSettings();
    	BatteryText.setSettings();
    	CaloriesBar.setSettings();
    	DistanceText.setSettings();
    	FloorsBar.setSettings();
    	FloorsText.setSettings();
    	IntensityMinutesBar.setSettings();
    	NotificationsText.setSettings();
    	StepsBar.setSettings();
    	MoveBar.setSettings();
    	StepsText.setSettings();
    	ActiveMinutesText.setSettings();
    	
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
    	// Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    
    	dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
    	dc.clear();
    
    	// Display time
    	TimeText.drawTime(dc);
        
        // Display big complication
        // 0: Empty
        // 1: Weekly active minutes
        // 2: Daily steps/goal
        // 3: Daily burned ca && lories/goal
        // 4: Floors climbed/goal
        // 5: Movebar
        if (bigComplication == 1 && hasActiveMinutesWeek) {
        	IntensityMinutesBar.drawBar(dc);
        } else if (bigComplication == 2) {
        	StepsBar.drawBar(dc);
        } else if (bigComplication == 3) {
        	CaloriesBar.drawBar(dc);
        } else if (bigComplication == 4 && hasFloorsClimbed) {
        	FloorsBar.drawBar(dc);
        } /*else if (bigComplication == 5) {
        	MoveBar.drawBar(dc);
        }*/
        
        // Display left and right complications
        // 0: Empty
        // 1: Date
        // 2: HR
        // 3: Todays distance
        // 4: Status icons
        // 5: Notification count
        // 6: Floors climbed
        // 7: Battery
        // 8: Steps
        // 9: Active minutes
        if (leftComplication == 1) {
        	DateText.drawDate(dc, 0);
        } else if (leftComplication == 2 && hasHeartRateIterator) {
        	HRText.drawHR(dc, 0);
        } else if (leftComplication == 3) {
        	DistanceText.drawDistance(dc, 0);
        } else if (leftComplication == 3) {
        	DistanceText.drawDistance(dc, 0);
        } else if (leftComplication == 5) {
        	NotificationsText.drawNotifications(dc, 0);
        } else if (leftComplication == 6 && hasFloorsClimbed) {
        	FloorsText.drawFloors(dc, 0);
        } else if (leftComplication == 7) {
        	BatteryText.drawBattery(dc, 0);
        } else if (leftComplication == 8) {
        	StepsText.drawText(dc, 0);
        } else if (leftComplication == 9 && hasActiveMinutesWeek) {
        	ActiveMinutesText.drawText(dc, 0);
        }
        
    	
        if (rightComplication == 1) {
        	DateText.drawDate(dc, 1);
        } else if (rightComplication == 2 && hasHeartRateIterator) {
        	HRText.drawHR(dc, 1);
        } else if (rightComplication == 3) {
        	DistanceText.drawDistance(dc, 1);
        } else if (rightComplication == 5) {
        	NotificationsText.drawNotifications(dc, 1);
        } else if (rightComplication == 6 && hasFloorsClimbed) {
        	FloorsText.drawFloors(dc, 1);
        } else if (rightComplication == 7) {
        	BatteryText.drawBattery(dc, 1);
        } else if (rightComplication == 8) {
        	StepsText.drawText(dc, 1);
        } else if (rightComplication == 9 && hasActiveMinutesWeek) {
        	ActiveMinutesText.drawText(dc, 1);
        }
        
        // Display status icons
        StatusIcons.drawIcons(dc);
        
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    	TimeText.lowPower = false;
    	WatchUi.requestUpdate();
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    	TimeText.lowPower = true;
    }
    
    function setSettings() {
    
    	bigComplication = Application.getApp().getProperty("BigComplication");
        leftComplication = Application.getApp().getProperty("LeftComplication");
        rightComplication = Application.getApp().getProperty("RightComplication");
    	
    }

}
