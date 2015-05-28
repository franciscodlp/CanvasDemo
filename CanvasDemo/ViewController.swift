//
//  ViewController.swift
//  CanvasDemo
//
//  Created by Francisco de la Pena on 5/27/15.
//  Copyright (c) 2015 Twister Labs, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var smileFace: [UIImageView]!
    
    @IBOutlet var gestureRecognizer: UIPanGestureRecognizer!
    
    @IBOutlet var trayView: UIView!
    
    var trayOriginalCenter: CGPoint!
    
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceCenter: CGPoint!
    
    
    @IBAction func onSmilePan(sender: AnyObject) {
        println("Doing something")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var xOffset = trayView.frame.size.width / 8
        var yOffset = trayView.frame.size.height / 5
        
        for item in smileFace {
            
            var counter = find(smileFace, item)!
            
            var hOffset = CGFloat((3 - (counter % 3))) * xOffset
            var wOffset = CGFloat(counter > 2 ? 1 : 0) * yOffset
            
            item.frame = CGRect(x: hOffset, y: yOffset, width: 40, height: 40)
            
            item.center.x += hOffset
            item.center.y += wOffset
            
        }
        
        trayOriginalCenter = trayView.center
        var translation = gestureRecognizer.translationInView(trayView)
        
        trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func onCustomPan(panGestureRecognizer: UIPanGestureRecognizer) {
        var point = panGestureRecognizer.locationInView(view)
        var velocity = panGestureRecognizer.velocityInView(view)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            var imageView = panGestureRecognizer.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceCenter = newlyCreatedFace.center
            println("Gesture began at: \(point)")
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            newlyCreatedFace.center.y -= trayView.frame.origin.y
            println("Gesture changed at: \(point)")
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            println("Gesture ended at: \(point)")
        }
    }
}

