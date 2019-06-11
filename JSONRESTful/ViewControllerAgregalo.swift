//
//  ViewControllerAgregalo.swift
//  JSONRESTful
//
//  Created by MAC11 on 7/06/19.
//  Copyright © 2019 Carlos Alvarez. All rights reserved.
//

import UIKit

class ViewControllerAgregalo: UIViewController {
    var pelicula:Peliculas?
    var usuario = [Users]()
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtGenero: UITextField!
    @IBOutlet weak var txtDuracion: UITextField!

    @IBOutlet weak var botonGuardar: UIButton!
    
    @IBOutlet weak var botonAvtualizar: UIButton!
    @IBAction func btnGuardar(_ sender: Any) {
        let nombre = txtNombre.text!
        let genero = txtGenero.text!
        let duracion = txtDuracion.text!
        let datos = ["usuarioId":1,"nombre":"\(nombre)","genero":"\(genero)","duracion":"\(duracion)"] as Dictionary<String, Any>
        let ruta = "http://localhost:3000/peliculas"
        
        metodoPOST(ruta: ruta, datos: datos)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActualizar(_ sender: Any) {
        let nombre = txtNombre.text!
        let genero = txtGenero.text!
        let duracion = txtDuracion.text!
        let datos = ["usuarioId":1,"nombre":"\(nombre)","genero":"\(genero)","duracion":"\(duracion)"] as Dictionary<String, Any>
        let ruta = "http://localhost:3000/peliculas/\(pelicula!.id)"
        
        metodoPUT(ruta: ruta, datos: datos)
        navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if pelicula == nil {
            botonGuardar.isEnabled = true
            botonAvtualizar.isEnabled = false
        }else{
            botonGuardar.isEnabled = false
            botonAvtualizar.isEnabled = true
            txtNombre.text = pelicula!.nombre
            txtGenero.text = pelicula!.genero
            txtDuracion.text = pelicula!.duracion
        }
        // Do any additional setup after loading the view.
    }
    func metodoPOST(ruta:String, datos:[String:Any]) {
    let url : URL = URL(string: ruta)!
    var request = URLRequest(url : url)
    let session = URLSession.shared
    request.httpMethod = "POST"
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
    
//    func metodoPost(ruta:String, datos:[String:Any]){
//        let url : URL = URL(string: ruta)!
//        var request = URLRequest(url: url)
//        let session = URLSession.shared
//        request.httpMethod = "POST"
//
//        let params = datos
//
//        do{
//            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
//        }
//        catch
//        {
//
//        }
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        let task = session.dataTask(with: request, completionHandler:
//        {(data,response,error)in
//            if (data != nil){
//                do{
//                    let dict = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves)
//                    print(dict);
//                }
//                catch{
//
//                }
//            }
//        })
//        task.resume()
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
