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

	var bigFont = WatchUi.loadResource(Rez.Fonts.big_filled_font);
	var activityInfo = ActivityMonitor.getInfo();

    function initialize() {
        WatchFace.initialize();
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
    	dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
    	dc.clear();
    
    	// Display time
    	var hourLabel = View.findDrawableById("hourLabel");
    	var minutesLabel = View.findDrawableById("minutesLabel");
    	var secondsLabel = View.findDrawableById("secondsLabel");
    	TimeText.drawTime(dc, hourLabel, minutesLabel, secondsLabel);
        
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        
        // Display big complication
        // 0: Empty
        // 1: Weekly active minutes
        // 2: Daily steps/goal
        // 3: Daily burned ca && lories/goal
        // 4: Floors climbed/goal
        var bigComplication = Application.getApp().getProperty("BigComplication");
        if (bigComplication == 1 && activityInfo has :activeMinutesWeek) {
        	IntensityMinutesBar.drawBar(dc);
        } else if (bigComplication == 2) {
        	StepsBar.drawBar(dc);
        } else if (bigComplication == 3) {
        	CaloriesBar.drawBar(dc);
        } else if (bigComplication == 4 && activityInfo has :floorsClimbed) {
        	FloorsBar.drawBar(dc);
        }
        
        // Display left complicatoin
        // 0: Empty
        // 1: Date
        // 2: HR
        // 3: Todays distance
        // 4: Status icons
        // 5: Notification count
        // 6: Floors climbed
        // 7: Battery
        var leftComplication = Application.getApp().getProperty("LeftComplication");
        if (leftComplication == 1) {
        	DateText.drawDate(dc, 0);
        } else if (leftComplication == 2 && ActivityMonitor has :HeartRateIterator) {
        	HRText.drawHR(dc, 0);
        } else if (leftComplication == 3) {
        	DistanceText.drawDistance(dc, 0);
        } else if (leftComplication == 3) {
        	DistanceText.drawDistance(dc, 0);
        } else if (leftComplication == 5) {
        	NotificationsText.drawNotifications(dc, 0);
        } else if (leftComplication == 6 && ActivityMonitor.getInfo() has :floorsClimbed) {
        	FloorsText.drawFloors(dc, 0);
        } else if (leftComplication == 7) {
        	BatteryText.drawBattery(dc, 0);
        }
        
        // Display right complicatoin
        // 0: Empty
        // 1: Date
        // 2: HR
        // 3: Todays distance
 		// 4: Status icons
 		// 5: Notification count
 		// 6: Floors climbed
 		// 7: Battery
        var rightComplication = Application.getApp().getProperty("RightComplication");
        if (rightComplication == 1) {
        	DateText.drawDate(dc, 1);
        } else if (rightComplication == 2 && ActivityMonitor has :HeartRateIterator) {
        	HRText.drawHR(dc, 1);
        } else if (rightComplication == 3) {
        	DistanceText.drawDistance(dc, 1);
        } else if (rightComplication == 5) {
        	NotificationsText.drawNotifications(dc, 1);
        } else if (rightComplication == 6 && ActivityMonitor.getInfo() has :floorsClimbed) {
        	FloorsText.drawFloors(dc, 1);
        } else if (rightComplication == 7) {
        	BatteryText.drawBattery(dc, 1);
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

}
