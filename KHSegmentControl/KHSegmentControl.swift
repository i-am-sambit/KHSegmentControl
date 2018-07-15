//
//  KHSegmentControl.swift
//  KHSegmentControl
//
//  Created by SAMBIT DASH on 14/07/18.
//  Copyright © 2018 SAMBIT DASH. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable public class KHSegmentControl: UIControl {
    
    enum SelectorPosition: Int {
        case up
        case down
        case circular
        case box
    }
    
    private var segments: [UIButton] = [UIButton]()
    
    
    /**
     * -- Selectore View --
     * This will indicate the selected segment
     **/
    private let selectorView: UIView = {
        return UIView()
    }()
    
    
    /**
      * Make Segment controller scrollable.
      * If number of segments is more than 3, then enable scroll
      **/
    private let backgroundView: UIScrollView = {
        return UIScrollView()
    }()
    
    
    /**
      * Set Segment width according to number of segments
      **/
    private var segmentWidth: Int = 0
    
    /**
     * Set segment titles
     **/
    var segmentTitles: [String] = [] {
        didSet{
            updateUI()
        }
    }
    
    
    /**
     * Set selector view color
     * Default is light gray color
     **/
    @IBInspectable var selectorColor: UIColor = .black {
        didSet{
            updateUI()
        }
    }
    
    
    /**
     * Set Segment Text color
     * Default is .black
     **/
    @IBInspectable var segmentTextColor: UIColor = .white {
        didSet {
            updateUI()
        }
    }
    
    
    /**
     * Set Selected Segment Text color
     * Default is .white
     **/
    @IBInspectable var selectedSegmentTextColor: UIColor = .black {
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
    @IBInspectable var selectorHeight: Int = 5 {
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
        super.init(coder: aDecoder)
        updateUI()
    }
    
    
    //MARK: Update UI for KHSegment Control
    func updateUI() {
        
        self.backgroundColor = .lightGray
        
        // Remove all the subviews
        self.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        
        //Set
        if segmentTitles.count > 0 {
            segmentWidth = segmentTitles.count <= 3 ? Int(self.bounds.width)/segmentTitles.count : Int(self.bounds.width/3)
        }
        else {
            segmentWidth = Int(self.bounds.width)
        }
        
        // Set Background View
        backgroundView.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        backgroundView.contentSize = CGSize(width: (segmentWidth * segmentTitles.count), height: Int(self.bounds.size.height))
        backgroundView.showsHorizontalScrollIndicator = false
        backgroundView.isPagingEnabled = true
        self.addSubview(backgroundView)
        
        // Enable scroll, if number of segments are more than 3
        backgroundView.isScrollEnabled = (segmentTitles.count <= 3 ? false : true)
        
        
        switch selectorPosition {
            
        case .up:
            selectorView.frame = CGRect(x: 0, y: 0, width: segmentWidth, height: selectorHeight)
            selectorView.backgroundColor = selectorColor
            break
        case .down:
            selectorView.frame = CGRect(x: 0, y: Int(self.bounds.size.height) - selectorHeight, width: segmentWidth, height: selectorHeight)
            selectorView.backgroundColor = selectorColor
            break
        case .circular:
            selectorView.frame = CGRect(x: 0, y: 0, width: segmentWidth, height: Int(self.bounds.size.height))
            selectorView.backgroundColor = selectorColor
            selectorView.layer.cornerRadius = selectorView.frame.size.height/2
            break
        case .box:
            selectorView.frame = CGRect(x: 0, y: 0, width: segmentWidth, height: Int(self.bounds.size.height))
            selectorView.backgroundColor = selectorColor.withAlphaComponent(0.5)
            break
        }
        backgroundView.addSubview(selectorView)
        
        segments.removeAll()
        for (index, item) in segmentTitles.enumerated() {
            
            let segment = UIButton(frame: CGRect(x: (index*segmentWidth), y: 0, width: segmentWidth, height: Int(self.bounds.size.height)))
            segment.setTitle(item, for: .normal)
            segment.tag = index
            segment.titleLabel?.font = UIFont(name: "HelveticaNeue-Regular", size: 25)
            segment.addTarget(self, action: #selector(segmentAction(_:)), for: .touchUpInside)
            backgroundView.addSubview(segment)
            
            index == selectedIndex ? segment.setTitleColor(selectedSegmentTextColor, for: .normal) : segment.setTitleColor(segmentTextColor, for: .normal)
            
            segments.append(segment)
        }
    }
    
    //MARK: -- Segment Action
    /**
      * Set selected index of the control segment
      * Animate and update selector view position
      * Update selected segment textcolor
      **/
    @objc func segmentAction(_ sender: UIButton) {
        
        selectedIndex = sender.tag
        
        UIView.animate(withDuration: 0.3) {
            self.selectorView.frame.origin.x = sender.frame.origin.x
        }
        
        for segment in segments {
            segment == sender ? segment.setTitleColor(selectedSegmentTextColor, for: .normal) : segment.setTitleColor(segmentTextColor, for: .normal)
        }
        
        centerCurrentView()
        
        sendActions(for: .valueChanged)
    }
    
    //MARK: Send Actions
    public override func sendActions(for controlEvents: UIControlEvents) {
        super.sendActions(for: controlEvents)
    }
    
    //MARK: Center Current View
    /**
      *
      **/
    private func centerCurrentView() {

        let centralView = segments[selectedIndex]
        let targetCenter = centralView.center
        
        var targetOffsetX: Int = 0
        
        if selectedIndex == 0 {
            targetOffsetX = 0
        }
        else if selectedIndex == segments.count - 1 {
            targetOffsetX = Int(backgroundView.bounds.width) + segmentWidth
        }
        else {
            targetOffsetX = Int(targetCenter.x - (backgroundView.bounds.width / 2))
        }
        
        backgroundView.setContentOffset(CGPoint(x: targetOffsetX, y: 0), animated: true)
    }
}
