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
    }
        
	func testTakeScreenshots() {
		tester().tapViewWithAccessibilityLabel(localizedAccessibilityString("uibutton.navbar.add.button.title"), traits: UIAccessibilityTraitButton)
		
		tester().waitForKeyboard()
		tester().enterTextIntoCurrentFirstResponder(localizedString("UploadText"))
		
		
		tester().tapViewWithAccessibilityLabel(localizedAccessibilityString("done.button"))
		
		tester().waitForTimeInterval(0.5)
		
		
		tester().tapViewWithAccessibilityLabel(localizedString("TakeScreenshotsText"))
		
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
