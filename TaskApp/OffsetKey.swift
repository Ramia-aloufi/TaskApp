//
//  OffsetKey.swift
//  TaskApp
//
//  Created by ramia n on 09/04/1445 AH.
//

import Foundation
import SwiftUI


struct OffsetKey:PreferenceKey{
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat ,nextValue:()->CGFloat){
        value = nextValue()
    }

}
