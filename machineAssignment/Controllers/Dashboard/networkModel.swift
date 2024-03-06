//
//  networkModel.swift
//  machineAssignment
//
//  Created by Sayan Das on 06/03/24.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class networkModel {
    var productListModel: [listModel] = []

    func fetchData(completion: @escaping () -> Void) {
        AF.request("https://picsum.photos/v2/list?page=2&limit=20").responseDecodable(of: [listModel].self) { response in
            switch response.result {
            case .success(let decodedData):
                self.productListModel = decodedData
                completion()
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }
}
