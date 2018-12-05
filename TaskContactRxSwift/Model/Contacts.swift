//
//  Contacts.swift
//  TaskContactRxSwift
//
//  Created by Srivikashini Venkatachalam on 04/12/18.
//  Copyright © 2018 Srivikashini Venkatachalam. All rights reserved.
//

import UIKit

class Contacts: NSObject {
    
    struct Contact : Codable{
        var id : Int?
        var name : String?
        var mail : String?
        var designation : String?
        var CompanyId : Int?
        
        enum ContactKeys: String, CodingKey
        {
            case id
            case name
            case email
            case job_title
            case company_id
            
        }
        init (from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: ContactKeys.self)
            id = try values.decode (Int.self, forKey: .id)
            name = try values.decode (String.self, forKey: .name)
            mail = try values.decodeIfPresent(String.self, forKey: .email) ?? "not available"
            designation = try values.decodeIfPresent(String.self, forKey: .job_title) ?? "not available"
            CompanyId = try values.decodeIfPresent(Int.self, forKey: .company_id)
        }
        
        init() {
            
        }
    }
    
    
    
    struct company : Codable{
        
        var CompanyName : String?
        enum CompanyKeys: String, CodingKey
        {
            case name
        }
        
        init (from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CompanyKeys.self)
            CompanyName = try values.decodeIfPresent(String.self, forKey: .name)
        }
    }
}







