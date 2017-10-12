//
//  PrincipalViewController.swift
//  Galderpa_iPadApp
//
//  Created by Camilo on 30-01-16.
//  Copyright © 2016 Camilo. All rights reserved.
//

import UIKit
import FCAlertView

class PrincipalViewController: UIViewController , UITextFieldDelegate{
    

    @IBOutlet weak var imgTitulo: UIImageView!
    
    @IBOutlet weak var principal_btnMenu: UIBarButtonItem!
    

    @IBOutlet weak var btnMenu: UIBarButtonItem!
    
    @IBOutlet weak var btnMenuSlideRight: UIButton!
    
    @IBOutlet var nombre: UITextField!
    
    @IBOutlet var email: UITextField!
    
    var cont = 0
    
    
    
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
 
         self.nombre.delegate = self;
         self.email.delegate = self;
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        btnMenuSlideRight.isHidden = false
     
  
    }
    

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true);
        return false;
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let aux = 100
        ViewUpanimateMoving(up: true, upValue: CGFloat(aux))
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        let aux = 100
        ViewUpanimateMoving(up: false, upValue: CGFloat(aux))
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        print("touch")
        if (nombre.text == ""){
            nombre.text = "Nombre"
        }
        if (email.text == ""){
            email.text = "Email"
        }
    }
    func ViewUpanimateMoving (up:Bool, upValue :CGFloat){
        let durationMovement:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -upValue : upValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(durationMovement)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        if segue.identifier == "login" {
            let nextScene =  segue.destination as! unoViewController
            // Pass the selected object to the new view controller.
            nextScene.nombre = self.nombre.text!
            nextScene.email = self.email.text!
            nextScene.cont = self.cont
        }

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



