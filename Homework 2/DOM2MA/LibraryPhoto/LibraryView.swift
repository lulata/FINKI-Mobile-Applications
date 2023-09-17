import UIKit

class LibraryView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    // ...
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var choosePhotoBTN: UIButton!{
        didSet{
            choosePhotoBTN.backgroundColor = .clear
            choosePhotoBTN.layer.cornerRadius = 0
            choosePhotoBTN.layer.borderWidth = 1
            choosePhotoBTN.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpScrollView()
    }
    
    @IBAction func openPhotoLibraryFINKI(_ sender: Any) {
        let imagePicker = UIImagePickerController()
          imagePicker.sourceType = .photoLibrary
          imagePicker.delegate = self
          present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            // Do something with the selected image (e.g., display it in an ImageView)
            imageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func setUpScrollView() {
        ScrollView.delegate = self
    }
    
    
}



extension LibraryView:UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}
