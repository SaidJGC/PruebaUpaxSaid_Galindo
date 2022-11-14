//
//  ImageFSViewController.swift
//  ChartsTutorial
//
//  Created by user229147 on 11/13/22.
//  Copyright © 2022 iOSTemplates. All rights reserved.
//

import UIKit

class ImageFSViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    
    let imagePicker = UIImagePickerController()
    
    
    @IBOutlet weak var textUsuario: UITextField!
    
    
    @IBOutlet weak var imagenUsuario: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textUsuario.delegate = self
        imagePicker.delegate = self

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func showInfo(_ sender: UIButton) {
        infotext()
    }
    
    
    @IBAction func addImage(_ sender: UIButton) {
      
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
                        
                        imagePicker.delegate = self
                        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                        imagePicker.allowsEditing = true
                        
                        self.present(imagePicker, animated: true, completion: nil)
                        
                    } else {
                        print("No se pudo acceder a la libreria de fotos")
                    }    }
    
    
    
    @IBAction func saveFS(_ sender: UIButton) {
        
        let user = textUsuario.text!
        let data = imagenUsuario.image?.pngData()
        if user != "" {
            if data != nil { // convert your UIImage into Data object using png representation
                FirebaseStorageManager().uploadImageData(data: data!, serverFileName: "uploads/\(user)") { (isSuccess, url) in
                         print("uploadImageData: \(isSuccess), \(url)")
                   }
            }else{
                alerterror()
            }
        }else{
            alerterror()
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
                    imagenUsuario.image = image //Obtiene la informacion de la foto y la almacena
                }
                imagePicker.dismiss(animated: true, completion: nil) //Cerrar la camara
                
                
            }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == textUsuario {
                    let allowedCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
                    let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
                    let typedCharacterSet = CharacterSet(charactersIn: string)
                    let alphabet = allowedCharacterSet.isSuperset(of: typedCharacterSet)
                    return alphabet


          } else {
            return false
        }
      }
    
    func infotext(){
        
        let dialogMessage = UIAlertController(title: "SOLO SE PERMITEN CARACTERES ALFABETICOS", message: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz", preferredStyle: .alert)
                            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                            })
                            dialogMessage.addAction(ok)
                            self.present(dialogMessage, animated: true, completion: nil)
    }
    
    func alerterror(){
        
        let dialogMessage = UIAlertController(title: "Campo vacios", message: "Porfavor ingrese la informacion requerida", preferredStyle: .alert)
                            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                            })
                            dialogMessage.addAction(ok)
                            self.present(dialogMessage, animated: true, completion: nil)
    }
}
