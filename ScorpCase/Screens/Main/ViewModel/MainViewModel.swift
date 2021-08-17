//
//  MainViewModel.swift
//  ScorpCase
//
//  Created by Emre Büyüker on 17.08.2021.
//

import Foundation
import UIKit

class MainViewModel: NSObject {
    
    // MARK: - Delegate
    var delegate: MainViewModelDelegate?
    
    // MARK: - Life Cycles
    override init() {
        super.init()
        self.fetch(next: nil)
    }
    
    func fetch(next: String?) {
        DataSource.fetch(next: next) { response, error in
            self.delegate?.updateTableView(response, error: error)
        }
    }
    
    func unique(data: FetchResponse, oldData: [Person], _ completionHandler: @escaping ([Person]) -> ()) {
        var newData = data.people + oldData
        newData = newData.filterDuplicate{ $1.id }
        completionHandler(newData)
    }
}
