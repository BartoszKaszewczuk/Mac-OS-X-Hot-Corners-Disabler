---------------------------------------------------
-- OS X Hot Corners Disabler
-- Version 1.1
--
-- Copyright © 2013 Bartosz Kaszewczuk
-- Released under the MIT license
--
-- Date: 27 August 2013
---------------------------------------------------


-- Define path to your app (or to app launcher if the app has one)
-- !! If your hot corners settings are not recovered then app most likely uses some kind of launcher	!! --
-- !! In that case paste in the exact path to a launcher that is located within the *.app file			!! --

set pathApp to "/Applications/League of Legends.app/Contents/LOL/RADS/projects/lol_launcher/releases/0.0.0.90/deploy/LoLLauncher.app" as text

--------------------------- ! No settings to be changed below this line ! ---------------------------

-- Launch app
tell application pathApp to launch

tell application "System Events" to tell expose preferences
	-- Backup all hot corners settings
	set topLeftSetting to get the activity of the top left screen corner
	set topRightSetting to get the activity of the top right screen corner
	set bottomLeftSetting to get the activity of the bottom left screen corner
	set bottomRightSetting to get the activity of the bottom right screen corner
	
	-- Clear all hot corners settings
	set activity of the top left screen corner to "none"
	set activity of the top right screen corner to "none"
	set activity of the bottom left screen corner to "none"
	set activity of the bottom right screen corner to "none"
end tell

-- Wait for app to launch
delay 5 -- Fail safe timer
repeat until application pathApp is running
	delay 1
end repeat

-- Keep waiting while app is running
repeat while application pathApp is running
	delay 1
end repeat

-- Restores all hot corners settings
tell application "System Events" to tell expose preferences
	set activity of the top left screen corner to topLeftSetting
	set activity of the top right screen corner to topRightSetting
	set activity of the bottom left screen corner to bottomLeftSetting
	set activity of the bottom right screen corner to bottomRightSetting
end tell
