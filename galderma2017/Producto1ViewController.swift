//
//  Producto1ViewController.swift
//  galderma2017
//
//  Created by Francisco Barrios Romo on 05-02-17.
//  Copyright © 2017 RentalApps. All rights reserved.
//

import UIKit
import Foundation

class Producto1ViewController: UIViewController {

  
    
    @IBOutlet weak var btnMenu: UIBarButtonItem!
    
    @IBOutlet weak var btnMenuSlideRight: UIButton!
    
    
    @IBOutlet var nombre: UILabel!
    
    @IBOutlet var email: UILabel!
    
    func convertToDictionary(text: String) -> Any? {
        
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? Any
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return nil
        
    }
    @IBAction func buscar(_ sender: Any) {
        
       
        var request = URLRequest(url: URL(string: "http://165.227.126.154:8000/getWinnerAllCeldas")!)
        
        var nombre_aux = ""
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            let responseString = String(data: data, encoding: .utf8)!
            
            print("responseString:", responseString)
            
            
            let list = self.convertToDictionary(text: responseString ) as? [AnyObject]
                
            print(list!)
            nombre_aux = (list?[0]["username"] as? String)!
             print("nombre:",nombre_aux)
            
            DispatchQueue.main.async {
                self.nombre.text = nombre_aux
            }
            
            
        }
        task.resume()
        
        
        
        
        
    }
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
        btnMenuSlideRight.isHidden = false
        slide()
        
    }
    
    func slide(){
     
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

