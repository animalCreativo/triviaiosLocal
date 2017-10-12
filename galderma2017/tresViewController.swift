//
//  tresViewController.swift
//  galderma2017
//
//  Created by Francisco Barrios Romo on 09-10-17.
//  Copyright © 2017 RentalApps. All rights reserved.
//

import UIKit
import FCAlertView

class tresViewController: UIViewController,FCAlertViewDelegate  {
    
    @IBOutlet var btnNext: UIButton!
    
    @IBOutlet var titulo: UILabel!
    
    @IBOutlet var lblItem1: UILabel!
    @IBOutlet var lblItem2: UILabel!
    
    var respuesta = ""
    
    @IBAction func btn1(_ sender: Any) {
        if (respuesta == "1"){
            cont = cont + 1
            print("Respuesta Correcta")
            
        }else {
            print("Respuesta Incorrecta")
        }
        print("cont Final: ",cont)
        if (cont >= 2){
            let alert = FCAlertView();
            alert.delegate = self
            alert.showAlert(inView: self,
                            withTitle: "¡Felicidades!",
                            withSubtitle: "Has respondido correctamente la mayoría de las Preguntas.",
                            withCustomImage:nil,
                            withDoneButtonTitle: nil,
                            andButtons:nil)
            alert.makeAlertTypeSuccess()
            alert.dismissOnOutsideTouch = true
            print("¡Felicidades!",cont)
            saveWin()
            
        }else{
            let alert = FCAlertView();
            alert.delegate = self
            alert.showAlert(inView: self,
                            withTitle: "Has perdido",
                            withSubtitle: "Gracias por participar",
                            withCustomImage: nil,
                            withDoneButtonTitle: nil,
                            andButtons: nil)
            alert.makeAlertTypeWarning()
            alert.dismissOnOutsideTouch = true
            print("Has perdido",cont)
            saveLose()
        }
    }

 
    
    @IBAction func btn2(_ sender: Any) {
        if (respuesta == "2"){
            cont = cont + 1
            print("Respuesta Correcta")
        
        }else {
            print("Respuesta Incorrecta")
        }
        print("cont Final: ",cont)
        if (cont >= 2){
            let alert = FCAlertView();
            alert.delegate = self
            alert.showAlert(inView: self,
                            withTitle: "¡Felicidades!",
                            withSubtitle: "Has respondido correctamente la mayoría de las Preguntas.",
                            withCustomImage:nil,
                            withDoneButtonTitle: nil,
                            andButtons:nil)
            alert.makeAlertTypeSuccess()
            alert.dismissOnOutsideTouch = true
             print("¡Felicidades!",cont)
            saveWin()
        }else{
            let alert = FCAlertView();
            alert.delegate = self
            alert.showAlert(inView: self,
                            withTitle: "Has perdido",
                            withSubtitle: "Gracias por participar",
                            withCustomImage: nil,
                            withDoneButtonTitle: nil,
                            andButtons: nil)
            alert.makeAlertTypeWarning()
            alert.dismissOnOutsideTouch = true
             print("Has perdido",cont)
            saveLose()
        }
    }
    var nombre = ""
    var email = ""
    var cont = 0
    
    func saveWin(){
        let Url = String(format: "http://165.227.126.154:8000/users")
        guard let serviceUrl = URL(string: Url) else { return }
        //        let loginParams = String(format: LOGIN_PARAMETERS1, "test", "Hi World")
        let parameterDictionary = ["username" : self.nombre, "email" : self.email, "trivia": "true"]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                }catch {
                    print(error)
                }
            }
            }.resume()
        

    }
    func saveLose(){
        let Url = String(format: "http://165.227.126.154:8000/users")
        guard let serviceUrl = URL(string: Url) else { return }
        //        let loginParams = String(format: LOGIN_PARAMETERS1, "test", "Hi World")
        let parameterDictionary = ["username" : self.nombre, "email" : self.email, "trivia": "false"]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                }catch {
                    print(error)
                }
            }
            }.resume()
        
        
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
        
        var request = URLRequest(url: URL(string: "http://165.227.126.154:8000/q3")!)
        
        var pregunta = ""
        var alt_a = "", alt_b = "";
        var aws = ""
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
            
           // print("responseString:", responseString)
        
            let list = self.convertToDictionary(text: responseString ) as? [AnyObject]
            
           // print(list!)
            
            pregunta = (list?[0]["pregunta"] as? String)!
            aws = String((list?[0]["aws"] as? Int32)!)
            alt_a = (list?[0]["alt_a"] as? String)!
            alt_b =  (list?[0]["alt_b"] as? String)!
            
           /* print("pregunta:",pregunta)
            print("aws:",aws)
            print("alt_a:",alt_a)
            print("alt_b:",alt_b)
             */
            DispatchQueue.main.async {
                self.titulo.text = pregunta
                self.lblItem1.text = alt_a
                self.lblItem2.text = alt_b
                self.respuesta = aws
            }
            
            
        }
        task.resume()
        
        print("--------Tres-----------")
        print("nombre: ", nombre)
        print("email: ",email)
        print("cont: ",cont)
    }
 
    
    func fcAlertDoneButtonClicked(_ alertView: FCAlertView){
        print("Btn Aceptar")
        self.btnNext.sendActions(for: .touchUpInside)
   
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
