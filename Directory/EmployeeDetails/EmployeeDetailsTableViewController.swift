//
//  EmployeeDetailsTableViewController.swift
//  Directory
//
//  Created by Kanishk Kumar on 07/07/2021.
//

import UIKit


class EmployeeDetailsTableViewController: UITableViewController {

    var employeeDetailsVM: EmployeeDetailViewModel!
    var employeeAvatarImage = UIImage(named: "person")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(EmployeeDetailNameAndPhotoTableViewCell.self, forCellReuseIdentifier: "EmployeeDetailNameAndPhotoTableViewCell")
        self.tableView.register(EmployeeDetailTableViewCell.self, forCellReuseIdentifier: "EmployeeDetailTableViewCell")
        bind()
    }
    deinit {
        employeeDetailsVM.employeeAvatarImage.unbind(self)
    }

    private func bind() {
        employeeDetailsVM.employeeAvatarImage.bind(self) { [weak self] employeeAvatarImage in
            self?.employeeAvatarImage = employeeAvatarImage
            self?.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: UITableView.RowAnimation.fade)
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeDetailsVM.getEmployeeDetailsCount() + 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let employeeDetailNameAndPhotoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EmployeeDetailNameAndPhotoTableViewCell", for: indexPath) as? EmployeeDetailNameAndPhotoTableViewCell else {
                return UITableViewCell()
            }
            employeeDetailNameAndPhotoTableViewCell.nameLabel.text = employeeDetailsVM.getName()
            employeeDetailNameAndPhotoTableViewCell.jobTitleLabel.text = employeeDetailsVM.getJobTitle()
            employeeDetailNameAndPhotoTableViewCell.contactPhotoImageView.image = employeeAvatarImage

            return employeeDetailNameAndPhotoTableViewCell
        }

        guard let employeeDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EmployeeDetailTableViewCell", for: indexPath) as? EmployeeDetailTableViewCell else {
            return UITableViewCell()
        }

        let employeeDetail = employeeDetailsVM.getEmployeeDetail(forIndexPath: indexPath)
        employeeDetailTableViewCell.detailNameLabel.text = employeeDetail.detailLabel
        employeeDetailTableViewCell.detailValueLabel.text = employeeDetail.detailValue
        return employeeDetailTableViewCell
    }
   


// MARK: - TableView Delegate events

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return (employeeDetailsVM.getJobTitle().isEmpty) ? 170 : 200
        } else {
            return 60
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.row == 0 {
            return
        }

        let employeeDetail = employeeDetailsVM.getEmployeeDetail(forIndexPath: indexPath)

        if employeeDetail.detailType == .phone {
            showActionSheetForNumber(withEmployeeDetail: employeeDetail)
        } else if employeeDetail.detailType == .email {
            sendEmail(toEmailAddress: employeeDetail.detailValue)
        }
        else if employeeDetail.detailType == .location {
            showAppleMaps(withEmployee:employeeDetailsVM.employee)
        }
    }
    
    
}
