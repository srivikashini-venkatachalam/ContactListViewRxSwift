//
//  ContactDetailViewController.swift
//  TaskContactRxSwift
//
//  Created by Srivikashini Venkatachalam on 04/12/18.
//  Copyright © 2018 Srivikashini Venkatachalam. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources


struct DetailModel {
    let label: String
    let value: String
    init(title: String, displayValue: String) {
        self.label = title
        self.value = displayValue
    }
}

class ContactDetailViewController: UIViewController {

    @IBOutlet weak var sectableView: UITableView!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactProfile: UIImageView!
    var getImage = UIImage()
    var viewModel : ContactDetailViewModel!
    let disposeBag = DisposeBag()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialUISetUp()
        
       
        if let companyId = viewModel.detail.CompanyId{
            getCompanyData(companyId: companyId )
            
        }
        else{
            let details = DetailModel(title: "company", displayValue: "not available")
            let sectionModel = SectionModel.init(model: "", items: [details])
            viewModel.detailList.value.append(contentsOf:[sectionModel])
        }
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, DetailModel>>(
            configureCell: { (_, tableView, indexPath, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "secondcell") as! ContactDetailViewCell
                cell.contactTitle.text = element.label
                cell.contactData.text = element.value
                return cell
        })
        
        viewModel.detailList.asObservable()
            .bind(to: sectableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

    }

    fileprivate func setInitialUISetUp() {
        
        viewModel.setArrayValues()
        sectableView.tableFooterView=UIView()
        contactName.text=viewModel.detail.name
        contactProfile.image=getImage
    }

    func getCompanyData(companyId : Int){
        
        viewModel.fetchContactDetailData(companyId: companyId)
    }
}
