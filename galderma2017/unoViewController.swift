//
//  unoViewController.swift
//  galderma2017
//
//  Created by Francisco Barrios Romo on 09-10-17.
//  Copyright © 2017 RentalApps. All rights reserved.
//

import UIKit
import SQLite

class unoViewController: UIViewController {
    
    var nombre = ""
    var email = ""
    var cont = 0
    var respuesta = ""
    var id = ""
    
    var database: Connection!
    let pregunta_aux = Expression<String>("pregunta")
    let tipo_aux = Expression<String>("tipo")
    let aws_aux = Expression<String>("aws")
    let alt_a_aux = Expression<String>("alt_a")
    let alt_b_aux = Expression<String>("alt_b")
    let alt_c_aux = Expression<String>("alt_c")
    
    
    
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
        
        let valor = 28.0
        
        self.lblItem1.font = self.lblItem1.font.withSize(CGFloat(valor))
        self.lblItem2.font = self.lblItem2.font.withSize(CGFloat(valor))
        self.lblItem3.font = self.lblItem3.font.withSize(CGFloat(valor))

        do {
            
            for row in try self.database.prepare("SELECT * FROM question WHERE tipo = 1 ORDER BY RANDOM() LIMIT 1") {
                print("id: \(row[0]), pregunta: \(row[1]), tipo: \(row[2]), aws: \(row[3])")
                print("alt_a: \(row[4])")
                print("alt_b: \(row[5])")
                print("alt_c: \(row[6])")
                
                
                self.titulo.text = row[1] as? String
                self.lblItem1.text = row[4] as? String
                self.lblItem2.text = row[5] as? String
                self.lblItem3.text = row[6] as? String
                self.id =  String(describing: row[0]!)
                self.respuesta =  String(describing: row[3]!)
                
                print("id:", id)
                print("aws:", respuesta)
            }
            
        }catch {
            print(error)
        }

      
        
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
