//
//  listDetailVC.swift
//  machineAssignment
//
//  Created by Sayan Das on 06/03/24.
//

import Foundation
import UIKit

class listDetailVC: UIViewController {
    
    @IBOutlet weak var btnCrossDetails: UIButton!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblListTitle: UILabel!
    @IBOutlet weak var lblListDescription: UILabel!
    
    var listTitle = ""
    var listDescription = ""
    var listImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.lblListTitle.text =  listTitle
//        self.lblListDescription.text = listDescription
//        self.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
}
