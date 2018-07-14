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
        
        let segmentControl = KHSegmentControl(frame: CGRect(x: 0, y: 20, width: self.view.frame.size.width, height: 60))
        segmentControl.backgroundColor = UIColor.orange
        segmentControl.segmentTitles = ["One", "Two", "Three"]
        segmentControl.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
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

