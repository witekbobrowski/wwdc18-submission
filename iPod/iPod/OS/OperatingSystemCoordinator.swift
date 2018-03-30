//
//  OperatingSystemCoordinator.swift
//  iPod
//
//  Created by Witek Bobrowski on 27/03/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import UIKit

class OperatingSystemCoordinator: Coordinator {

    private let window: UIView
    private let coordinatorModel: OperatingSystemCoordinatorModel

    var rootViewController: OperatingSystemViewController?
    var animatedTransitions: Bool = true

    init(window: UIView, coordinatorModel: OperatingSystemCoordinatorModel) {
        self.window = window
        self.coordinatorModel = coordinatorModel
    }

    func start() {
        let operatingSystemVC = coordinatorModel.operatingSystemViewController
        let viewController = coordinatorModel.mainMenuViewController
        if let viewModel = viewController.viewModel as? MainMenuViewModel {
            viewModel.delegate = self
        }
        operatingSystemVC.menuNavigationController.pushViewController(viewController, animated: animatedTransitions)
        rootViewController = operatingSystemVC
        window.addSubview(operatingSystemVC.view)
        operatingSystemVC.view.translatesAutoresizingMaskIntoConstraints = false
        window.topAnchor.constraint(equalTo: operatingSystemVC.view.topAnchor).isActive = true
        window.bottomAnchor.constraint(equalTo: operatingSystemVC.view.bottomAnchor).isActive = true
        window.leftAnchor.constraint(equalTo: operatingSystemVC.view.leftAnchor).isActive = true
        window.rightAnchor.constraint(equalTo: operatingSystemVC.view.rightAnchor).isActive = true
    }

}

extension OperatingSystemCoordinator {

    private func updateStatusBar(withTitle title: String?, isPlaying: Bool, isCharging: Bool) {
        rootViewController?.statusBarView.viewModel = coordinatorModel.statusBarViewModel(title: title, isPlaying: isPlaying, isCharging: isCharging)
    }

    private func pushViewController(_ viewController: UIViewController) {
        rootViewController?.menuNavigationController.pushViewController(viewController, animated: animatedTransitions)
    }

    private func popViewController() {
        rootViewController?.menuNavigationController.popViewController(animated: animatedTransitions)
    }

}

extension OperatingSystemCoordinator: MainMenuViewModelDelegate {

    func mainMenuViewModel(_ mainMenuViewModel: MainMenuViewModel, didSelectItem item: MainMenuItem) {
        var viewController: MenuViewController
        var title: String
        switch item {
        case .playlists:
            viewController = coordinatorModel.playlistsMenuViewController
            if let viewModel = viewController.viewModel as? PlaylistsMenuViewModel {
                viewModel.delegate = self
            }
            title = Strings.playlists
        case .artists:
            viewController = coordinatorModel.artistsMenuViewController
            if let viewModel = viewController.viewModel as? ArtistsMenuViewModel {
                viewModel.delegate = self
            }
            title = Strings.artists
        case .songs(let songs):
            viewController = coordinatorModel.songsMenuViewController(.all(songs))
            if let viewModel = viewController.viewModel as? SongsMenuViewModel {
                viewModel.delegate = self
            }
            title = Strings.songs
        case .settings:
            title = Strings.settings
            return
        case .about:
            title = Strings.about
            return
        case .nowPlaying:
            title = Strings.nowPlaying
            return
        }
        pushViewController(viewController)
        updateStatusBar(withTitle: title, isPlaying: false, isCharging: false)
    }

}

extension OperatingSystemCoordinator: PlaylistsMenuViewModelDelegate {

    func playlistsMenuViewModel(_ playlistsMenuViewModel: PlaylistsMenuViewModel, didSelectItem item: PlaylistsMenuItem) {
        let viewController: MenuViewController
        switch item {
        case .custom(let playlist):
            viewController = coordinatorModel.songsMenuViewController(.playlist(playlist))
            updateStatusBar(withTitle: playlist.title, isPlaying: false, isCharging: false)
        case .favourites(let favourites):
            viewController = coordinatorModel.songsMenuViewController(.playlist(Playlist(title: Strings.favourites, songs: favourites)))
            updateStatusBar(withTitle: Strings.favourites, isPlaying: false, isCharging: false)
        }
        if let viewModel = viewController.viewModel as? SongsMenuViewModel {
            viewModel.delegate = self
        }
        pushViewController(viewController)
    }

    func playlistsMenuViewModelDidClickGoBack(_ playlistsMenuViewModel: PlaylistsMenuViewModel) {
        popViewController()
        updateStatusBar(withTitle: nil, isPlaying: false, isCharging: false)
    }

}

extension OperatingSystemCoordinator: ArtistsMenuViewModelDelegate {

