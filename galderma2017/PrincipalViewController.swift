//
//  PrincipalViewController.swift
//  Galderpa_iPadApp
//
//  Created by Camilo on 30-01-16.
//  Copyright © 2016 Camilo. All rights reserved.
//

import UIKit
import FCAlertView
import SQLite

class PrincipalViewController: UIViewController , UITextFieldDelegate{
    
    var dataQuestion: [(id: Int32,pregunta: String, tipo: String, aws: String, alt_a: String, alt_b: String, alt_c: String)] = {
        var values = [(id: Int32,pregunta: String, tipo: String, aws: String, alt_a: String, alt_b: String, alt_c: String)]()
        
        values.append((id: 1, pregunta:    "¿Cuál de estos ingredientes es de origen mapuche?" , tipo:     "1", aws:    "1"    , alt_a: "Merkén" , alt_b:    "Pimienta" , alt_c:    "Ajo" ))
        values.append((id: 2, pregunta:    "¿Cuántos tipos de papas hay en Chile?" , tipo:     "1", aws:    "2"    , alt_a: "105"  , alt_b: "211" , alt_c:"300" ))
        values.append((id: 3, pregunta:    "Hay que añadir una pizca de azúcar a las claras antes de batirlas a punto nieve." , tipo:     "3" ,aws:    "2"    , alt_a: "Verdadero" , alt_b:    "Falso", alt_c:    "NULL"))
        values.append((id: 4, pregunta:    "¿Cuál de estos es un \"faux pas\" en la cocina italiana?" , tipo:     "2", aws:    "1"    , alt_a: "Dejar la pasta como pulpa." , alt_b:    "Poner crema en una salsa carbonara.",  alt_c:    "Partir el spaghetti por la mitad para que quepa en la olla."))
        values.append((id: 5, pregunta:    "¿Qué ingrediente no corta la leche?" , tipo:     "1", aws:    "3"    , alt_a: "Jugo de limón." , alt_b:    "Vinagre.", alt_c:    "Bicarbonato."))
        values.append((id: 6, pregunta:    "¿Cuáles son los ingredientes especiales de una salsa bechamel?" , tipo:     "2", aws:    "3"    , alt_a: "Leche, huevo, harina." , alt_b:    "Huevos, mantequilla." , alt_c:    "Leche, mantequilla y harina."))
        values.append((id: 7, pregunta:    "Luego de que el agua hierve ¿Cuál es el tiempo ideal para lograr un huevo duro?" , tipo:     "2", aws:    "2"    , alt_a: "Entre 5 y 7 min." , alt_b:    "Entre 10 y 12 min." , alt_c:    "Entre 6 y 9 min."))
        values.append((id: 8, pregunta:    "¿Qué es un fondo?" , tipo:     "2", aws:    "2"    , alt_a: "Agua con aceite y sal para cocinar cualquier cosa." , alt_b:    "Un caldo que se prepara como primer paso en una preparación." , alt_c:    "Una sopa italiana que se sirve antes de la cena."))
        values.append((id: 9, pregunta:    "¿Cuál es el país de origen de la mayonesa?" , tipo:     "1", aws:    "3"    , alt_a: "Italia." , alt_b:    "España.", alt_c:    "Francia."))
        values.append((id: 10, pregunta: "¿Qué es una emulsión?" , tipo:     "2", aws:    "2"    , alt_a: "Transformación de comida sólida a líquida." , alt_b:    "La mezcla de dos líquidos que normalmente no se juntarían.", alt_c: "El resultado de presionar la comida en un plato."))
        values.append((id: 11, pregunta: "¿Para qué se utiliza el corte en bastones?" , tipo:     "2", aws:    "2"    , alt_a: "Para guarniciones." , alt_b:    "Para frituras y salteados." , alt_c:    "Para puré."))
        values.append((id: 12, pregunta: "¿Qué significa \"tamizar\" algo?" , tipo:     "2", aws:    "3"    , alt_a: "Pasar los ingredientes por harina para que tengan mayor consistencia." , alt_b:    "Mezclar el harina con agua y vinagre para mejorar el sabor de los alimentos." , alt_c:    "Pasarlo por un colador para volverlo más fino y quitarle las impurezas."))
        values.append((id: 13, pregunta: "En la cocina, ¿A qué se refiere el término reducir?" , tipo:     "2", aws:    "2"    , alt_a: "A la disminución del volumen de un preparado sólido por líquido." , alt_b:    "A la disminución del volumen de un preparado líquido por evaporación." , alt_c: "A la disminución del volumen de un preparado líquido por sólido."))
        values.append((id: 14, pregunta: "¿Qué es macerar los alimentos?" , tipo:     "2", aws:    "2"    , alt_a: "Introducir cualquier carne en algún líquido para que se ablanden y adquieran aroma." , alt_b:   "Remojar varios alimentos en vino o licores para que adquieran sabor." , alt_c:"Introducir un alimento crudo en vinagre, sal, orégano, ajo y/o pimiento."))
        values.append((id: 15, pregunta: "Para hacer un pastel, deben enharinarse las frutas confitadas para que no se vayan al fondo."    , tipo: "3" , aws:   "2"    , alt_a: "Verdadero", alt_b: "Falso", alt_c: "NULL"))
        values.append((id: 16, pregunta: "Para que un Soufflé salga a la perfección, hay que abrir la puerta del horno para comprobar que esté subiendo.",tipo: "3"    , aws: "2" , alt_a:     "Verdadero"     , alt_b: "Falso", alt_c: "NULL"))
        values.append((id: 17, pregunta: "¿Qué fruto seco sale de las uvas?" , tipo:     "2", aws:    "3"    , alt_a: "Almendras." , alt_b:     "Dátiles." , alt_c:     "Pasas."))
        values.append((id: 18, pregunta: "¿En qué continente tiene origen el arroz?" , tipo:     "2", aws:    "1"    , alt_a: "Asia." , alt_b:     "Europa." , alt_c:     "América."))
        values.append((id: 19, pregunta: "¿Qué denota la palabra francesa \"baguette\" ?" , tipo:     "2", aws:    "2"    , alt_a: "Un cubierto."  , alt_b:  "Un pan."   , alt_c: "Tipo de vino."))
        values.append((id: 20, pregunta: "¿Qué es un \"aguacate\"?" , tipo:     "2", aws:    "3"    , alt_a: "Camote."    , alt_b: "Abobora."    , alt_c: "Palta."))
        
        
        return values
    }()
    
    
    var database: Connection!
    let usersTable = Table("users")
    let questionTable = Table("question")
    let id_aux = Expression<Int>("id")
    let nombre_aux = Expression<String>("nombre")
    let email_aux = Expression<String>("email")
    let trivia_aux = Expression<String>("trivia")
    let fecha_aux = Expression<String>("fecha")
    
