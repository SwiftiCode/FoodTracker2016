//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Swifticode on 25/4/16.
//  Copyright © 2016 Swifticode. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    
    // MARK: Properties
    var rating = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    var ratingButtons = [UIButton]()
    let spacing = 5
    let starCount = 5

    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let filledStarImage = UIImage(named: "filledStar")
        let emptyStarImage = UIImage(named: "emptyStar")
        
        
        for _ in 0..<starCount {
            
            let button = UIButton()
            
            button.setImage(emptyStarImage, for: UIControl.State())
            button.setImage(filledStarImage, for: UIControl.State.selected)
            button.setImage(filledStarImage, for: [UIControl.State.highlighted, UIControl.State.selected])
            
            button.adjustsImageWhenHighlighted = false
            
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(_:)) , for: UIControl.Event.touchDown)
            
            ratingButtons += [button]
            
            addSubview(button)
        }
    }
    
    override var intrinsicContentSize : CGSize {
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize * starCount) + (spacing * (starCount - 1))
        return CGSize(width: width, height: buttonSize)
    }
    
    override func layoutSubviews() {
        
        // Set the button's width and height to a square the size of the frame's height.
        let buttonSize = Int(frame.size.height)
        
        
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        // Offset each button's origin by the length of the button plus spacing.
        for (index, button) in ratingButtons.enumerated() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        
        updateButtonSelectionStates()
    }
    
    // MARK: Button Action
    @objc func ratingButtonTapped(_ button: UIButton) {
        
        rating = ratingButtons.firstIndex(of: button)! + 1
        updateButtonSelectionStates()
        
    }
    
    func updateButtonSelectionStates() {
        
        for (index, button) in ratingButtons.enumerated() {
            // If the index of a button is less than the rating, that button should be selected.
            button.isSelected = index < rating
            
        }
    }
}
