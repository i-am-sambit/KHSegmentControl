//
//  ViewController.swift
//  KHSegmentControl
//
//  Created by SAMBIT DASH on 14/07/18.
//  Copyright © 2018 SAMBIT DASH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var secondSegmentControl: KHSegmentControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUI()
    }
    
    func createUI() {
        
        let segmentControl = KHSegmentControl(frame: CGRect(x: 10, y: 20, width: self.view.frame.size.width - 20, height: 60))
        segmentControl.segmentTitles = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        segmentControl.selectedSegmentTextColor = .white
        segmentControl.segmentTextColor = .black
        segmentControl.selectorPosition = .circular
        segmentControl.selectorColor = .orange
        
        segmentControl.layer.cornerRadius = segmentControl.bounds.height/2
        segmentControl.layer.masksToBounds = true
        
        segmentControl.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
        view.addSubview(segmentControl)
        
        let segmentControl2 = KHSegmentControl(frame: CGRect(x: 10, y: 100, width: self.view.frame.size.width - 20, height: 60))
        segmentControl2.segmentTitles = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December", "This Month"]
        segmentControl2.selectedSegmentTextColor = .white
        segmentControl2.segmentTextColor = .black
        segmentControl2.selectorPosition = .down
        segmentControl2.selectorColor = .orange
        
        segmentControl2.layer.masksToBounds = true
        
        segmentControl2.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
//        view.addSubview(segmentControl2)
    }
    
    @objc func segmentAction (_ sender: KHSegmentControl) {
        print(sender.selectedIndex)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