    let pregunta_aux = Expression<String>("pregunta")
    let tipo_aux = Expression<String>("tipo")
    let aws_aux = Expression<String>("aws")
    let alt_a_aux = Expression<String>("alt_a")
    let alt_b_aux = Expression<String>("alt_b")
    let alt_c_aux = Expression<String>("alt_c")
    
    
    @IBOutlet weak var imgTitulo: UIImageView!
    
    @IBOutlet weak var principal_btnMenu: UIBarButtonItem!
    

    @IBOutlet weak var btnMenu: UIBarButtonItem!
    
    @IBOutlet weak var btnMenuSlideRight: UIButton!
    
    @IBOutlet var nombre: UITextField!
    
    @IBOutlet var email: UITextField!
    
    var cont = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // conectar a base datos
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("users").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
            print(error)
        }
        crearTablas()
        loadQ()
        
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
     
        //listQ()
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

    func crearTablas(){
        let createTable = self.usersTable.create { (table) in
            table.column(self.id_aux, primaryKey: true)
            table.column(self.nombre_aux)
            table.column(self.email_aux)
            table.column(self.trivia_aux)
            table.column(self.fecha_aux)
        }
        
        
        let createTableQ = self.questionTable.create { (table) in
            table.column(self.id_aux, primaryKey: true)
            table.column(self.pregunta_aux)
            table.column(self.tipo_aux)
            table.column(self.aws_aux)
            table.column(self.alt_a_aux)
            table.column(self.alt_b_aux)
            table.column(self.alt_c_aux)
            
        }
        
        do {
            try self.database.run(createTable)
            print("Created Table Users")
        } catch {
            print(error)
        }
        
        do {
            try self.database.run(createTableQ)
            print("Created Table Q")
        } catch {
            print(error)
        }
    }
    
    func loadQ(){
        do {
            let users =  try  self.database.scalar(self.questionTable.count)
            print("count", users)
            if (users == 0){
                for index in 0..<dataQuestion.count {
                    insertQ(pregunta: dataQuestion[index].pregunta, tipo: dataQuestion[index].tipo, aws: dataQuestion[index].aws, alt_a: dataQuestion[index].alt_a, alt_b: dataQuestion[index].alt_b, alt_c: dataQuestion[index].alt_c)
                }
            }
            
        }catch {
            print(error)
        }
    }
    func listQ(){
        do {
            let users = try self.database.prepare(self.questionTable)
            
            for user in users {
                print("id: \(user[self.id_aux]), pregunta: \(user[self.pregunta_aux]), tipo: \(user[self.tipo_aux]), aws: \(user[self.aws_aux]), alt_a: \(user[self.alt_a_aux]), alt_b: \(user[self.alt_b_aux]), alt_c: \(user[self.alt_c_aux])")
            }
            
        } catch {
            print(error)
        }
    }
    
    func insertQ(pregunta:String, tipo: String, aws: String, alt_a: String, alt_b: String , alt_c: String){
        
        let insertUser = self.questionTable.insert(self.pregunta_aux <- pregunta, self.tipo_aux <- tipo, self.aws_aux <- aws ,self.alt_a_aux <- alt_a ,self.alt_b_aux <- alt_b ,self.alt_c_aux <- alt_c )
        
        do {
            try self.database.run(insertUser)
            print("INSERTED USER")
        } catch {
            print(error)
        }
        
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



