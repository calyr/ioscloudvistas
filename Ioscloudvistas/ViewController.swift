//
//  ViewController.swift
//  Ioscloudvistas
//
//  Created by calyr on 7/16/16.
//  Copyright © 2016 calyr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var fuenteDatos2 = [ISBN]()
    @IBOutlet weak var labelAutores: UILabel!
    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var txtIsbn: UITextField!
    var milibro = ISBN(idIsbn: "-2")
    @IBAction func buscarISBN(sender: UIButton) {
        print("Buscando el valor IN vIEW CONTROLLER")
        print(txtIsbn.text)
        self.milibro = sincrono(txtIsbn.text!)
        print(milibro.mostrar())
        fuenteDatos2.append(self.milibro)
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cvc = segue.destinationViewController as! CVC
        cvc.fuenteDatos = self.fuenteDatos2
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sincrono(isbn:String) -> ISBN{
        let libro = ISBN(idIsbn: isbn)
        
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"+isbn
        let url = NSURL(string: urls)
        let datos:NSData? = NSData(contentsOfURL: url!)
        // let texto = NSString( data: datos!, encoding: NSUTF8StringEncoding)
        do {
            let json  = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
            
            let dataall = json as! NSDictionary
            //print(dataall)
            if dataall.count == 0 {
                let alert = UIAlertController(title: "PARAMETROS DE BUSQUEDA INVALIDO", message: "Verificar el codigo ISBN.", preferredStyle: .Alert)
                let popup = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alert.addAction(popup)
                self.presentViewController(alert, animated: true, completion: nil)
                return libro
            }
            let titulo = dataall["ISBN:"+isbn]!["title"] as! NSString as String
            labelTitulo.text = titulo
            libro.setTitulo(titulo)
            let dataautores = dataall["ISBN:"+isbn]!["authors"] as! NSArray
            let keyExists = dataall["ISBN:"+isbn]!["cover"] != nil
            
            if( keyExists == true ){
                let coverpages = dataall["ISBN:"+isbn]!["cover"] as! NSDictionary
                if( coverpages.count != 0)
                {
                    let imagenurl = coverpages["medium"] as! NSString as String
                    //print(coverpages)
                    //print(dataautores)
                    
                    // titulos.text = titulo
                    
                    //let urlimage = NSURL(string: "https://covers.openlibrary.org/b/id/6890250-S.jpg")
                    let urlimage = NSURL(string: imagenurl)
                    let dataimage = NSData(contentsOfURL: urlimage!) //make sure your image in this url does exist, otherwise unwrap in a if let check
                    imgCover.image = UIImage(data: dataimage!)
                    libro.setImagenes(imgCover)
                    // libro.setImagenes(imgCover)
                    
                    
                }
                
            }
            var stringautores = ""
            for data in dataautores {
                let dataautor = data as! NSDictionary
                let dataautorname =  dataautor["name"] as! NSString as String
                //print(dataautor)
                libro.addAutor(dataautorname)
                stringautores += dataautorname + "\n"
                
            }
            labelAutores.text = stringautores;
            
        }catch _ {
            
            let alert = UIAlertController(title: "NO INTERNET ?", message: "Check Internet connection / Flight mode please.", preferredStyle: .Alert)
            let popup = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(popup)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        return libro
    }


}

