//
//  ViewController.swift
//  TaskContactRxSwift
//
//  Created by Srivikashini Venkatachalam on 04/12/18.
//  Copyright © 2018 Srivikashini Venkatachalam. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class ViewController: UIViewController {
    
    let viewModel = ContactDisplayViewModel()
    var contactList: Variable<[Contacts.Contact]> = Variable([])
    let disposeBag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Contacts.Contact>>(
            configureCell: { (_, tableView, indexPath, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ContactTableViewCell
                cell.displayData.text = element.name
                return cell
        })
        
        viewModel.contactList.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        self.setInitialUISetUp()
        
        tableView.rx.modelSelected(Contacts.Contact.self).subscribe(onNext:{
            contactList in
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "contactDetail") as! ContactDetailViewController
            let contactViewModel = ContactDetailViewModel.init(contactDetail: contactList)
            newViewController.viewModel = contactViewModel
            newViewController.getImage = UIImage(named: ("profile.png"))!
            self.navigationController?.pushViewController(newViewController, animated: true)
            print(contactList.name!)
        })
    }
    
    fileprivate func setInitialUISetUp() {
        initNavBar()
        getContactList()
        initTableView()
        
    }
    
    func initNavBar(){
        self.title = "contacts"
    }
    
    func initTableView(){
        tableView.tableFooterView = UIView()
    }
    
    func getContactList(){
        viewModel.fetchData()
    }
    
    
}



