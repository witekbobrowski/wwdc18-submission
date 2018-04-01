//
//  AboutViewModel.swift
//  iPod
//
//  Created by Witek Bobrowski on 01/04/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//
 
import Foundation

protocol AboutViewModelDelegate: class {
    func aboutViewModelDidClickGoBack(_ aboutViewModel: AboutViewModel)
}

protocol AboutViewModel {
    var delegate: AboutViewModelDelegate? { get set }
    var title: String { get }
    var description: String { get }
    var footnote: String { get }
    func menuAction()
}

class AboutViewModelImplementation: AboutViewModel {

    weak var delegate: AboutViewModelDelegate?
    var title: String {
        return Strings.wwdc
    }
    var description: String {
        return Strings.aboutDescription
    }
    var footnote: String {
        return Strings.madeBy
    }

    func menuAction() {
        delegate?.aboutViewModelDidClickGoBack(self)
    }

}
