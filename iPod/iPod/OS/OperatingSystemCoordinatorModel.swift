//
//  OperatingSystemCoordinatorModel.swift
//  iPod
//
//  Created by Witek Bobrowski on 27/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation

protocol OperatingSystemCoordinatorModel {
    var playerService: PlayerService { get }
    var operatingSystemViewController: OperatingSystemViewController { get }
    var mainMenuViewController: MenuViewController { get }
    var playlistsMenuViewController: MenuViewController { get }
    var artistsMenuViewController: MenuViewController { get }
    func songsMenuViewController(_ type: SongsMenuType) -> MenuViewController
    func albumsMenuViewController(_ type: AlbumsMenuType) -> MenuViewController
    func playerViewController(song: Song?, songs: [Song], type: PlayerViewModelType) -> PlayerViewController
}

class OperatingSystemCoordinatorModelImplementation: OperatingSystemCoordinatorModel {

    let libraryService: LibraryService

    private(set) var playerService: PlayerService
    var operatingSystemViewController: OperatingSystemViewController {
        return configuredOperatingSystemViewController()
    }
    var mainMenuViewController: MenuViewController {
        return configuredMainMenuViewController()
    }
    var playlistsMenuViewController: MenuViewController {
        return configuredPlaylistsMenuViewController()
    }
    var artistsMenuViewController: MenuViewController {
        return configuredArtistsMenuViewController()
    }

    init(libraryService: LibraryService, playerService: PlayerService) {
        self.libraryService = libraryService
        self.playerService = playerService
    }

    func songsMenuViewController(_ type: SongsMenuType) -> MenuViewController {
        return configuredSongsMenuViewController(type)
    }

    func albumsMenuViewController(_ type: AlbumsMenuType) -> MenuViewController {
        return configuredAlbumsMenuViewController(type)
    }

    func playerViewController(song: Song?, songs: [Song], type: PlayerViewModelType) -> PlayerViewController {
        return configuredPlayerViewController(song: song, songs: songs, type: type)
    }

}

extension OperatingSystemCoordinatorModelImplementation {

    private func configuredOperatingSystemViewController() -> OperatingSystemViewController {
        let viewController = OperatingSystemViewController()
        let osViewModel = OperatingSystemViewModelImplementation()
        viewController.viewModel = osViewModel
        viewController.view.isUserInteractionEnabled = false
        return viewController
    }

    private func configuredMainMenuViewController() -> MenuViewController {
        let viewController = MenuViewController()
        let menuItems: [MainMenuItem] = [.playlists, .artists, .songs(libraryService.songs), .settings, .about]
        viewController.viewModel = MainMenuViewModel(items: menuItems)
        return viewController
    }

    private func configuredPlaylistsMenuViewController() -> MenuViewController {
        let viewController = MenuViewController()
        let menuItems: [PlaylistsMenuItem] = [.favourites(libraryService.favourites)] + libraryService.playlists.map { .custom($0) }
        viewController.viewModel = PlaylistsMenuViewModel(items: menuItems)
        return viewController
    }

    private func configuredArtistsMenuViewController() -> MenuViewController {
        let viewController = MenuViewController()
        let menuItems: [ArtistsMenuItem] = [.all] + libraryService.artists.map { .artist($0) }
        viewController.viewModel = ArtistsMenuViewModel(items: menuItems)
        return viewController
    }

    private func configuredSongsMenuViewController(_ type: SongsMenuType) -> MenuViewController {
        let viewController = MenuViewController()
        var menuItems: [Song]
        switch type {
        case .all(let songs):
            menuItems = songs
        case .artist(let artist):
            menuItems = libraryService.albumsOfArtist(artist).reduce([]) {$0 + $1.songs}
        case .album(let album):
            menuItems = album.songs
        case .playlist(let playlist):
            menuItems = playlist.songs
        }
        viewController.viewModel = SongsMenuViewModel(songs: menuItems, type: type)
        return viewController
    }

    private func configuredAlbumsMenuViewController(_ type: AlbumsMenuType) -> MenuViewController {
        let viewController = MenuViewController()
        var menuItems: [AlbumsMenuItem]
        switch type {
        case .all:
            menuItems = libraryService.albumsOfArtist(nil).map { .album($0) }
        case .artist(let artist):
            menuItems = libraryService.albumsOfArtist(artist).map { .album($0) }
        }
        viewController.viewModel = AlbumsMenuViewModel(items: menuItems, type: type)
        return viewController
    }

    private func configuredPlayerViewController(song: Song?, songs: [Song], type: PlayerViewModelType) -> PlayerViewController {
        let viewController = PlayerViewController()
        var songs: [Song] = songs
        switch type {
        case .songs:
            songs = libraryService.songs
        default:
            break
        }
        viewController.viewModel = PlayerViewModelImplementation(playerService: playerService, song: song, playlist: songs, type: type)
        return viewController
    }

}
