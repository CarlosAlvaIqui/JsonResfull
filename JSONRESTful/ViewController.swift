//
//  ViewController.swift
//  JSONRESTful
//
//  Created by MAC11 on 6/06/19.
//  Copyright © 2019 Carlos Alvarez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var users = [Users]()
    @IBOutlet weak var txtUsuario: UITextField!
    
    @IBOutlet weak var txtContraseña: UITextField!

    @IBAction func loguear(_ sender: Any) {
        let ruta = "http://localhost:3000/usuarios?"
        let usuario = txtUsuario.text!
        let contraseña = txtContraseña.text!
        let url = ruta + "nombre=\(usuario)&clave=\(contraseña)"
        let crearURL = url.replacingOccurrences(of: "", with: "%20")
        validarUsuario(ruta: crearURL){
            if self.users.count <= 0{
                print("El nombre del usuario o contraseña son inconrrectos")
            }else{
                print("logeo Exitoso")
                self.performSegue(withIdentifier: "segueLogeo", sender: nil)
                for data in self.users{
                print("id:\(data.id),nombre:\(data.nombre),nombre\(data.email)")
                }
            }
        }
    }
    
    func validarUsuario(ruta:String, completed: @escaping () -> ()){
        let url = URL(string: ruta)
        URLSession.shared.dataTask(with: url!) { (data, response,
        error) in
            if error == nil{
                do{
                    self.users = try JSONDecoder().decode([Users].self,
                    from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                }catch{
                    print("Error en el json")
                }
            }
            
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            let siguienteVC = segue.destination as! Editar_PerfilViewController
//            siguienteVC.usuario = sender as? Users
        
//        if let nav = segue.destination as? UINavigationController,
//            let vc = nav.topViewController as? Editar_PerfilViewController {
//            vc.username = "Test"
//        }
        if let nav = segue.destination as? UINavigationController,
            let siguienteVC = nav.topViewController as? ViewControllerBuscar {
            siguienteVC.users = users
        }

    }
    
}

