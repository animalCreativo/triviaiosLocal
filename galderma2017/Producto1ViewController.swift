//
//  Producto1ViewController.swift
//  galderma2017
//
//  Created by Francisco Barrios Romo on 05-02-17.
//  Copyright © 2017 RentalApps. All rights reserved.
//

import UIKit
import Foundation
import SQLite
import MessageUI

class Producto1ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {

  
    @IBOutlet var tabla: UITableView!
    
    @IBOutlet weak var btnMenu: UIBarButtonItem!
    
    @IBOutlet weak var btnMenuSlideRight: UIButton!
    
    let usersTable = Table("users")
    let nombre_aux = Expression<String>("nombre")
    let email_aux = Expression<String>("email")
    let trivia_aux = Expression<String>("trivia")
    let fecha_aux = Expression<String>("fecha")
    
    var database: Connection!
    let id_aux = Expression<Int>("id")

    var data = ["id"]
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (data.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        
        
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Helvetica", size: 18)
        cell.textLabel?.textColor = UIColor.gray //
        cell.layer.backgroundColor = UIColor.clear.cgColor
        return cell
    }
    
    @IBAction func deleteBtn(_ sender: Any) {
        
       deleteUser()
       
    }
    
    
 
    @IBOutlet var mailBtn: UIButton!
    
    @IBAction func mailBtn(_ sender: Any) {
        
        
        
        
    
        do {
         
            let filename = "trivia"
            var strings = ""
            let subject = "Trivia Ilko"
            let messagebody = "Envio de trivia ilko"
            let to = "francisco.barriosr@gmail.com"
            
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                let aux_id = String(describing: user[self.id_aux])
                let aux_name = String(describing: user[self.nombre_aux])
                let aux_email = String(describing: user[self.email_aux])
                let aux_win = String(describing: user[self.trivia_aux])
                let aux_date = String(describing: user[self.fecha_aux])
                strings.append(aux_id + "\t " + aux_name + "\t " + aux_email + "\t " + aux_win + "\t " + aux_date + "\n ")
                
            }
            
         
            
            if(MFMailComposeViewController.canSendMail()){
                
                let mailComposer = MFMailComposeViewController()
                mailComposer.mailComposeDelegate = self
                mailComposer.setToRecipients(["\(to)"] )
                mailComposer.setSubject("\(subject)" )
                mailComposer.setMessageBody("\(messagebody)", isHTML: false)
                
                if let data = (strings as NSString).data(using: String.Encoding.utf8.rawValue){
                    //Attach File
                    mailComposer.addAttachmentData(data, mimeType: "text/plain", fileName: filename)
                    self.present(mailComposer, animated: true, completion: nil)
                }
            }
            
            
            
         
        } catch {
            print(error)
        }
 
        
   
        
        
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
        load()
        tabla.reloadData()
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue :
            print("Cancelled")
            
        case MFMailComposeResult.failed.rawValue :
            print("Failed")
            
        case MFMailComposeResult.saved.rawValue :
            print("Saved")
            
        case MFMailComposeResult.sent.rawValue :
            print("Sent")
            
            
            
        default: break
            
            
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func load(){
        do {
            data.removeAll()
            let users = try self.database.prepare(self.usersTable)
            for user in users {
                print("userId: \(user[self.id_aux]), nombre: \(user[self.nombre_aux]), email: \(user[self.email_aux]), trivia: \(user[self.trivia_aux]), fecha: \(user[self.fecha_aux])")
                let aux_id = String(describing: user[self.id_aux])
                let aux_name = String(describing: user[self.nombre_aux])
                let aux_email = String(describing: user[self.email_aux])
                let aux_win = String(describing: user[self.trivia_aux])
                let aux_date = String(describing: user[self.fecha_aux])
                data.append(aux_id + "\t " + aux_name + "\t " + aux_email + "\t " + aux_win + "\t " + aux_date)
                
            }
        } catch {
            print(error)
        }
    }
   
    func deleteUser(){
        print("DELETE TAPPED")
        let alert = UIAlertController(title: "Borrar Usuario", message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "Ingresar Id"; tf.keyboardType = .decimalPad
        }
        
        
        let action = UIAlertAction(title: "Borrar", style: .default) { (_) in
            guard let userIdString = alert.textFields?.first?.text,
                let userId = Int(userIdString)
                else { return }
            print(userIdString)
            
            let user = self.usersTable.filter(self.id_aux == userId)
            let deleteUser = user.delete()
            do {
                try self.database.run(deleteUser)
                DispatchQueue.main.async {
                    self.load()
                    self.tabla.reloadData()
                }
            } catch {
                print(error)
            }
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
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