    func artistsMenuViewModel(_ artistsMenuViewModel: ArtistsMenuViewModel, didSelectItem item: ArtistsMenuItem) {
        var viewController: MenuViewController
        switch item {
        case .all:
            viewController = coordinatorModel.albumsMenuViewController(.all)
        case .artist(let artist):
            viewController = coordinatorModel.albumsMenuViewController(.artist(artist))
            updateStatusBar(withTitle: artist.name, isPlaying: false, isCharging: false)
        }
        if let viewModel = viewController.viewModel as? AlbumsMenuViewModel {
            viewModel.delegate = self
        }
        pushViewController(viewController)
    }

    func artistsMenuViewModelDidClickGoBack(_ artistsMenuViewModel: ArtistsMenuViewModel) {
        popViewController()
        updateStatusBar(withTitle: nil, isPlaying: false, isCharging: false)
    }

}

extension OperatingSystemCoordinator: SongsMenuViewModelDelegate {

    func songsMenuViewModel(_ songsMenuViewModel: SongsMenuViewModel, didSelectSong song: Song) {
        var viewController: PlayerViewController
        switch songsMenuViewModel.type {
        case .album(let album):
            viewController = coordinatorModel.playerViewController(song: song, songs: album.songs, type: .album(album))
        case .artist(let artist):
            let songs = artist.albums.reduce([]) { $0 + $1.songs }.sorted { $0.title < $1.title}
            viewController = coordinatorModel.playerViewController(song: song, songs: songs, type: .artist(artist))
        case .all(let songs):
            viewController = coordinatorModel.playerViewController(song: song, songs: songs, type: .songs)
        case .playlist(let playlist):
            viewController = coordinatorModel.playerViewController(song: song, songs: playlist.songs, type: .playlist(playlist))
        }
        viewController.viewModel.delegate = self
        updateStatusBar(withTitle: Strings.nowPlaying, isPlaying: false, isCharging: false)
        pushViewController(viewController)
    }

    func songsMenuViewModelDidClickGoBack(_ songsMenuViewModel: SongsMenuViewModel) {
        popViewController()
        switch songsMenuViewModel.type {
        case .all:
            updateStatusBar(withTitle: nil, isPlaying: false, isCharging: false)
        case .artist:
            updateStatusBar(withTitle: Strings.artists, isPlaying: false, isCharging: false)
        case .album(let album):
            updateStatusBar(withTitle: album.artist?.name ?? Strings.albums, isPlaying: false, isCharging: false)
        case .playlist:
            updateStatusBar(withTitle: Strings.playlists, isPlaying: false, isCharging: false)
        }
    }

}

extension OperatingSystemCoordinator: AlbumsMenuViewModelDelegate {

    func albumsMenuViewModel(_ albumsMenuViewModel: AlbumsMenuViewModel, didSelectItem item: AlbumsMenuItem) {
        var viewController: MenuViewController
        switch item {
        case .all:
            guard case .artist(let artist) = albumsMenuViewModel.type else { return }
            viewController = coordinatorModel.songsMenuViewController(.artist(artist))
            updateStatusBar(withTitle: artist.name, isPlaying: false, isCharging: false)
        case .album(let album):
            viewController = coordinatorModel.songsMenuViewController(.album(album))
            updateStatusBar(withTitle: album.title, isPlaying: false, isCharging: false)
        }
        if let viewModel = viewController.viewModel as? SongsMenuViewModel {
            viewModel.delegate = self
        }
        pushViewController(viewController)
    }

    func albumsMenuViewModelDidClickGoBack(_ albumsMenuViewModel: AlbumsMenuViewModel) {
        popViewController()
        switch albumsMenuViewModel.type {
        case .all:
            updateStatusBar(withTitle: Strings.artists, isPlaying: false, isCharging: false)
        case .artist(let artist):
            updateStatusBar(withTitle: artist.name, isPlaying: false, isCharging: false)
        }
    }

}

extension OperatingSystemCoordinator: PlayerViewModelDelegate {

    func playerViewModelDidClickGoBack(_ playerViewModel: PlayerViewModel) {
        switch playerViewModel.type {
        case .album(let album):
            updateStatusBar(withTitle: album.title, isPlaying: false, isCharging: false)
        case .artist(let artist):
            updateStatusBar(withTitle: artist.name, isPlaying: false, isCharging: false)
        case .playlist(let playlist):
            updateStatusBar(withTitle: playlist.title, isPlaying: false, isCharging: false)
        case .songs:
            updateStatusBar(withTitle: Strings.songs, isPlaying: false, isCharging: false)
        case .nowPlaying:
            updateStatusBar(withTitle: nil, isPlaying: false, isCharging: false)
        }
        popViewController()
    }

}

extension OperatingSystemCoordinator: InputResponder {

    func respond(toInputType type: InputType) {
        guard
            let topViewController = rootViewController?.menuNavigationController.topViewController,
            let responder = topViewController as? InputResponder
        else { return }
        responder.respond(toInputType: type)
    }

}
