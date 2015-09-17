//
//  AppDelegate.swift
//  LauncherApplication
//
//  Created by Tibor Bodecs on 2015. 09. 17..
//  Copyright © 2015. Tibor Bodecs. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate
{

	func applicationDidFinishLaunching(aNotification: NSNotification) {
		
        let mainAppIdentifier = "com.tiborbodecs.MainApplication"
        let running           = NSWorkspace.sharedWorkspace().runningApplications
        var alreadyRunning    = false

		for app in running {
			if app.bundleIdentifier == mainAppIdentifier {
				alreadyRunning = true
				break
			}
		}
		
		if !alreadyRunning {
			NSDistributedNotificationCenter.defaultCenter().addObserver(self, selector: "terminate", name: "killme", object: mainAppIdentifier)

			let path = NSBundle.mainBundle().bundlePath as NSString
			var components = path.pathComponents
			components.removeLast()
			components.removeLast()
			components.removeLast()
			components.append("MacOS")
			components.append("MainApplication") //main app name

			let newPath = NSString.pathWithComponents(components)

			NSWorkspace.sharedWorkspace().launchApplication(newPath)
		}
		else {
			self.terminate()
		}
	}

	func terminate() {
//		NSLog("I'll be back!")
		NSApp.terminate(nil)
	}

}

