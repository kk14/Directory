//
//  ViewController.swift
//  Directory
//
//  Created by Kanishk Kumar on 05/07/2021.
//

import UIKit

class DirectoryListViewController: UITableViewController {
    
    var employeeSectionTitles = [String]()
    var filteredEmployees = [Employee]()
    var employeesDictionary = [String:[Employee]]()
    private var directoryListViewModel: DirectoryListViewModel!

    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSearchController()
        tableView.sectionIndexColor = .vmRed
        
        self.directoryListViewModel = DirectoryListViewModel()
        bind()
    }
    deinit {
        directoryListViewModel.employeeDictionary.unbind(self)
    }

    private func bind() {
        directoryListViewModel.employeeDictionary.bind(self) { [weak self] employeeDictionary in
            self?.employeesDictionary = employeeDictionary
            self?.employeeSectionTitles = self?.employeesDictionary.keys.sorted(by: { $0 < $1 }) ?? [String]() as [String]
            self?.tableView.reloadData()
            
      }
    }
    //MARK: -  Search Controller Utils
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Directory"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
    }
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    func filterContentForSearchText(_ searchText: String) {
        filteredEmployees = directoryListViewModel.employees?.filter { (employee: Employee) -> Bool in
        
        return employee.firstName.lowercased().contains(searchText.lowercased()) || employee.lastName.lowercased().contains(searchText.lowercased())
        } ?? []
      
      tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if isFiltering {
          return 1
        }
        return employeeSectionTitles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if isFiltering {
          return filteredEmployees.count
        }
        let employeeKey = employeeSectionTitles[section]
        
        if let employeeValues = self.employeesDictionary[employeeKey] {
            return employeeValues.count
        }
        
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DirectoryListCell", for: indexPath)

        let employee: Employee
        if isFiltering {
            employee = filteredEmployees[indexPath.row]
            cell.textLabel?.text = employee.firstName + " " + employee.lastName
        } else {
            let employeeKey = employeeSectionTitles[indexPath.section]
            if let employeeValues = self.employeesDictionary[employeeKey]{
                employee = employeeValues[indexPath.row]
                cell.textLabel?.text = employee.firstName + " " + employee.lastName
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return employeeSectionTitles[section]
    }

    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return employeeSectionTitles
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if  segue.identifier == "showEmployeeDetails",
            let destination = segue.destination as? EmployeeDetailsTableViewController,
            let employeeKeyIndex = tableView.indexPathForSelectedRow?.section,
            let employeeIndex = tableView.indexPathForSelectedRow?.row {
                let employeeKey = employeeSectionTitles[employeeKeyIndex]
            if let employeeValues = self.employeesDictionary[employeeKey] {
                    destination.employeeDetailsVM = EmployeeDetailViewModel(withEmployee: employeeValues[employeeIndex])
                }
            }
    }
}

extension DirectoryListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
      let searchBar = searchController.searchBar
      filterContentForSearchText(searchBar.text!)
    }
  }

extension DirectoryListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!)
    }
  }
