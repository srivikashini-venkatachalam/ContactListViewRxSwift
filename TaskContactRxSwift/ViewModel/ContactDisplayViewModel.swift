//
//  ContactDisplayViewModel.swift
//  TaskContactRxSwift
//
//  Created by Srivikashini Venkatachalam on 04/12/18.
//  Copyright © 2018 Srivikashini Venkatachalam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ContactDisplayViewModel: NSObject {

     var contactList: Variable<[SectionModel<String,Contacts.Contact>]> = Variable([])
    
    func fetchData() {
        if let url = URL(string: "https://mobilebootcamp.freshdesk.com/api/v2/contacts") {
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
                let userContact = try! jsonDecoder.decode([Contacts.Contact].self, from: data)
                let sectionModel = SectionModel.init(model: "", items: userContact)
                self.contactList.value = [sectionModel]
            }
            dataTask.resume()
        }
    }
}
