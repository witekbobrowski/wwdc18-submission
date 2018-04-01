import UIKit

public class IPod {

    private var deviceViewController: DeviceViewController!

    public init() {
        self.setup()
    }

    public func embed(onView view: UIView) {
        deviceViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(deviceViewController.view)
        view.centerXAnchor.constraint(equalTo: deviceViewController.view.centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: deviceViewController.view.centerYAnchor).isActive = true
    }

}

extension IPod {

    private func setup() {
        let deviceViewController = DeviceViewController()
        let storageService = StorageServiceImplementation()
        let libraryService = LibraryServiceImplementation(storageService: storageService)
        let playerService = PlayerServiceImplementation()
        let coordinatorModel = OperatingSystemCoordinatorModelImplementation(libraryService: libraryService, playerService: playerService)
        deviceViewController.viewModel = DeviceViewModelImplementation(operatingSystemCoordinatorModel: coordinatorModel, controlPanelViewModel: ControlPanelViewModelImplementation())
        deviceViewController.view.translatesAutoresizingMaskIntoConstraints = false
        self.deviceViewController = deviceViewController
    }

}
