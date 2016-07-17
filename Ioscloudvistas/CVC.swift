//
//  CVC.swift
//  Ioscloudvistas
//
//  Created by calyr on 7/16/16.
//  Copyright © 2016 calyr. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ISBN{
    var idIsbn: String
    var titulo : String
    var imagenes : UIImageView!
    var autores : [String]
    
    init(idIsbn: String){
        self.idIsbn = idIsbn
        self.titulo = "sin titulo"
        self.autores = []
    }
    
    func setTitulo(titulo:String){
        self.titulo = titulo
    }
    
    func getTitulo() -> String{
        return self.titulo
    }
    
    func setImagenes(imagenes: UIImageView){
        self.imagenes = imagenes
    }
    
    func getImagenes() -> UIImageView{
        return self.imagenes
    }
    
    func setAutores(autores: [String]){
        self.autores = autores
    }
    func getAutores() -> [String]{
        return self.autores
    }
    func getAutoresAll() -> String{
        var stringautores = ""
        for data in getAutores() {
            stringautores += data + "\n"
            
        }
        return stringautores
    }
    
    func addAutor(autor : String){
        self.autores.append(autor)
    }
    
    func mostrar() -> String{
 
        return "ISBN = \(idIsbn), TITULO = \(titulo), AUTORES \(getAutoresAll())"
    }
    
}
class CVC: UICollectionViewController {
    
    var fuenteDatos = [ISBN]()
    var libronuevo = ISBN(idIsbn: "-1")
    
    
    @IBAction func actualizar(sender: UIBarButtonItem) {
        print("Mostrando libro nuevo \(libronuevo.mostrar())")
        fuenteDatos.append(libronuevo)
        self.collectionView!.reloadData()

    }

    @IBAction func buscarIsnb(sender: UITextField) {
        //print(sender.text)
//        print("buscando algo")
  //      print(sincrono(sender.text!))
        
        print("La fuente de datos \(fuenteDatos) ")
        self.collectionView!.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cvc = segue.destinationViewController as! ViewController
        cvc.fuenteDatos2 = fuenteDatos
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.libronuevo.mostrar())
        self.collectionView!.reloadData()


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return fuenteDatos.count
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! LibroCelda
        
        cell.tituloLibro?.text = fuenteDatos[indexPath.section].getTitulo()
        cell.autoresLibro?.text = fuenteDatos[indexPath.section].getAutoresAll()
        cell.imgLibro?.image = fuenteDatos[indexPath.section].getImagenes().image
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
