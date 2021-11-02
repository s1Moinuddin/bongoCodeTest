//
//  ViewController.swift
//  BongoCodeTest
//
//  Created by S.M.Moinuddin on 10/31/21.
//

import UIKit
import SVProgressHUD

class ViewController: UIViewController {
    
    @IBOutlet weak private var textView: UITextView!
    
    private let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textView.isEditable = false
        textView.layer.borderWidth = 2.0
        textView.layer.borderColor = UIColor.gray.cgColor
        
        
    }
    
    @IBAction private func fetchDataAction(_ sender: UIButton) {
        SVProgressHUD.show()
        viewModel.fetchData { [weak self] (result) in
            DispatchQueue.main.async {
                self?.textView.text = result
                SVProgressHUD.dismiss()
            }
        }
        
    }
    
}



