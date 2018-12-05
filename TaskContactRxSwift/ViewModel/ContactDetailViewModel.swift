//
//  ContactDetailViewModel.swift
//  TaskContactRxSwift
//
//  Created by Srivikashini Venkatachalam on 04/12/18.
//  Copyright © 2018 Srivikashini Venkatachalam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ContactDetailViewModel: NSObject {
    
    var detailList: Variable<[SectionModel<String,DetailModel>]> = Variable([])
    var detail : Contacts.Contact
    let companyApi = "https://mobilebootcamp.freshdesk.com/api/v2/companies/"
    
    
    init(contactDetail: Contacts.Contact) {
        detail = contactDetail
    }
    
    override init() {
        detail = Contacts.Contact()
    }
    
    func setArrayValues()  {
        
        var tableViewLabelList = ["name","email","designation"]
        let valueList : [String] = [self.detail.name!,self.detail.mail!,self.detail.designation!]
        for index: Int in 0 ..< tableViewLabelList.count {
            let details = DetailModel(title: tableViewLabelList[index], displayValue: valueList[index])
            let sectionModel = SectionModel.init(model: "", items: [details])
            self.detailList.value.append(contentsOf: [sectionModel])
        }
        
    }
    
    func fetchContactDetailData(companyId : Int) {
        if let url = URL(string: "https://mobilebootcamp.freshdesk.com/api/v2/companies/+\(companyId)") {
            var request = URLRequest(url: url)
            request.addValue("API_KEY", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.httpMethod = "GET"
            
            let dataTask = URLSession.shared.dataTask(with: request) {(data: Data?, response: URLResponse?, error: Error?) in
                guard error == nil else {
                    return
                }
                guard let data = data else {
                    return
                }
                
                let jsonDecoder = JSONDecoder()
                
                do {
                    let userCompany = try jsonDecoder.decode(Contacts.company.self, from: data)
                    let details = DetailModel(title: "company", displayValue: userCompany.CompanyName ?? "not available")
                    let sectionModel = SectionModel.init(model: "", items: [details])
                    self.detailList.value.append(contentsOf:[sectionModel])
                    
                } catch let catchError {
                    print("error : \(catchError)")
                }
            }
            dataTask.resume()
        }
    }
}
