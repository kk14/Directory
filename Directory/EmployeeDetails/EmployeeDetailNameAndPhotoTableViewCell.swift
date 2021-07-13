//
//  EmployeeDetailNameAndPhotoTableViewCell.swift
//  Directory
//
//  Created by Kanishk Kumar on 07/07/2021.
//

import UIKit

class EmployeeDetailNameAndPhotoTableViewCell: UITableViewCell {
    let contactPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = #colorLiteral(red: 0.8980000019, green: 0.8980000019, blue: 0.9179999828, alpha: 1)
        return imageView
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        return label
    }()

    let jobTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubviews()
        addConstraintToViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubviews() {
        addSubview(contactPhotoImageView)
        addSubview(nameLabel)
        addSubview(jobTitleLabel)
    }

    func addConstraintToViews() {
        contactPhotoImageView.setAnchorsWithConstants(topAnchor: topAnchor, paddingTop: 20, width: 100, height: 100)
        contactPhotoImageView.setAnchorsWithoutConstants(centerXAnchor: centerXAnchor)

        nameLabel.setAnchorsWithConstants(topAnchor: contactPhotoImageView.bottomAnchor, paddingTop: 10, leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor, height: 30)

        jobTitleLabel.setAnchorsWithConstants(topAnchor: nameLabel.bottomAnchor, paddingTop: 4, leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor, height: 20)
    }
}
