//
//  ProfileViewController.swift
//  Instagram
//
//  Created by 01659826174 01659826174 on 4/1/22.
//

import UIKit
import Parse
import AlamofireImage
class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUsernameAndProfilePicture()
    }
    
    
    private func  setUsernameAndProfilePicture() {
        let user = PFUser.current()!
        nameLabel.text = user.username
        if user["profileImage"] != nil {
            let imageFile = user["profileImage"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)
            let placeholder = UIImage(named: "image_placeholder")
            let filter = AspectScaledToFillSizeFilter(size: profileImageView.frame.size)
            profileImageView.af.setImage(withURL: url!, placeholderImage: placeholder, filter: filter)
            
        }
        
    }

    @IBAction func onCameraTap(_ sender: Any) {
        print("launch camera!")
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        
        profileImageView.image = scaledImage
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func onUploadButton(_ sender: Any) {
        print("upload")
        let user = PFUser.current()!
        let imageData = profileImageView.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        user["profileImage"] = file
        
        user.saveInBackground { isSuccess, error in
            if let error = error {
                print("Error")
            } else {
                print("Saved")
                self.performSegue(withIdentifier: "feedSeque", sender: nil)
            }
        }
    }

}
