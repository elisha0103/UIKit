//
//  SignUpView.swift
//  SignUp
//
//  Created by 진태영 on 2023/03/22.
//

import UIKit

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet var id: UITextField!
    @IBOutlet var pw: UITextField!
    @IBOutlet var secondPw: UITextField!
    @IBOutlet var phonNumber: UITextField!
    @IBOutlet var birthDayDatePicker: UIDatePicker!
    @IBOutlet var introduceMemo: UITextView!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var birthDayLabel: UILabel!
    @IBOutlet var profileImage: UIImageView! {
        didSet {
            profileImage.isUserInteractionEnabled = true
            profileImage.image = UIImage(named: "landscape")
        }
    }
    
    
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    lazy var imagePicker: UIImagePickerController = {
        let picker : UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        return picker
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.signUpButton.isEnabled = false
        self.id.addTarget(self, action: #selector(self.textFieldChanged(_:)), for: .editingChanged)
        self.pw.addTarget(self, action: #selector(self.textFieldChanged(_:)), for: .editingChanged)
        self.secondPw.addTarget(self, action: #selector(self.textFieldChanged(_:)), for: .editingChanged)
        self.phonNumber.addTarget(self, action: #selector(self.textFieldChanged(_:)), for: .editingChanged)
        self.birthDayDatePicker.addTarget(self, action: #selector(self.textFieldChanged(_:)), for: .editingChanged)
    }

        
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage: UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.profileImage.image = originalImage
        }
        
        self.dismiss(animated: true)
    }
    
    
    
    
    @IBAction func tapImageView(_ sender: UITapGestureRecognizer) {
        print("tapImage")
        self.present(self.imagePicker, animated: true)

    }
    
    @IBAction func clickSignUpButton(_ sender: UIButton) {
        print("click sign UP button")
        User.shared.id = self.id.text
        User.shared.pw = self.pw.text
        User.shared.birthDay = self.birthDayLabel.text
        User.shared.phoneNumber = self.phonNumber.text
        User.shared.introduceMemo = self.introduceMemo.text
        print(User.shared.id)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func clickBackButton(_ sender: UIButton)  {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickCancelButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func didDatePickerValueChanged(_ sender: UIDatePicker) {
        let date: Date = sender.date
        let dateString: String = self.dateFormatter.string(from: date)
        
        self.birthDayLabel.text = dateString
    }
    
    func isSameBothPw(_ pw: UITextField, _ secondPw: UITextField) -> Bool {
        if (pw.text == secondPw.text) {
            return true
        } else {
            return false
        }
    }
    
    // 텍스트 필드 입력 값 변하면 유효성 검사
    @objc func textFieldChanged(_ sender: Any) {
        print("텍스트 변경 감지")
        
        if !(self.id.text?.isEmpty ?? true) && !(self.pw.text?.isEmpty ?? true) && isSameBothPw(self.pw, self.secondPw) && !(self.birthDayLabel.text?.isEmpty ?? true) && !(self.phonNumber.text?.isEmpty ?? true) {
            self.signUpButton.isEnabled = true
        } else {
            self.signUpButton.isEnabled = false
        }
    }
    
}
