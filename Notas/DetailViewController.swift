//
//  DetailViewController.swift
//  Notas
//
//  Created by jose luis sanchez-porro godoy on 16/01/2017.
//  Copyright © 2017 jose luis sanchez-porro godoy. All rights reserved.
//

import UIKit
import CoreData
class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var noteText: UITextField!
    var note: Note!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //Con esto ocultamos el teclado al pulsar por la vista
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.dismissKeyboard))
        self.view!.addGestureRecognizer(tap)
         if self.note != nil {
            
            imageView.image = UIImage(data: note.image! as Data)
            noteText?.text = note.text
        
        
            }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addPhoto(_ sender: Any) {
        let alertController = UIAlertController(title: "Alerta", message: "Seleccione una opción", preferredStyle: .alert)
        
        let cameraRoll = UIAlertAction(title: "Carrete", style: .default) { (action) in
            let picker: UIImagePickerController = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = .photoLibrary
            self.present(picker, animated: true, completion: { _ in })
        }
        
        let camera = UIAlertAction(title: "Cámara", style: .default) { (action) in
            
            let picker: UIImagePickerController = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = .camera
            self.present(picker, animated: true, completion: { _ in })
            NSLog("OK action")
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) { (action) in
            NSLog("Cancel action")
        }
        
        alertController.addAction(cameraRoll)
        alertController.addAction(camera)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: { _ in })

    }
    @IBAction func save(_ sender: Any) {
        if(self.note != nil){
            if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer{
                let context = container.viewContext
                self.note?.date = Date() as NSDate?
                self.note?.text = self.noteText.text
                self.note?.image = UIImageJPEGRepresentation(self.imageView.image!, 1) as NSData?
                do{
                    try context.save()
                }catch{
                    print("Ha habido un error")
                }
            }
        }else{
                if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer{
                    let context = container.viewContext
                    let newNote: Note
                    newNote = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as! Note
                    newNote.date = Date() as NSDate?
                    newNote.text = self.noteText.text
                    newNote.image = UIImageJPEGRepresentation(self.imageView.image!, 1) as NSData?
                    do{
                        try context.save()
                    }catch{
                        print("Ha habido un error")
                    }
            }
        }
        let alertController = UIAlertController(title: "Alerta", message: "La nota se ha guardado correctamente", preferredStyle: .alert)
        
        let OkAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            NSLog("Ok action")
        }
        
        alertController.addAction(OkAction)
        self.present(alertController, animated: true, completion: { _ in })
        
    }
    func dismissKeyboard() {
        //Oculta el teclado
        self.view!.endEditing(true)
    }
}
extension DetailViewController:UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageView.image = pickedImage
            picker.dismiss(animated: true, completion: { _ in })
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    
}
extension DetailViewController: UINavigationControllerDelegate{
    
}



