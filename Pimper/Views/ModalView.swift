//
//  ModalView.swift
//
//  Created by Will morris on 11/5/20.
//

import Foundation
import UIKit

// TODO: WHEN SCROLLING BACK DOWN IN TABLVIEW IT JUMPS CUZ TRANSLATION IS NOT RESET 

class ModalView: UIView, UIGestureRecognizerDelegate {
    
    /// Allows you to set the state of the ModalView to a ModalViewOption. The value is how much of the screen the ModalView should cover. 1 being fullscreen. 0.5 being half the screen. 0 being hidden.
    struct ModalViewOption: Equatable {
        let value: CGFloat
        
        static let hidden = ModalViewOption(value: 0)
        static let quarter = ModalViewOption(value: 0.25)
        static let half = ModalViewOption(value: 0.5)
        static let threeQuarter = ModalViewOption(value: 0.75)
        static let full = ModalViewOption(value: 0.95)
        
        static func create(value: CGFloat) -> ModalViewOption {
            return ModalViewOption(value: value)
        }
        
        static func ==(lhs: ModalViewOption, rhs: ModalViewOption) -> Bool {
            return lhs.value == rhs.value
        }
    }
    
    /// Set true if you want a dampening effect. Otherwise set to false
    var compresses: Bool = true
    
    /// The corner radius for the top corners
    var cornerRadius: CGFloat = 25
    
    /// The amount you want the ModalView to compress / dampen. The higher the number, the more it dampens. Default is 0.5.
    var limiter: CGFloat = 0.5
    
    var completion: (ModalViewOption) -> Void
    
    var dragCompletionHandler: ((CGFloat) -> Void)?
    
    var isDragDisabled: Bool = false
    
    private var topConstraint: NSLayoutConstraint?
    private var bottomConstraint: NSLayoutConstraint?
    
    private var superViewHeight: CGFloat?
    
    private var startLocation: CGFloat = 0
    
    private var lastLocation: CGFloat = 0
    
    private var topConstant: CGFloat {
        (superViewHeight ?? 0) * (1 - state.value)
    }
    
    private var panGesture: UIPanGestureRecognizer?
    
    private var velocity: CGFloat = 1
    
    private var animationTime: CGFloat = 0.3
    
    private var velocityThreshold: CGFloat = 500
    
    private var startTime: TimeInterval = 0.0
    
    private var endTime: TimeInterval = 0.0
    
    private var externalTranslation: CGFloat = 0
    
    private var externalIsDragging: Bool = false
    
    private var substituteGestureOffset: CGFloat = 0
    
    private var gestureDuration: TimeInterval {
        return endTime - startTime
    }
    
    private(set) var state: ModalViewOption = .hidden {
        didSet {
            completion(state)
        }
    }
    
    private(set) var options: [ModalViewOption] = []
    
    init(with options: [ModalViewOption] = [.quarter, .half, .full], completion: @escaping (ModalViewOption) -> Void) {
        self.completion = completion
        super.init(frame: .zero)
        
        self.setOptions(options)
        
        backgroundColor = .white
        
        translatesAutoresizingMaskIntoConstraints = false
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(gestureDrag))
        panGesture!.delegate = self
        
