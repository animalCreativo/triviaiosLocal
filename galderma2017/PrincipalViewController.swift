//
//  PrincipalViewController.swift
//  Galderpa_iPadApp
//
//  Created by Camilo on 30-01-16.
//  Copyright © 2016 Camilo. All rights reserved.
//

import UIKit

class PrincipalViewController: UIViewController {
    
    @IBOutlet weak var btnItem1: UIButton!
    @IBOutlet weak var btnItem2: UIButton!
    @IBOutlet weak var btnItem3: UIButton!
    
    @IBOutlet weak var imgBtnItem1: UIImageView!
    @IBOutlet weak var imgBtnItem2: UIImageView!
    @IBOutlet weak var imgBtnItem3: UIImageView!
    
    @IBOutlet weak var imgTitulo: UIImageView!
    
    @IBOutlet weak var principal_btnMenu: UIBarButtonItem!
    

    @IBOutlet weak var btnMenu: UIBarButtonItem!
    
    @IBOutlet weak var btnMenuSlideRight: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnMenuSlideRight.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.rightRevealToggle(_:)) , for: UIControlEvents.touchDown)
        
        if self.revealViewController() != nil {
            btnMenu.target = self.revealViewController()
            btnMenu.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            self.revealViewController().rightViewRevealWidth        = 268.0
            self.revealViewController().rightViewRevealOverdraw     = 0.0
            self.revealViewController().bounceBackOnOverdraw        = false
            self.revealViewController().springDampingRatio          = 1.0
            self.revealViewController().toggleAnimationDuration     = 0.7
            self.revealViewController().frontViewShadowRadius       = 10
            self.revealViewController().frontViewShadowOffset       = CGSize(width: 0, height: 2.5)
            self.revealViewController().frontViewShadowOpacity      = 1.0
            self.revealViewController().frontViewShadowColor        = UIColor.black
        }
 
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        btnMenuSlideRight.isHidden = true
        slide()
  
    }
    
    func slide(){
        btnItem1.isHidden=true
        btnItem2.isHidden=true
        btnItem3.isHidden=true
        
        imgBtnItem1.isHidden=true
        imgBtnItem2.isHidden=true
        imgBtnItem3.isHidden=true
        
        imgTitulo.alpha=0
        
        imgTitulo.fadeIn(withduration: 0.5)
        
        
        self.imgBtnItem1.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        self.imgBtnItem2.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        self.imgBtnItem3.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        
        delay(delay: 0.1){
            self.imgBtnItem1.isHidden=false
            self.imgBtnItem1.animationScaleEffect(view: self.imgBtnItem1, animationTime: 0.3)
        }
        delay(delay: 0.4){
            self.imgBtnItem2.isHidden=false
            self.imgBtnItem2.animationScaleEffect(view: self.imgBtnItem2, animationTime: 0.3)
        }
        delay(delay:0.7){
            self.imgBtnItem3.isHidden=false
            self.imgBtnItem3.animationScaleEffect(view: self.imgBtnItem3, animationTime: 0.3)
        }
        
        delay(delay:1.0){
            self.btnItem1.isHidden = false
            self.btnItem2.isHidden = false
            self.btnItem3.isHidden = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      /*
        if segue.identifier == "play" {
            let nextScene =  segue.destinationViewController as! DaylongSun00ViewController
            // Pass the selected object to the new view controller.
            nextScene.video = "play"
        }
 */
        
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

public extension UIView {
    
    /**
     Fade in a view with a duration
     
     - parameter duration: custom animation duration
     */
    func fadeIn(withduration duration:TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }
    
    
    /**
     Fade out a view with a duration
     
     - parameter duration: custom animation duration
     */
    func fadeOut(withduration duration:TimeInterval = 1.0) {
         UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        })
    }
    
    func animationScaleEffect(view:UIView,animationTime:Float){
        
        UIView.animate(withDuration: TimeInterval(animationTime),animations: {
            
            view.transform=CGAffineTransform(scaleX: 0.1, y: 0.1)},completion:{completion in UIView.animate(withDuration: TimeInterval(animationTime), animations: { () -> Void in
                
                view.transform=CGAffineTransform(scaleX: 1.0, y: 1.0)
                
            })
                
        })
        
    }
}

func delay(delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        closure()
    }
}



