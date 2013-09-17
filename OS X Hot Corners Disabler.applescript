---------------------------------------------------
-- OS X Hot Corners Disabler
-- Version 1.5
--
-- Copyright © 2013 Bartosz Kaszewczuk
-- Released under the MIT license
--
-- Date: 27 August 2013
---------------------------------------------------

-- //=================================================================
-- // This script allows for disabling OS X Hot Corners during app runtime
-- // It can be set up to work with apps that use dynamically changing path as well as with those that use static path
-- //  
-- // !! If your hot corners settings are not recovered then app most likely uses some kind of launcher	!!
-- // !! In that case paste in the exact path to a launcher that is located within the *.app file			!!
-- //=================================================================

-- Set to TRUE to look for application each time and automatically update its current location. 
-- Set to FALSE to use static path to application.
set appAutoPathUpdate to true

-- Enter application name (required if appAutoPathUpdate is set to TRUE)
set appAutoName to "LoLLauncher.app"

-- Where to look for the application? (required if appAutoPathUpdate is set to TRUE)
set appAutoLocationToSearch to "/Applications/'.League of Legends.app'/"

-- Static application path (required if appAutoPathUpdate is set to FALSE)
set appStaticPath to "/Applications/.League of Legends.app/Contents/LoL/RADS/projects/lol_launcher/releases/0.0.0.97/deploy/LoLLauncher.app" -- 

--------------------------------------------------------------------------------------------------------
--------------------------- ! No settings to be changed below this line ! ---------------------------
--------------------------------------------------------------------------------------------------------

-- Determine path to app
if appAutoPathUpdate is true then
	set pathApp to get (do shell script "mdfind  -onlyin " & appAutoLocationToSearch & " '(kMDItemFSName == " & appAutoName & ")'")
else
	set pathApp to appStaticPath
end if

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
