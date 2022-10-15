//
//  CameraViewController.swift
//  Instagram
//
//  Created by Jay on 2022/10/15.
//

import UIKit
import AlamofireImage
import Parse
class CameraViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postTextField: UITextField!
    @IBAction func onsubmitButton(_ sender: Any) {
        let post  = PFObject(className: "posts")
        post["caption"] = postTextField.text!
        post["author"] = PFUser.current()!
        let imageData = postImage.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        post["image"] = file
        post.saveInBackground{
            (success,error) in
            if success {
                self.dismiss(animated: true)
            }
            else{
                print(error?.localizedDescription)
            }
        }
        
    }
    @IBAction func onImageButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }else{
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true,completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size  = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        imageView.image = nil
        postImage.image = image
        dismiss(animated: true)
    }



}
