//
//  RandomCatViewController.swift
//  KodebabbelDemo
//
//  Created by thomsmed on 03/11/2020.
//

import Foundation
import UIKit

class RandomCatViewController: UIViewController {
    @IBOutlet weak var catImage: UIImageView!
    
    @IBAction func anotherCatPlease(_ sender: UIButton) {
        getNewRandomCatBlocking()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getNewRandomCatNonBlockingUsingGlobalDispatchQueue()
    }
    
    private func getNewRandomCatBlocking() {
        let imageUrl = URL(string: "https://cataas.com/cat")!
        
        // This blocks the current thread!
        guard let imageData = try? Data(contentsOf: imageUrl) else {
            return
        }
        
        catImage.image = UIImage(data: imageData)
    }
    
    private func getNewRandomCatNonBlockingUsingSharedURLSession() {
        // Adding random param to fool the cache ;)
        let imageUrl = URL(string: "https://cataas.com/cat?q=\(Int.random(in: 1..<Int.max))")!
        
        // DataTask runs on separate DispatchQueue (DispatchQueue.global(qos: .background)?)
        URLSession.shared.dataTask(with: imageUrl, completionHandler: { data, response, error in
            
            if let _ = error {
                return
            }
            
            guard let imageData = data else {
                return
            }
            
            // Dispatch UI updates to the main DispatchQueue (main thread)
            DispatchQueue.main.async {[weak self] in
                self?.catImage.image = UIImage(data: imageData)
            }
        }).resume()
    }
    
    private func getNewRandomCatNonBlockingUsingGlobalDispatchQueue() {
        let imageUrl = URL(string: "https://cataas.com/cat")!
        
        // Dispatch blocking tast to global DispatchQueue
        DispatchQueue.global(qos: .default).async {
            // This blocks the current thread!
            guard let imageData = try? Data(contentsOf: imageUrl) else {
                return
            }
            
            // Dispatch UI updates to the main DispatchQueue (main thread)
            DispatchQueue.main.async {[weak self] in
                self?.catImage.image = UIImage(data: imageData)
            }
        }
    }
}
