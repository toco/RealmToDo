//
//  Screenshots.swift
//  Screenshots
//
//  Created by Tobias Conradi on 29.09.14.
//  Copyright (c) 2014 Piet Brauer. All rights reserved.
//

import UIKit
import XCTest
import Realm
import RealmToDo

class Screenshots: SwiftKIFTestCase {
    
    
    override func beforeAll() {
        resetDatabase()
		let screenshotGroupPath = __FILE__.stringByDeletingLastPathComponent.stringByDeletingLastPathComponent.stringByAppendingPathComponent("shots")
		TOCScreenshot.setScreenshotGroupFolderPath(screenshotGroupPath)
    }

    override func afterAll() {
        println("file://\(TOCScreenshot.screenshotGroupFolderPath())")
    }
        
	func testTakeScreenshots() {
		tester().tapViewWithAccessibilityLabel(localizedAccessibilityString("uibutton.navbar.add.button.title"), traits: UIAccessibilityTraitButton)
		
		tester().waitForKeyboard()
		tester().enterTextIntoCurrentFirstResponder(localizedString("UploadText"))
		
		TOCScreenshot.takeScreenshotNamed("1 CreateItem")

		tester().tapViewWithAccessibilityLabel(localizedAccessibilityString("done.button"))
		
		tester().waitForTimeInterval(0.5)
		        
		TOCScreenshot.takeScreenshotNamed("2 ItemList")

		
		tester().tapViewWithAccessibilityLabel(localizedString("TakeScreenshotsText"))
	
		TOCScreenshot.takeScreenshotNamed("3 DoneItem")

	}
	
	
// MARK: - Helpers
	
	func resetDatabase() {
		let realm = RLMRealm.defaultRealm()
		realm.transactionWithBlock { () -> Void in
			realm.deleteObjects(ToDoItem.allObjects())
			var item = ToDoItem()
			item.name = self.localizedString("TakeScreenshotsText")
			realm.addObject(item)
		}
	}
	
    func localizedString(key :String) -> String {
        return NSLocalizedString(key, bundle: NSBundle(forClass: Screenshots.self), comment: "")
    }
    
    func localizedAccessibilityString(key: String) -> String {
        let resourcePath = NSBundle(identifier: "com.apple.UIKit.axbundle").pathForResource(nil, ofType: "strings")!
        let localization = NSDictionary(contentsOfFile:resourcePath)
        return localization[key] as String

    }
}
