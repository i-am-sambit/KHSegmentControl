# KHSegmentControl

# Features #

- Supports Text. Images comming soon
- Supports Horizontal Scrolling
- Supports Attributed text styling 
- Supports Different Selection Styles [.up, .down, .circular, .box]
- Supports ARC and iOS 10 or more
- Supports closure

# Installation #

### CocoaPods
- Comming Soon

### Manual 
- Download the KHSegmentControl
- Drag KHSegmentControl.swift file in your project directory

### Usage 

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
