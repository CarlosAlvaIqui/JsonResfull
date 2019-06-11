//
//  Editar_PerfilViewController.swift
//  JSONRESTful
//
//  Created by MAC11 on 11/06/19.
//  Copyright © 2019 Carlos Alvarez. All rights reserved.
//

import UIKit

class Editar_PerfilViewController: UIViewController {
    var users = [Users]()
    var id = 0
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtClave: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    
    @IBAction func btnEditarPerfil(_ sender: Any) {
        
        let nombre = txtNombre.text!
        let clave = txtClave.text!
        let email = txtEmail.text!
        let datos = ["nombre":"\(nombre)","clave":"\(clave)","email":"\(email)"] as Dictionary<String, Any>
        let ruta = "http://localhost:3000/usuarios/\(id)"
        
 metodoPUT(ruta: ruta, datos: datos)
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for data in self.users{
            print("id:\(data.id),nombre:\(data.nombre),nombre\(data.email)")
            txtNombre.text = data.nombre
            txtClave.text = data.clave
            txtEmail.text = data.email
            id = data.id
        }

        // Do any additional setup after loading the view.
    }
    
    func metodoPUT(ruta:String, datos:[String:Any]) {
        let url : URL = URL(string: ruta)!
        var request = URLRequest(url : url)
        let session = URLSession.shared
        request.httpMethod = "PUT"
        let params = datos
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
        }
        catch{
            
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request, completionHandler:{(data,response,error) in
            if (data != nil)
            {
                do{
                    let dict = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves)
                }
                catch{
                    
                }
            }
        })
        task.resume()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
