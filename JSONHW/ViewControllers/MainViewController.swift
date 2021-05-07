//
//  ViewController.swift
//  JSONHW
//
//  Created by Кирилл Нескоромный on 30.04.2021.
//

import Spring

class MainViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet weak var springLabel: SpringLabel!
    
    // test commit
    @IBOutlet weak var topButton: SpringButton!
    @IBOutlet weak var midButton: SpringButton!
    @IBOutlet weak var botButton: SpringButton!
    
    //MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        springLabel.animation = "slideDown"
        springLabel.animate()
        
        buttonAnimate(
            object: topButton,
            animation: "slideUp",
            duration: 3.0,
            delay: 1.0,
            force: 1.5
        )
        buttonAnimate(
            object: midButton,
            animation: "slideUp",
            duration: 3.0,
            delay: 1.5,
            force: 1.5
        )
        buttonAnimate(
            object: botButton,
            animation: "slideUp",
            duration: 3.0,
            delay: 2.0,
            force: 1.5
        )
        
        UIView.animateKeyframes(withDuration: 4.0, delay: 2.0) {
            self.springLabel.textColor = .black
            
            self.configureColor(for: self.topButton,
                                color: UIColor(
                                    red: 87/255,
                                    green: 107/255,
                                    blue: 224/255,
                                    alpha: 1.0
            )
            )
            self.configureColor(for: self.midButton,
                                color: UIColor(
                                    red: 218/255,
                                    green: 128/255,
                                    blue: 147/255,
                                    alpha: 1.0
            )
            )
            self.configureColor(for: self.botButton,
                                color: UIColor(
                                    red: 37/255,
                                    green: 127/255,
                                    blue: 108/255,
                                    alpha: 1.0
            )
            )
        }
    }
    //MARK: - Private Methods
    private func buttonAnimate(
        object: SpringButton,
        animation: String,
        duration: CGFloat,
        delay: CGFloat,
        force: CGFloat
    ) {
        object.animation = animation
        object.duration = duration
        object.delay = delay
        object.force = force
        object.animate()
    }
    
    private func configureColor(for view: UIView, color: UIColor) {
        UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0) {
            
            view.backgroundColor = color
        }
    }
    
    
}


