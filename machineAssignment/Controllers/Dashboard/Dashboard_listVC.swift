//
//  Dashboard_listVC.swift
//  machineAssignment
//
//  Created by Sayan Das on 05/03/24.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class Dashboard_listVC: UIViewController {
    
    @IBOutlet weak var tblProductList: UITableView!
    
    
    let apiModel = networkModel()
    let imageLoadQueue = OperationQueue() //background queue
    
    
    
    //MARK: did load method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: tableview delegate and datasource
        self.tblProductList.delegate = self
        self.tblProductList.dataSource = self
        
        //MARK: method for fetching data
        self.getAllProductDetails()
    }
    
    
    //MARK: will appear method
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    
    //MARK: fetch all list details
    @objc func getAllProductDetails(){
        
      //MARK: calling network model to fetch data
        apiModel.fetchData {
            DispatchQueue.main.async {
                    self.tblProductList.reloadData()
                }
        }

    }
}

//AMRK: Tableview delegate & datasource methods
extension Dashboard_listVC: UITableViewDelegate, UITableViewDataSource {

    
    //MARK: number of rows in a tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiModel.productListModel.count
    }
    
    
    //MARK: configure cell of tableview within view
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? productListCell {
            // Load the image for the visible cell
            let imageURL = apiModel.productListModel[indexPath.row].download_url ?? ""

               let operation = BlockOperation {
                   cell.configureCell(with: imageURL)
               }
               imageLoadQueue.addOperation(operation)
        }
    }
    
    
    //MARK: cell datasource method
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "productListCell"
        var cell: productListCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? productListCell
        if cell == nil {
            tableView.register(UINib(nibName: "productListCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? productListCell
        }
  
        
        
        return cell
    }
}
