//
//  InputView.swift
//  TextField
//
//  Created by Nihad Ismayilov on 12.08.24.
//

import UIKit

protocol InputViewDelegate: NSObject {
    func textViewDidChangeSelection(_ inputView: InputView)
}

@IBDesignable
class InputView: UIView {
    weak var delegate: InputViewDelegate?
    
    var count: Int = 0 {
        didSet {
            if count == 250 {
                counterLabel.textColor = .red
            } else {
                counterLabel.textColor = .lightGray
            }
        }
    }
    @IBOutlet weak var backView: UIView! {
        didSet {
            backView.layer.cornerRadius = 16
            backView.layer.borderWidth = 1
            backView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.delegate = self
        }
    }
    @IBOutlet weak var counterLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        guard let view = Bundle.main.loadNibNamed("InputView", owner: self)?.first as? UIView else {return}
        addSubview(view)
        view.frame = bounds
        backgroundColor = .clear
        addShadow()
    }
    
    private func addShadow() {
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOffset = CGSize(width: 5, height: 5)
        backView.layer.shadowOpacity = 1.0
        backView.layer.shadowRadius = 5
    }
}

extension InputView: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        count = textView.text.count
        if textView.text.isEmpty {
            placeholderLabel.isHidden = false
        } else {
            placeholderLabel.isHidden = true
        }
        counterLabel.text = "\(count) / 250"
        delegate?.textViewDidChangeSelection(self)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.text.count == 250, !text.isEmpty {
            return false
        }
        return true
    }
}
