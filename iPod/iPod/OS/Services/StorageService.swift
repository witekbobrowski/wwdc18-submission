//
//  StorageService.swift
//  iPod
//
//  Created by Witek Bobrowski on 29/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol StorageService {
    var items: [URL]? { get }
}

class StorageServiceImplementation: StorageService {

    var items: [URL]? { return retrieveItems() }

}

extension StorageServiceImplementation {

    private func retrieveItems() -> [URL]? {
        let urls = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: nil)
        return urls
    }

}
