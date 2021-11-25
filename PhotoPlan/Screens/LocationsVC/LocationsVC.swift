//
//  ViewController.swift
//  PhotoPlan
//
//  Created by Andrey on 25.11.21.
//

import UIKit


final class LocationsVC: UIViewController {
  
  @IBOutlet private weak var tableView: UITableView!
  
  private var headerView = HeaderView()
 
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
  }

  private func setupTableView(){
    tableView.register(UINib(nibName: LocationsTableViewCell.cellName, bundle: nil), forCellReuseIdentifier: LocationsTableViewCell.cellName)
    tableView.dataSource = self
    tableView.delegate = self
    tableView.backgroundColor = UIColor.init(rgb: 0xFAFAFA)
    
    //setup HeaderView
    headerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 150)
    tableView.tableHeaderView = headerView
  }

}

extension LocationsVC: UITableViewDelegate, UITableViewDataSource {
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationsTableViewCell.cellName) as? LocationsTableViewCell else {return UITableViewCell()}
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UIScreen.main.bounds.height / 2.8
  }

  
}

