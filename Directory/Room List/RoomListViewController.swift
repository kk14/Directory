//
//  RoomListViewController.swift
//  Directory
//
//  Created by Kanishk Kumar on 06/07/2021.
//

import UIKit

class RoomListViewController: UITableViewController {
    private var roomsListViewModal: RoomsListViewModel!
    var roomSectionTitles = [String]()
    var roomsDictionary = [String: [Room]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.sectionIndexColor = .vmRed

        roomsListViewModal = RoomsListViewModel()
        bind()
    }

    deinit {
        roomsListViewModal.roomsDictionary.unbind(self)
    }

    private func bind() {
        roomsListViewModal.roomsDictionary.bind(self) { [weak self] roomsDictionary in
            self?.roomsDictionary = roomsDictionary
            self?.roomSectionTitles = self?.roomsDictionary.keys.sorted(by: { $0 < $1 }) ?? [String]() as [String]
            self?.tableView.reloadData()
        }
    }

    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return roomSectionTitles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let roomKey = roomSectionTitles[section]
        if let roomValues = roomsDictionary[roomKey] {
            return roomValues.count
        }

        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomListCell", for: indexPath)

        // Configure the cell...
        let roomKey = roomSectionTitles[indexPath.section]
        if let roomValues = roomsDictionary[roomKey] {
            cell.textLabel?.text = roomValues[indexPath.row].name
            if #available(iOS 13.0, *) {
                cell.imageView?.image = roomValues[indexPath.row].isOccupied ? UIImage(systemName: "circle.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal) : UIImage(systemName: "circle.fill")?.withTintColor(.green, renderingMode: .alwaysOriginal)
            } else {
                // Fallback on earlier versions
                // FIXME:
            }
            cell.detailTextLabel?.text = "\(roomValues[indexPath.row].maxOccupancy)"
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return roomSectionTitles[section]
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return roomSectionTitles
    }
}
