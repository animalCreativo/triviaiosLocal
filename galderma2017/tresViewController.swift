//
//  tresViewController.swift
//  galderma2017
//
//  Created by Francisco Barrios Romo on 09-10-17.
//  Copyright © 2017 RentalApps. All rights reserved.
//

import UIKit
import FCAlertView
import SQLite

class tresViewController: UIViewController,FCAlertViewDelegate  {
    
    @IBOutlet var btnNext: UIButton!
    
    @IBOutlet var titulo: UILabel!
    
    @IBOutlet var lblItem1: UILabel!
    @IBOutlet var lblItem2: UILabel!
    
    var respuesta = ""
    let usersTable = Table("users")
    
    let nombre_aux = Expression<String>("nombre")
    let email_aux = Expression<String>("email")
    let trivia_aux = Expression<String>("trivia")
    let fecha_aux = Expression<String>("fecha")
    
    var database: Connection!
    let id_aux = Expression<Int>("id")
    let pregunta_aux = Expression<String>("pregunta")
    let tipo_aux = Expression<String>("tipo")
    let aws_aux = Expression<String>("aws")
    let alt_a_aux = Expression<String>("alt_a")
    let alt_b_aux = Expression<String>("alt_b")
    let alt_c_aux = Expression<String>("alt_c")
    
    
    
    
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
                            withSubtitle: "Estás participando por premios del Arte de La Cocina. \n Pronto te enviaremos novedades a tu correo electrónico. ",
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
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        print(formatter.string(from: date))
       
        let insertUser = self.usersTable.insert(self.nombre_aux <- self.nombre, self.email_aux <- self.email, self.trivia_aux <- "True",self.fecha_aux <- formatter.string(from: date) )
        
        do {
            try self.database.run(insertUser)
            print("save win")
            listU()
        } catch {
            print(error)
            print("No se grabo")
        }
       
        
        
        
    }
    func saveLose(){
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        print(formatter.string(from: date))
        
        let insertUser = self.usersTable.insert(self.nombre_aux <- self.nombre, self.email_aux <- self.email, self.trivia_aux <- "False",self.fecha_aux <- formatter.string(from: date) )
        
        do {
            try self.database.run(insertUser)
            print("save lose")
            listU()
        } catch {
            print(error)
            print("No se grabo")
        }
        
       
    }
    
    func listU(){
        print("LIST TAPPED")
        
        do {
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                print("userId: \(user[self.id_aux]), nombre: \(user[self.nombre_aux]), email: \(user[self.email_aux]), trivia: \(user[self.trivia_aux]), fecha: \(user[self.fecha_aux])")
            }
        } catch {
            print(error)
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
        
        self.usersTable.create { (table) in
            table.column(self.id_aux, primaryKey: true)
            table.column(self.nombre_aux)
            table.column(self.email_aux)
            table.column(self.trivia_aux)
            table.column(self.fecha_aux)
        }
        
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("users").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
            print(error)
        }
        // Do any additional setup after loading the view.
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        do {
            
            for row in try self.database.prepare("SELECT * FROM question WHERE tipo = 3 ORDER BY RANDOM() LIMIT 1") {
                print("id: \(row[0]), pregunta: \(row[1]), tipo: \(row[2]), aws: \(row[3])")
                print("alt_a: \(row[4])")
                print("alt_b: \(row[5])")
                print("alt_c: \(row[6])")
                
                
                self.titulo.text = row[1] as? String
                self.lblItem1.text = row[4] as? String
                self.lblItem2.text = row[5] as? String
    
                self.respuesta =  String(describing: row[3]!)
    
                print("aws:", respuesta)
            }
            
        }catch {
            print(error)
        }
        
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
