//
//  SwiftKIFTestCase.swift
//  RealmToDo
//
//  found here: http://www.bradheintz.com/ios/2014/06/13/tutorial-kif-in-swift-part-2/
//
//  Created by Tobias Conradi on 29.09.14.
//  Copyright (c) 2014 Piet Brauer. All rights reserved.
//

import Foundation

class SwiftKIFTestCase: KIFTestCase {
    func tester(_ file : String = __FILE__, _ line : Int = __LINE__) -> KIFUITestActor {
        return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }
}