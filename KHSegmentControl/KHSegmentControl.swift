//
//  KHSegmentControl.swift
//  KHSegmentControl
//
//  Created by SAMBIT DASH on 14/07/18.
//  Copyright © 2018 SAMBIT DASH. All rights reserved.
//

import Foundation
import UIKit

public class KHSegmentControl: UIControl {
    
    enum SelectorPosition {
        case up
        case down
        case circular
        case box
    }
    
    private var segments: [UIButton] = [UIButton]()
    private let selectorView: UIView = {
        return UIView()
    }()
    
    /**
     * Set segment titles
     **/
    var segmentTitles: [String] = [] {
        didSet{
            updateUI()
        }
    }
    
    /**
     * Set Segment Images
     **/
    var segmentImages: [UIImage] = [] {
        didSet{
            updateUI()
        }
    }
    
    /**
     * Set selector view color
     * Default is light gray color
     **/
    var selectorColor: UIColor = .black {
        didSet{
            updateUI()
        }
    }
    
    /**
     * Set Segment Text color
     * Default is .black
     **/
    var segmentTextColor: UIColor = .white {
        didSet {
            updateUI()
        }
    }
    
    /**
     * Set Selected Segment Text color
     * Default is .white
     **/
    var selectedSegmentTextColor: UIColor = .black {
        didSet {
            updateUI()
        }
    }
    
    /**
     * Set Selector Position
     * Default is down
     **/
    var selectorPosition: SelectorPosition = .down {
        didSet {
            updateUI()
        }
    }
    
    /**
     * Set Selector Position
     * Default is down
     **/
    var selectorHeight: Int = 5 {
        didSet {
            updateUI()
        }
    }
    
    /**
     * Selected Index. Default is 0
     **/
    var selectedIndex: Int = 0
    
    //MARK:
    public override init(frame: CGRect) {
        super.init(frame: frame)
        updateUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Update UI for KHSegment Control
    func updateUI() {
        
        // Remove all the subviews
        self.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        
        switch selectorPosition {
            
        case .up:
            selectorView.frame = CGRect(x: 0, y: 0, width: (Int(self.bounds.size.width)/3), height: selectorHeight)
            selectorView.backgroundColor = selectorColor
            break
        case .down:
            selectorView.frame = CGRect(x: 0, y: Int(self.bounds.size.height) - selectorHeight, width: (Int(self.bounds.size.width)/3), height: selectorHeight)
            selectorView.backgroundColor = selectorColor
            break
        case .circular:
            selectorView.frame = CGRect(x: 0, y: 0, width: (Int(self.bounds.size.width)/3), height: Int(self.bounds.size.height))
            selectorView.backgroundColor = selectorColor
            selectorView.layer.cornerRadius = selectorView.frame.size.height/2
            break
        case .box:
            selectorView.frame = CGRect(x: 0, y: 0, width: (Int(self.bounds.size.width)/3), height: Int(self.bounds.size.height))
            selectorView.backgroundColor = selectorColor.withAlphaComponent(0.5)
            break
        }
        self.addSubview(selectorView)
        
        for (index, item) in segmentTitles.enumerated() {
            
            let segment = UIButton(frame: CGRect(x: (index*Int(self.bounds.size.width/3)), y: 0, width: (Int(self.bounds.size.width)/3), height: Int(self.bounds.size.height)))
            segment.setTitle(item, for: .normal)
            segment.tag = index
            segment.titleLabel?.font = UIFont(name: "HelveticaNeue-Regular", size: 25)
            segment.addTarget(self, action: #selector(segmentAction(_:)), for: .touchUpInside)
            self.addSubview(segment)
            
            index == selectedIndex ? segment.setTitleColor(selectedSegmentTextColor, for: .normal) : segment.setTitleColor(segmentTextColor, for: .normal)
            
            segments.append(segment)
        }
    }
    
    @objc func segmentAction(_ sender: UIButton) {
        
        selectedIndex = sender.tag
        
        UIView.animate(withDuration: 0.3) {
            
            switch self.selectorPosition {
                
            case .up:
                self.selectorView.frame = CGRect(x: (self.selectedIndex*Int(self.bounds.size.width/3)), y: Int(self.selectorView.frame.origin.y), width: (Int(self.bounds.size.width)/3), height: self.selectorHeight)
            case .down:
                self.selectorView.frame = CGRect(x: (self.selectedIndex*Int(self.bounds.size.width/3)), y: Int(self.selectorView.frame.origin.y), width: (Int(self.bounds.size.width)/3), height: self.selectorHeight)
            case .circular:
                self.selectorView.frame = CGRect(x: (self.selectedIndex*Int(self.bounds.size.width/3)), y: Int(self.selectorView.frame.origin.y), width: (Int(self.bounds.size.width)/3), height: Int(self.bounds.size.height))
            case .box:
                self.selectorView.frame = CGRect(x: (self.selectedIndex*Int(self.bounds.size.width/3)), y: Int(self.selectorView.frame.origin.y), width: (Int(self.bounds.size.width)/3), height: Int(self.bounds.size.height))
            }
        }
        
        for segment in segments {
            segment == sender ? segment.setTitleColor(selectedSegmentTextColor, for: .normal) : segment.setTitleColor(segmentTextColor, for: .normal)
        }
        
        sendActions(for: .valueChanged)
    }
    
    public override func sendActions(for controlEvents: UIControlEvents) {
        super.sendActions(for: controlEvents)
    }
    
    
}
