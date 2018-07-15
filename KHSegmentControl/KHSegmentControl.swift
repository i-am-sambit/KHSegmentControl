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
    
    let backgroundView: UIScrollView = {
        return UIScrollView()
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
        
        // Set Background View
        backgroundView.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        backgroundView.contentSize = CGSize(width: (Int(self.bounds.size.width/3) * segmentTitles.count), height: Int(self.bounds.size.height))
        backgroundView.showsHorizontalScrollIndicator = false
        backgroundView.isPagingEnabled = true
        self.addSubview(backgroundView)
        
        backgroundView.isScrollEnabled = (segmentTitles.count <= 3 ? false : true)
        
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
        backgroundView.addSubview(selectorView)
        
        for (index, item) in segmentTitles.enumerated() {
            
            let segment = UIButton(frame: CGRect(x: (index*Int(self.bounds.size.width/3)), y: 0, width: (Int(self.bounds.size.width)/3), height: Int(self.bounds.size.height)))
            segment.setTitle(item, for: .normal)
            segment.tag = index
            segment.titleLabel?.font = UIFont(name: "HelveticaNeue-Regular", size: 25)
            segment.addTarget(self, action: #selector(segmentAction(_:)), for: .touchUpInside)
            backgroundView.addSubview(segment)
            
            index == selectedIndex ? segment.setTitleColor(selectedSegmentTextColor, for: .normal) : segment.setTitleColor(segmentTextColor, for: .normal)
            
            segments.append(segment)
        }
    }
    
    @objc func segmentAction(_ sender: UIButton) {
        
        selectedIndex = sender.tag
        
        UIView.animate(withDuration: 0.3) {
            self.selectorView.frame.origin.x = sender.frame.origin.x
        }
        
        for segment in segments {
            segment == sender ? segment.setTitleColor(selectedSegmentTextColor, for: .normal) : segment.setTitleColor(segmentTextColor, for: .normal)
        }
        
        if (selectedIndex == (segmentTitles.count - 1)) {
            centerCurrentView()
        }
        
        sendActions(for: .valueChanged)
    }
    
    public override func sendActions(for controlEvents: UIControlEvents) {
        super.sendActions(for: controlEvents)
    }
    
    private func centerCurrentView() {
        let centerRect = CGRect(
            origin: CGPoint(x: backgroundView.bounds.midX, y: 0),
            size: CGSize(width: 0, height: bounds.height)
        )
        
        guard let selectedIndex = segments.index(where: { $0.frame.intersects(centerRect) })
            else { return }
        let centralView = segments[selectedIndex]
        let targetCenter = centralView.center
        let targetOffsetX = targetCenter.x - (backgroundView.bounds.width / 2)
        
        backgroundView.setContentOffset(CGPoint(x: targetOffsetX, y: 0), animated: true)
    }
}
