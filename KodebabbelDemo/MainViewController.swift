//
//  ViewController.swift
//  KodebabbelDemo
//
//  Created by thomsmed on 31/10/2020.
//

import UIKit

class MainViewController: UIViewController {
    private static let colors = [
        UIColor.systemBlue,
        UIColor.systemGreen,
        UIColor.systemIndigo,
        UIColor.systemOrange,
        UIColor.systemPink,
        UIColor.systemPurple,
        UIColor.systemRed,
        UIColor.systemTeal,
        UIColor.systemYellow,
        UIColor.systemGray
    ]
    
    @IBOutlet weak var orbView: OrbView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // View loaded from Storyboard (if this instance is associated with any).
        // Do any additional setup here (programmatically add views/viewControllers etc).
        
        // Add a button from code:
        let button = UIButton(type: .system, primaryAction: UIAction(handler: {[weak self] _ in
            self?.presentAlertWithTitle("Greeting", andMessage: "Hello there! 👋")
        }))
        button.setTitle("Say hello!", for: .normal)
        
        // This needs to be false in order to use Auto Layout
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Get the superview's layout
        let margins = view.layoutMarginsGuide
        
        // Add button to parent (this needs to be done before adding constraints)
        view.addSubview(button)
        
        // Constrain bottom of button to bottom of parent view
        button.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -20).isActive = true
        
        // Constrain center of button to center of parent view
        button.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        
        orbView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // The View is about to appear on the screen.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // The view did appear on the screen.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // The view is about to be removed from the screen.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // The view is no longer visible on the screen.
    }
    
    // MARK: Private Methods
    private func presentAlertWithTitle(_ title: String, andMessage message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Close", style: .default))
        
        present(alertController, animated: true)
    }
}

// MARK: OrbViewDelegate
extension MainViewController: OrbViewDelegate {
    func orbViewTapped(_ orbView: OrbView) {
        let randomIndex = Int.random(in: 0..<MainViewController.colors.count)
        orbView.color = MainViewController.colors[randomIndex]
    }
}
