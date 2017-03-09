//
//  ViewController.swift
//  Canvas
//
//  Created by Luu Tien Thanh on 3/9/17.
//  Copyright © 2017 Thanh Luu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    
    var initialPoint = CGPoint(x:0, y: 0)
    var initialNewlyCreatedFacePoint = CGPoint(x:0, y: 0)
    var newlyCreatedFace: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialPoint = trayView.center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTrayPanGesture(_ sender: UIPanGestureRecognizer) {
        let state = sender.state

        if state == .began {
            let velocity = sender.velocity(in: self.view)
            if ( velocity.y < 0 ) {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
                    self.trayView.center = CGPoint(x: self.initialPoint.x, y: self.initialPoint.y)
                }, completion: { (_) in
                })
            } else {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.6, options: [], animations: {
                    self.trayView.center = CGPoint(x: self.initialPoint.x, y: self.initialPoint.y + self.trayView.frame.height - 40)
                }, completion: { (_) in
                })
                
            }
        }
    }
    
    @IBAction func onIconPanGesture(_ sender: UIPanGestureRecognizer) {
        let state = sender.state
        let translation = sender.translation(in: self.view)
        
        if state == .began {
            // Gesture recognizers know the view they are attached to
            let imageView = sender.view as! UIImageView
            
            // Create a new image view that has the same image as the one currently panning
            newlyCreatedFace = UIImageView(image: imageView.image)
            
            // Add the new face to the tray's parent view.
            trayView.addSubview(newlyCreatedFace)
            
            // Initialize the position of the new face.
            newlyCreatedFace.center = imageView.center
            
            initialNewlyCreatedFacePoint = newlyCreatedFace.center
            
            // Since the original face is in the tray, but the new face is in the
            // main view, you have to offset the coordinates
            newlyCreatedFace.center.y += trayView.frame.origin.y
        }
        
        if state == .changed {
            newlyCreatedFace.center = CGPoint(x: initialNewlyCreatedFacePoint.x + translation.x, y: initialNewlyCreatedFacePoint.y + translation.y)
        }
    }
}

