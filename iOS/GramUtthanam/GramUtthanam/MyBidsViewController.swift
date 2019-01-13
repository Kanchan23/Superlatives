//
//  MyBidsViewController.swift
//  GramUtthanam
//
//  Created by Prateek Sharma on 1/12/19.
//  Copyright © 2019 Prateek Sharma. All rights reserved.
//

import UIKit
import SVProgressHUD

class MyBidsViewController: UIViewController {

    @IBOutlet weak private var tableView: UITableView!

    private var cropBids = [ItemBid]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchCropBids()
    }
    
    private func fetchCropBids() {
        SVProgressHUD.show()
        BidManager.requestBids { [weak self] (mybids, error) in
            SVProgressHUD.dismiss()
            guard let mybids = mybids  else { self?.showAlert(title: "Unable to fetch bids", message: error); return; }
            self?.cropBids = mybids
            self?.tableView.reloadData()
        }
    }
    @IBAction func logoutAction(_ sender: Any) {
        UserCache.userToken.value = nil
        present(MainStoryboard.login.scene, animated: true, completion: nil)
    }
    
}

extension MyBidsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cropBids.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableTableViewCell
        cell.setup(data: cropBids[indexPath.row])
        return cell
    }
    
}

extension MyBidsViewController {
    
    @IBAction func createNewBid() {
        perform(segue: .createBid)
    }
    
}
