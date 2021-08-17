//
//  ArrayExtensions.swift
//  ScorpCase
//
//  Created by Emre Büyüker on 17.08.2021.
//

import Foundation

extension Array {
    func filterDuplicate(_ keyValue:((AnyHashable...)->AnyHashable,Element)->AnyHashable) -> [Element] {
        func makeHash(_ params:AnyHashable ...) -> AnyHashable {
           var hash = Hasher()
           params.forEach{ hash.combine($0) }
           return hash.finalize()
        }
        var uniqueKeys = Set<AnyHashable>()
        return filter{uniqueKeys.insert(keyValue(makeHash,$0)).inserted}
    }
}
