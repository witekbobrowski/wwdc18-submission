//: Playground - noun: a place where people can play

/*

 Welcome to my 2018 WWDC Scholarship submission! This is my first one, and hopefully it will
 be accepted so I can master my iOS skills on the conference! Wish me luck.

 This playground simulates the original 2001 iPod. Is is able to play music, and browse through
 the library smoothly.

 I've tried to make this project as much modular as I can, time did not let me implement 100% of my
 ideas. Hardware parts, and software ones are separated and embeded into one class that manages
 the communication between them.

 The only two used dependencies are UIKit, and AVFoundation.

 Ive used the MVVM-C architecture, so for every view controller, there is a coresponding view model.
 View model handles all the business logic of the controller and delegates beetween the controller
 and coordinator.

 There is a single OperatingSystemCoordinator for the handling navigation between the controllers.

 IPod class gathers everything together into very simple public interface.

 What you see on screen of the device is actually the OperatingSystemViewControler, which
 throught the DeviceViewController and the OperatingSystemCoordinator communicates with controls
 (ex. scroll wheel - all custom views).

 Player functionality is based on custom service (PlayerService) which is responsible for wrapping
 AVPlayer api from AVFoundation.

 Library is built thanks to very very simple StorageService, that delivers url's of all the
 music files to LibraryService and then it gets sorted properly into separate 'buckets' to mimic
 very simple and primitive database.

 To enjoy the playground, simply drag some of your favourite music into the 'Resources' directory :)

 Have fun!

*/

import UIKit
import PlaygroundSupport

let width: CGFloat = 480
let height: CGFloat = 720

// Setup scene for the iPod
let sceneView = UIView()
sceneView.frame = CGRect(x: 0, y: 0, width: width, height: height)
let gradient = CAGradientLayer()
gradient.frame = sceneView.bounds
gradient.colors = [UIColor.black.cgColor,
                   UIColor.black.cgColor,
                   UIColor.gray.cgColor]
sceneView.layer.addSublayer(gradient)

// Setup iPod and embed on the scene
let iPod = IPod()
sceneView.backgroundColor = .blue
iPod.embed(onView: sceneView)

// Display scene on the Playground
PlaygroundPage.current.liveView = sceneView


