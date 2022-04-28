//
//  DetailedViewController.swift
//  realmbook
//
//  Created by Aidos on 08.04.2022.
//

import UIKit

class DetailedViewController: UIViewController {

 
    @IBOutlet weak var pic: UIImageView!
    
    @IBOutlet weak var number: UILabel!
    
    var person: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if person?.gender == "female" { pic.image = UIImage(named: "female") }
        else if person?.gender == "male" { pic.image = UIImage(named: "male") }
        number.text = person?.number

    }

}
