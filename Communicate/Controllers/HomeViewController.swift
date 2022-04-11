//
//  ViewController.swift
//  Communicate
//
//  Created by Melvyn Awani on 06/04/2022.
//

import UIKit
import CLTypingLabel

class HomeViewController: UIViewController {

    @IBOutlet weak var appNameLbl: CLTypingLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        appNameLbl.text = K.appName
    }


}

