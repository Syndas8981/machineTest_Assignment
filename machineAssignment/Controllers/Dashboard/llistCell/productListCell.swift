//
//  productListCell.swift
//  machineAssignment
//
//  Created by Sayan Das on 05/03/24.
//

import UIKit

class productListCell: UITableViewCell {

    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    //MARK: configure cell to fetch image from URL
    func configureCell(with imageURL: String) {
        let url = URL(string: imageURL)
        imgProduct.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
