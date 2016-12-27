//
//  AppDelegate.swift
//  LauncherApplication
//
//  Created by Tibor Bodecs on 2015. 09. 17..
//  Copyright © 2015. Tibor Bodecs. All rights reserved.
//

import Cocoa

extension Notification.Name {
    static let killme = Notification.Name("killme")
}


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate
{

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		
        let mainAppIdentifier = "com.tiborbodecs.MainApplication"
        let running           = NSWorkspace.shared().runningApplications
        var alreadyRunning    = false

		for app in running {
			if app.bundleIdentifier == mainAppIdentifier {
				alreadyRunning = true
				break
			}
		}
		
		if !alreadyRunning {
            DistributedNotificationCenter.default().addObserver(self, selector: #selector(self.terminate), name: .killme, object: mainAppIdentifier)

			let path = Bundle.main.bundlePath as NSString
			var components = path.pathComponents
			components.removeLast()
			components.removeLast()
			components.removeLast()
			components.append("MacOS")
			components.append("MainApplication") //main app name

			let newPath = NSString.path(withComponents: components)

			NSWorkspace.shared().launchApplication(newPath)
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

