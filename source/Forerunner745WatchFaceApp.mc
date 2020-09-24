using Toybox.Application;
using Toybox.WatchUi;

class Forerunner745WatchFaceApp extends Application.AppBase {

	var view;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        view = new Forerunner745WatchFaceView();
        onSettingsChanged();
        return [view];
    }

    // New app settings have been received so trigger a UI update
    function onSettingsChanged() {
    
    	view.setSettings();
    
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
    	
        WatchUi.requestUpdate();
    }

}