        gestureRecognizers = [panGesture!]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        startLocation = frame.minY
    }
    
    override func didMoveToSuperview() {
        guard let superview = superview else { return }
        superViewHeight = superview.frame.size.height
        
        setupConstraints()
    }
    
    override func layoutSubviews() {
        // Rounds the top corners
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func substitueGesture(with gesture: UIPanGestureRecognizer, offset: CGFloat?) {
        if let offset = offset {
            substituteGestureOffset = offset
        }
        gestureDrag(gesture)
    }
    
    func setHeightConstant(with value: CGFloat) {
        externalTranslation = value
        externalIsDragging = true
        gestureDrag(panGesture!)
    }
    
    func finishSettingHeightConstant() {
        if externalIsDragging {
            externalIsDragging = false
            gestureDrag(panGesture!)
        }
    }
    
    func dragCompletion(_ completion: @escaping (CGFloat) -> Void) {
        self.dragCompletionHandler = completion
    }
        
    /// Sets the state of the ModalView from external / internal sources
    /// - Parameter state: The desired state to be set
    func setState(_ state: ModalViewOption) {
        self.state = state
        if !options.contains(state) {
            options.append(state)
            options.sort { $0.value < $1.value }
        }
        bottomConstraint?.constant = topConstant
        setHeight()
    }
    
    /// Sets the state options for the ModalView
    /// - Parameter options: The desired options
    func setOptions( _ options: [ModalViewOption]) {
        let sorted = options.sorted { $0.value < $1.value }
        self.options = sorted
        if !options.isEmpty {
            if !options.contains(state) {
                setState(sorted.first!)
            }
        }
    }
    
    // If compresses == true then makes dragging "compress" or "dampen"
    private func compress(_ value: CGFloat, with translation: CGFloat) -> CGFloat {
        var compressed = (value / 3) / limiter
        
        let index = options.firstIndex(of: state)
        let safeAfterIndex = options.indices.contains(index! + 1) ? (index! + 1) : index!
        let safeBeforeIndex = options.indices.contains(index! - 1) ? (index! - 1) : index!
        
        if translation < 0 {
            // Dragging up on last option
            if index == safeAfterIndex {
                return compressed / 10
            }
            
            // Dragging up on all other options
            if index != safeAfterIndex {
                let nextState = options[safeAfterIndex]
                let nextHeightConstant = (superViewHeight ?? 0) * (1 - nextState.value)
                if nextState == options.last {
                    compressed = compressed / 10
                }
                return frame.minY < nextHeightConstant ? compressed : value
            }
        }
        
        if translation > 0 {
            // Dragging down on first option
            if index == safeBeforeIndex {
                return compressed / 10
            }
            
            // Dragging down on all other options
            if index != safeBeforeIndex {
                let nextState = options[safeBeforeIndex]
                let nextHeightConstant = (superViewHeight ?? 0) * (1 - nextState.value)
                if nextState == options.first {
                    compressed = compressed / 10
                }
                return frame.minY > nextHeightConstant ? compressed : value
            }
        }
        
        return value
    }
    
    // Sets the state if the user swiped instead of dragged
    private func swipe(with translation: CGFloat) {
        let index = options.firstIndex(of: state)
        
        if translation < 0 {
            let safeAfterIndex = options.indices.contains(index! + 1) ? (index! + 1) : index!
            let nextState = options[safeAfterIndex]
            let nextHeightConstant = (superViewHeight ?? 0) * (1 - nextState.value)
            let distanceLeft = frame.minY - nextHeightConstant
            animationTime = (abs(distanceLeft) / velocity) * 3
            setState(nextState)
        }
        
        if translation > 0 {
            let safeBeforeIndex = options.indices.contains(index! - 1) ? (index! - 1) : index!
            let nextState = options[safeBeforeIndex]
            let nextHeightConstant = (superViewHeight ?? 0) * (1 - nextState.value)
            let distanceLeft = frame.minY - nextHeightConstant
            animationTime = (abs(distanceLeft) / velocity) * 3
            setState(nextState)
        }
    }
    
    // Changes the constraint constants as the user drags. When the gesture ends, updates the View state
    @objc private func gestureDrag(_ recognizer: UIPanGestureRecognizer) {
        var translation = externalTranslation == 0 ? recognizer.translation(in: self).y : externalTranslation
        translation -= substituteGestureOffset
        let offset = translation - lastLocation
        
        let compressedOffset = compresses ? compress(offset, with: translation) : offset
        
        dragCompletionHandler?(offset)
        lastLocation = translation
        
        switch recognizer.state {
            case .began:
                startTime = Date.timeIntervalSinceReferenceDate
                
            case .changed:
                if isDragDisabled {
                    return
                }
                
                topConstraint?.constant += compressedOffset
                bottomConstraint?.constant += abs(compressedOffset)
                            
            case .ended ,.cancelled:
                if isDragDisabled {
                    resetProperties()
                    return
                }
                
                endTime = Date.timeIntervalSinceReferenceDate
                let swipeVelocity = translation / CGFloat(gestureDuration)
                
                var shouldSwipe : Bool = false
                if abs(swipeVelocity) > velocityThreshold {
                    shouldSwipe = true
                }
                if shouldSwipe {
                    // perform swipe action
                    velocity = abs(swipeVelocity)
                    swipe(with: translation)
                } else {
                    // perform appropriate pan action
                    determineNextState(with: translation)
                }
        case .failed:
            print("fail")
        default:
            if externalIsDragging {
                calculateFromExternalDrag(with: offset)
            } else {
                //determineNextState(with: translation)
            }
            resetProperties()
        }
    }
    
    private func calculateFromExternalDrag(with translation: CGFloat) {
        topConstraint?.constant += translation
        bottomConstraint?.constant += abs(translation)
    }
    
    // Resets properties to be fresh for next animation / gesture logic
    private func resetProperties() {
        startLocation = 0
        lastLocation = 0
        startTime = 0
        endTime = 0
        bottomConstraint?.constant = 0
        animationTime = 0.3
        externalTranslation = 0
        substituteGestureOffset = 0
    }
    
    // Determines and sets the new state
    private func determineNextState(with translation: CGFloat) {
        let index = options.firstIndex(of: state)
        let safeAfterIndex = options.indices.contains(index! + 1) ? (index! + 1) : index!
        let safeBeforeIndex = options.indices.contains(index! - 1) ? (index! - 1) : index!
        
        if translation > 0 {
            let nextState = options[safeBeforeIndex]
            let nextHeightConstant = (superViewHeight ?? 0) * (1 - nextState.value)
            let middle = (nextHeightConstant - startLocation) / 2
            if translation > middle {
                setState(nextState)
            } else {
                setState(state)
            }
        } else if translation < 0 {
            let nextState = options[safeAfterIndex]
            let nextHeightConstant = (superViewHeight ?? 0) * (1 - nextState.value)
            let middle = (nextHeightConstant - startLocation) / 2
            if translation < middle {
                setState(nextState)
            } else {
                setState(state)
            }
        }
    }
    
    // Sets the width and center to superview. Makes custom top and bottom constraints that can be changed later
    private func setupConstraints() {
        widthAnchor.constraint(equalTo: superview!.widthAnchor).isActive = true
        centerXAnchor.constraint(equalTo: superview!.centerXAnchor).isActive = true
        
        topConstraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .top, multiplier: 1, constant: topConstant)
        
        bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: superview, attribute: .bottom, multiplier: 1, constant: 0)
        
        superview!.addConstraints([topConstraint!, bottomConstraint!])
    }
    
    // Animates the state change
    private func setHeight() {
        superview?.layoutIfNeeded()
        
        topConstraint?.constant = self.topConstant
        
        if animationTime > 0.5 {
            animationTime = 0.5
        }
        
        UIView.animate(withDuration: TimeInterval(animationTime), delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 5, options: .curveEaseInOut, animations: { [weak self] in
            guard let self = self else { return }
            self.superview?.layoutIfNeeded()
        }) { [weak self] _ in
            guard let self = self else { return }
            self.resetProperties()
        }
    }
}
