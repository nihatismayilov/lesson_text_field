//
//  ViewController.swift
//  TextField
//
//  Created by Nihad Ismayilov on 12.08.24.
//

import UIKit

protocol ProtocolA {
    var someVariable: Int { get set }
    func smth()
    func smth2()
    func smth3()
    func smth4()
}

class ProtocolAImpl: ProtocolA {
    var someVariable: Int = 4
    
    func smth() {
        print(#function, "from ProtocolAImpl")
    }
    
    func smth2() {
        print(#function, "from ProtocolAImpl")
    }
    
    func smth3() {
        print(#function, "from ProtocolAImpl")
    }
    
    func smth4() {
        print(#function, "from ProtocolAImpl")
    }
}

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    var randomProtocol: ProtocolA?
    
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.delegate = self
        }
    }
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.delegate = self
        }
    }
    
    @IBOutlet weak var textField2: UITextField! {
        didSet {
            textField2.delegate = self
        }
    }
    
    @IBOutlet weak var customView: InputView! {
        didSet {
            customView.delegate = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randomProtocol = ProtocolAImpl()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField {
        case self.textField:
            randomProtocol?.smth()
            randomProtocol?.someVariable += 5
        case textField2:
            randomProtocol?.smth2()
            randomProtocol?.someVariable -= 4
        default: break
        }
        print("random some variable", randomProtocol?.someVariable)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "a" {
            return false
        } else {
            return true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(#function)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print(#function)
        if textField == textField2 {
            if self.textField.text?.isEmpty == true {
                return false
            }
            return true
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(#function)
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
    }
}

extension ViewController: InputViewDelegate {
    func textViewDidChangeSelection(_ inputView: InputView) {
        print("my custom delegates functions body's code", inputView.textView.text)
    }
}
