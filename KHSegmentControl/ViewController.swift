//
//  ViewController.swift
//  KHSegmentControl
//
//  Created by SAMBIT DASH on 14/07/18.
//  Copyright © 2018 SAMBIT DASH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
        
        segmentControl.segmentChangeHandler = { selectedIndex in
            print("Selected Index :  \(selectedIndex)")
        }
        
        view.addSubview(segmentControl)
    }
    
    @objc func segmentAction (_ sender: KHSegmentControl) {
        print(sender.selectedIndex)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

