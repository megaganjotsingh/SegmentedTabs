//
//  SegmentView.swift
//  SegmentedTabs
//
//  Created by Admin on 27/01/23.
//

import Foundation
import UIKit

class SegmentView: UIView {
    
    var titles: [String] = []
    
    private var stackView = UIStackView()
    private let upperLineView = UIView()
    private let bottomLineView = UIView()
    private let sliderView = UIView()
    private var buttonLabels: [SegmentLabel] = []
    
    public var lineBackgroundColor: UIColor = .gray
    public var selectedColor: UIColor = .blue
    public var filledBackgroundColor: UIColor = .clear
    
    var segmentButtonTapped: ((Int) -> ())?
    
    fileprivate var sectionWidth: CGFloat {
        return frame.size.width / CGFloat(buttonLabels.count)
    }
    
    convenience init(titles: [String], segmentButtonTapped: ((Int) -> ())?) {
        self.init(frame: .zero)
        self.titles = titles
        self.segmentButtonTapped = segmentButtonTapped
        setUpUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup(titles: [String], segmentButtonTapped: ((Int) -> ())?) {
        self.backgroundColor = filledBackgroundColor
        self.titles = titles
        self.segmentButtonTapped = segmentButtonTapped
        setUpUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let point = touch?.location(in: self), let touchedLabel = buttonLabels.filter({ $0.frame.contains(point) }).first {
            buttonLabels = buttonLabels.map({ (label) -> SegmentLabel in
                label.isSelected = label === touchedLabel
                return label
            })
            UIView.animate(withDuration: 0.3) { [weak self] in
                guard let self = self else { return }
                self.sliderView.frame.origin.x = CGFloat(touchedLabel.index) * self.sectionWidth
            }
            segmentButtonTapped?(touchedLabel.index)
        }
    }
}

private extension SegmentView {
    
    func setUpUI() {
        setupStackView()
        setUpLabels()
        setupLineView()
        setupSlider()
    }
    
    func setupStackView() {
        stackView.frame = CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.size.width, height: bounds.height))
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        addSubview(stackView)
    }
    
    func setUpLabels() {
        buttonLabels = titles.enumerated().map({ SegmentLabel(text: $0.element, index: $0.offset, selectedLabelColor: selectedColor, unselectedLabelColor: lineBackgroundColor) })
        buttonLabels.forEach({
            stackView.addArrangedSubview($0)
//            $0.addTarget(self, action: #selector(addTargetToButton(_:)), for: .touchUpInside)
        })
        if buttonLabels.count > 1 {
            buttonLabels[0].isSelected = true
        }
    }
    
    func setupSlider() {
        sliderView.frame = CGRect(x: 0, y: frame.height-2, width: sectionWidth, height: 2)
        sliderView.backgroundColor = selectedColor
        addSubview(sliderView)
    }
    
    func setupLineView() {
        upperLineView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 2)
        upperLineView.backgroundColor = lineBackgroundColor
        addSubview(upperLineView)
        bottomLineView.frame = CGRect(x: 0, y: frame.height-2, width: UIScreen.main.bounds.width, height: 2)
        bottomLineView.backgroundColor = lineBackgroundColor
        addSubview(bottomLineView)
    }
    
//    @objc
//    func addTargetToButton(_ sender: UIButton) {
//        buttonLabels = buttonLabels.map({ (button) -> SegmentLabel in
//            button.isSelected = button === sender
//            return button
//        })
//        let width = UIScreen.main.bounds.width / CGFloat(titles.count)
//        UIView.animate(withDuration: 0.3) { [weak self] in
//            self?.sliderView.origin.x = CGFloat(sender.tag) * width
//        }
//        segmentButtonTapped?(sender.tag)
//    }
}

fileprivate class SegmentLabel: UILabel {
    var isSelected = false {
        didSet {
            setup()
        }
    }
    
    var index: Int = 0
    var selectedLabelColor: UIColor = .black
    var unselectedLabelColor: UIColor = .gray
    
    convenience init(text: String, index: Int, selectedLabelColor: UIColor, unselectedLabelColor: UIColor) {
        self.init(frame: .zero)
        self.index = index
        self.selectedLabelColor = selectedLabelColor
        self.unselectedLabelColor = unselectedLabelColor
        
        self.text = text
        textAlignment = .center
        font = UIFont.systemFont(ofSize: 14, weight: .medium)
        setup()
    }
    
    func setup() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.transform = self.isSelected ? CGAffineTransform(scaleX: 1.1, y: 1.1) : CGAffineTransform.identity
            self.textColor = self.isSelected ? self.selectedLabelColor : self.unselectedLabelColor
        }
        
    }
}

//class SegmentLabelButton: UIButton {
//    override var isSelected: Bool {
//        didSet {
//            setup(for: isSelected)
//        }
//    }
//
//    convenience init(text: String, index: Int, height: CGFloat) {
//        self.init(frame: .zero)
//        setTitle(text, for: .normal)
//        tag = index
//        contentHorizontalAlignment = .center
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup(for: false)
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setup(for: false)
//    }
//
//    func setup(for selected: Bool) {
//        UIView.animate(withDuration: 0.3) { [weak self] in
//            self?.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: selected ? .medium : .regular)
//            self?.setTitleColor(selected ? AppColors.themeColor : .gray, for: .normal)
//        }
//    }
//}
