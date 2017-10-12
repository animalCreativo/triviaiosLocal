//
//  unoViewController.swift
//  galderma2017
//
//  Created by Francisco Barrios Romo on 09-10-17.
//  Copyright © 2017 RentalApps. All rights reserved.
//

import UIKit

class unoViewController: UIViewController {
    
    var nombre = ""
    var email = ""
    var cont = 0
    var respuesta = ""
    
    @IBOutlet var lblItem1: UILabel!
    @IBOutlet var lblItem2: UILabel!
    @IBOutlet var lblItem3: UILabel!
    @IBOutlet var titulo: UILabel!
    
    @IBOutlet var imgItem1: UIImageView!
    @IBOutlet var imgItem2: UIImageView!
    @IBOutlet var imgItem3: UIImageView!
    
    
    @IBOutlet var bntNext: UIButton!
    
    @IBAction func btn1(_ sender: Any) {
        if (respuesta == "1"){
            cont = cont + 1
            print("Respuesta Correcta")
            self.bntNext.sendActions(for: .touchUpInside)
        }else {
            print("Respuesta Incorrecta")
            self.bntNext.sendActions(for: .touchUpInside)
        }
    }
    
    @IBAction func btn2(_ sender: Any) {
        if (respuesta == "2"){
            cont = cont + 1
            print("Respuesta Correcta")
            self.bntNext.sendActions(for: .touchUpInside)
        }else {
            print("Respuesta Incorrecta")
            self.bntNext.sendActions(for: .touchUpInside)
        }
    }
    
    @IBAction func btn3(_ sender: Any) {
        if (respuesta == "3"){
            cont = cont + 1
            print("Respuesta Correcta")
            self.bntNext.sendActions(for: .touchUpInside)
        }else {
            print("Respuesta Incorrecta")
            self.bntNext.sendActions(for: .touchUpInside)
        }
    }
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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let valor = 28.0
        
        self.lblItem1.font = self.lblItem1.font.withSize(CGFloat(valor))
        self.lblItem2.font = self.lblItem2.font.withSize(CGFloat(valor))
        self.lblItem3.font = self.lblItem3.font.withSize(CGFloat(valor))
        
        var request = URLRequest(url: URL(string: "http://165.227.126.154:8000/q1")!)
        
        var pregunta = ""
        var alt_a = "", alt_b = "" , alt_c = "";
        var aws = ""
        var id = ""
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
            
            //print("responseString:", responseString)
            
           
            let list = self.convertToDictionary(text: responseString ) as? [AnyObject]
            
           // print(list!)
            pregunta = (list?[0]["pregunta"] as? String)!
            aws = String((list?[0]["aws"] as? Int32)!)
            id = String((list?[0]["id"] as? Int32)!)
            alt_a = (list?[0]["alt_a"] as? String)!
            alt_b =  (list?[0]["alt_b"] as? String)!
            alt_c =  (list?[0]["alt_c"] as? String)!
           
           /* print("pregunta:",pregunta)
            print("aws:",aws)
            print("alt_a:",alt_a)
            print("alt_b:",alt_b)
            print("alt_c:",alt_c)
*/
            DispatchQueue.main.async {
                self.titulo.text = pregunta
                self.lblItem1.text = alt_a
                self.lblItem2.text = alt_b
                self.lblItem3.text = alt_c
                self.respuesta = aws
                
                if(id == "1"){
                    self.imgItem1.image = UIImage(named: "item11.png")
                    self.imgItem2.image = UIImage(named: "item12.png")
                    self.imgItem3.image = UIImage(named: "item13.png")
                  
                }else if(id == "2"){

                    self.imgItem1.image = UIImage(named: "item21.png")
                    self.imgItem2.image = UIImage(named: "item22.png")
                    self.imgItem3.image = UIImage(named: "item23.png")

                }else if(id == "5"){

                    self.imgItem1.image = UIImage(named: "item51.png")
                    self.imgItem2.image = UIImage(named: "item52.png")
                    self.imgItem3.image = UIImage(named: "item53.png")
                   
                }else if(id == "9"){
                    self.imgItem1.image = UIImage(named: "item91.png")
                    self.imgItem2.image = UIImage(named: "item92.png")
                    self.imgItem3.image = UIImage(named: "item93.png")
                }
            }
            
            
        }
        task.resume()
        
        
        print("--------Uno-----------")
        print("nombre: ", nombre)
        print("email: ",email)
        print("cont: ",cont)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "uno" {
            let nextScene =  segue.destination as! dosViewController
            // Pass the selected object to the new view controller.
            nextScene.nombre = self.nombre
            nextScene.email = self.email
            nextScene.cont = self.cont
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
