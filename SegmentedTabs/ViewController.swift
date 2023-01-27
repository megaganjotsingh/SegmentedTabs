//
//  ViewController.swift
//  SegmentedTabs
//
//  Created by Admin on 27/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var segmentView: SegmentView!
    @IBOutlet weak var selectedIndexLabel: UILabel!
    
    var bottomSegmentView = SegmentView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmendView()
        setupBottomSegment()
    }

    func setupSegmendView() {
        segmentView.isHidden = true
        segmentView.filledBackgroundColor = .gray.withAlphaComponent(0.1)
        segmentView.lineBackgroundColor = .gray.withAlphaComponent(0.5)
        segmentView.selectedColor = .red
        segmentView.setup(
            titles: [
                "First",
                "Second",
                "Third"
            ],
            segmentButtonTapped: ( { [weak self] index in
                self?.selectedIndexLabel.text = "\(index+1)"
            })
        )
    }
    
    func setupBottomSegment() {
        
        let screenSize = UIScreen.main.bounds
        bottomSegmentView.frame = CGRect(x: 0, y: screenSize.height-140, width: screenSize.width, height: 70)
        view.addSubview(bottomSegmentView)
        bottomSegmentView.filledBackgroundColor = .yellow.withAlphaComponent(0.1)
        bottomSegmentView.lineBackgroundColor = .black.withAlphaComponent(0.5)
        bottomSegmentView.selectedColor = .cyan
        bottomSegmentView.setup(
            titles: [
                "Fourth",
                "Fifth",
                "Sixth"
            ],
            segmentButtonTapped: ( { [weak self] index in
                self?.selectedIndexLabel.text = "\(index + 4)"
            })
        )
    }
}

