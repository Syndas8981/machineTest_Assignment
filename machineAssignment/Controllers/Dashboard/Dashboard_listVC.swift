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
    let refreshControl = UIRefreshControl() // refresh control
    var popover: UIPopoverPresentationController!
    var descARR = [String]()
    
   
    //MARK: did load method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: tableview delegate and datasource
        self.tblProductList.delegate = self
        self.tblProductList.dataSource = self
        
        //MARK: pull to refresh
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tblProductList.refreshControl = refreshControl
        
        descARR = generateLoremIpsum(from: 20)
        
        //MARK: method for fetching data
        self.getAllProductDetails()
    }
    
    
    //MARK: will appear method
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    
    //MARK: refresh page
    @objc func refresh(_ sender: AnyObject) {
        self.getAllProductDetails()
    }
    
    
    //MARK: fetch all list details
    @objc func getAllProductDetails(){
        
      //MARK: calling network model to fetch data
        apiModel.fetchData {
            DispatchQueue.main.async {
                    self.tblProductList.refreshControl?.endRefreshing()
                    self.tblProductList.reloadData()
                }
        }

    }
}

//AMRK: Tableview delegate & datasource methods
extension Dashboard_listVC: UITableViewDelegate, UITableViewDataSource {

    //MARK: tabeview datasource methods
    //MARK: number of rows in a tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiModel.productListModel.count
    }
    
    //MARK: cell for row method
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "productListCell"
        var cell: productListCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? productListCell
        if cell == nil {
            tableView.register(UINib(nibName: "productListCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? productListCell
        }
        
        let val = apiModel.productListModel[indexPath.row]
        
        cell.lblTitle.text = apiModel.productListModel[indexPath.row].author
        cell.lblDescription.text = self.descARR[indexPath.row]
        cell.tag = val.id?.toInt() ?? 0
        cell.selectionStyle = .none
  
        return cell
    }
    
    
    //MARK: tabeview delegate methods
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = tableView.indexPathForSelectedRow
        let cell = tblProductList.cellForRow(at: row!) as! productListCell
        
        
        // Create and present the popover
               let popoverContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "listDetailVC") as! listDetailVC
               popoverContentViewController.modalPresentationStyle = .popover

        popoverContentViewController.listTitle = cell.lblTitle.text ?? ""
        popoverContentViewController.listDescription = cell.lblDescription.text ?? ""
        popoverContentViewController.listImage = cell.imgProduct.image ?? UIImage()
        popoverContentViewController.listID = cell.tag
        
               if let popoverPresentationController = popoverContentViewController.popoverPresentationController {
                   popoverPresentationController.sourceView = tableView
                   popoverPresentationController.delegate = self
                   popoverPresentationController.sourceRect = cell.frame
                   popoverPresentationController.permittedArrowDirections = [.up, .down]
                   present(popoverContentViewController, animated: true, completion: nil)
               }

               // Deselect the row if needed
               tableView.deselectRow(at: indexPath, animated: true)
    }
   
    
}

extension Dashboard_listVC: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .popover
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
