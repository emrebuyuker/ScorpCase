//
//  MainViewModelDelegate.swift
//  ScorpCase
//
//  Created by Emre Büyüker on 17.08.2021.
//

import Foundation

protocol MainViewModelDelegate {
    func updateTableView(_ response: FetchResponse?, error: FetchError?)
}
