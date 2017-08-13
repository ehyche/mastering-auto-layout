//
//  ViewController.swift
//  LearnAboutSizeClasses
//
//  Created by Eric Hyche on 8/10/17.
//  Copyright © 2017 HeirPlay Software. All rights reserved.
//

import UIKit

extension UIUserInterfaceSizeClass {
    var debugText: String {
        switch self {
            case .compact: return "Compact"
            case .regular: return "Regular"
            case .unspecified: return "Unspecified"
        }
    }
}

extension UITraitCollection {

    var debugText: String {
        return "(H:\(horizontalSizeClass.debugText),V:\(verticalSizeClass.debugText))"
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        print("Will Transition To Trait Collection \(newCollection.debugText)")
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        print("Will Transition to Size \(size)")
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        print("Trait Collection Did Change. New Trait Collection = \(traitCollection.debugText)")
    }

}

