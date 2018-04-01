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

    private let supportedExtentions: [String] = ["mp3", "m4a", "aac", "flac", "alac"]

    var items: [URL]? { return retrieveItems() }

}

extension StorageServiceImplementation {

    private func retrieveItems() -> [URL]? {
        var items: [URL] = []
        for fileExtension in supportedExtentions {
            items += Bundle.main.urls(forResourcesWithExtension: fileExtension, subdirectory: nil) ?? []
        }
        return items
    }

}
