//
//  KodebabbelViewController.swift
//  KodebabbelDemo
//
//  Created by thomsmed on 31/10/2020.
//

import Foundation
import UIKit

class KodebabbelViewController: UIViewController {
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
    
    @IBOutlet weak var image: UIImageView!
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            let randomIndex = Int.random(in: 0..<KodebabbelViewController.colors.count)
            sender.view?.backgroundColor = KodebabbelViewController.colors[randomIndex]
        })
        
        UIView.animateKeyframes(withDuration: 0.3, delay: 0, options: [], animations: {[weak self] in
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                self?.image.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self?.image.transform = CGAffineTransform.identity
            })
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // View loaded from Storyboard (if this instance is associated with any).
        // Do any additional setup here (programmatically add views/viewControllers etc).
        
        view.layer.cornerRadius = 10;
        view.layer.masksToBounds = true;
        view.backgroundColor = UIColor.black
    }
}
