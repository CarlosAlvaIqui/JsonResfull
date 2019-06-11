//
//  ViewControllerBuscar.swift
//  JSONRESTful
//
//  Created by MAC11 on 6/06/19.
//  Copyright © 2019 Carlos Alvarez. All rights reserved.
//

import UIKit

class ViewControllerBuscar: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    
var peliculas = [Peliculas]()
var users = [Users]()

    @IBOutlet weak var txtBuscar: UITextField!
    
    @IBOutlet weak var tablaPeliculas: UITableView!
    
    @IBAction func btnSalir(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnenvtoeditar(_ sender: Any) {
        performSegue(withIdentifier: "segueEditar_Perfil", sender: nil)
    }
    
    @IBAction func btnBuscar(_ sender: Any) {
        let ruta = "http://localhost:3000/peliculas?"
        let nombre = txtBuscar.text!
        let url = ruta + "nombre_like=\(nombre)"
        let crearURL = url.replacingOccurrences(of: "", with: "%20")
        
            if nombre.isEmpty{
                let ruta = "http://localhost:3000/peliculas/"
                self.cargarPeliculas(ruta: ruta){
                    self.tablaPeliculas.reloadData()
                }

            }else{
                cargarPeliculas(ruta: crearURL){
                    if self.peliculas.count <= 0{
                        self.mostrarAlerta(titulo: "Error", mensaje: "No se encontraron coincidencias para : \(nombre)", accion: "cancel")
                    }else{
                        self.tablaPeliculas.reloadData()
                    }
                }
            }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pelicula = peliculas[indexPath.row]
        performSegue(withIdentifier: "segueEditar", sender: pelicula)
    }
    
    func cargarPeliculas(ruta:String, completed: @escaping () -> ()){
        let url = URL(string: ruta)
        URLSession.shared.dataTask(with: url!) { (data, response,
            error) in
            if error == nil{
                do{
                    self.peliculas = try JSONDecoder().decode([Peliculas].self,
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peliculas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(peliculas[indexPath.row].nombre)"
        cell.detailTextLabel?.text = "Genero:\(peliculas[indexPath.row].genero)Duracion:\(peliculas[indexPath.row].duracion)"
        return cell
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tablaPeliculas.delegate = self
        tablaPeliculas.dataSource = self
        for data in self.users{
            print("id:\(data.id),nombre:\(data.nombre),nombre\(data.email)")
        }
        
        let ruta = "http://localhost:3000/peliculas/"
        cargarPeliculas(ruta: ruta){
            self.tablaPeliculas.reloadData()
        }
        // Do any additional setup after loading the view.
    }
    
    func mostrarAlerta(titulo: String, mensaje: String, accion: String){
        let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        let btnOK = UIAlertAction(title: accion, style: .default, handler: nil)
        alerta.addAction(btnOK)
        present(alerta, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let ruta = "http://localhost:3000/peliculas/"
        cargarPeliculas(ruta: ruta){
            self.tablaPeliculas.reloadData()
            
        }
    }
    func metodoDelete(ruta:String){
        let url : URL = URL(string: ruta)!
        var request = URLRequest(url : url)
        let session = URLSession.shared
        request.httpMethod = "DELETE"
       
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let pelicula = peliculas[indexPath.row]
            let ruta = "http://localhost:3000/peliculas/\(pelicula.id)"
            
            metodoDelete(ruta: ruta)
            peliculas.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
   

//
//    func cargarPeliculas(ruta:String, completed: @escaping () -> ()){
//        URLSession.shared.dataTask(with: url!) { (data, response,
//            error) in
//            if error == nil{
//                do{
//                        self.peliculas = try JSONDecoder().decode([Peliculas], from: data!)
//                }catch{
//                    print("Error en el json")
//                }
//            }
//
//            }.resume()
//    }

        // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueEditar"{
            let siguienteVC = segue.destination as! ViewControllerAgregalo
            siguienteVC.pelicula = sender as? Peliculas
        }
        if segue.identifier == "segueEditar_Perfil"{
            let siguienteVC = segue.destination as! Editar_PerfilViewController
            siguienteVC.users = users
        }
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 
 

}
