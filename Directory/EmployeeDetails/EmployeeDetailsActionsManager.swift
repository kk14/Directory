//
//  EmployeeDetailsActionsManager.swift
//  Directory
//
//  Created by Kanishk Kumar on 09/07/2021.
//

import CoreLocation
import MapKit
import MessageUI

extension EmployeeDetailsTableViewController {
    func showActionSheetForNumber(withEmployeeDetail employeeDetail: EmployeeDetail) {
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ -> Void in
            // Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)

        let callAction = UIAlertAction(title: "Call \(employeeDetail.detailLabel)", style: .default) { _ -> Void in
            self.callContact(withNumber: employeeDetail.detailValue)
        }
        actionSheetController.addAction(callAction)

        let messageAction = UIAlertAction(title: "Message \(employeeDetail.detailLabel)", style: .default) { _ -> Void in
            self.sendMessage(toNumber: employeeDetail.detailValue)
        }
        actionSheetController.addAction(messageAction)

        present(actionSheetController, animated: true, completion: nil)
    }

    func callContact(withNumber number: String) {
        let formatedNumber = number.components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "")

        print("Calling \(formatedNumber)")

        let phoneUrl = "tel://\(formatedNumber)"
        if let url = URL(string: phoneUrl) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    func showAppleMaps(withEmployee employee: Employee) {
        let latitude: CLLocationDegrees = employee.latitude
        let longitude: CLLocationDegrees = employee.longitude
        let regionDistance: CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span),
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = employeeDetailsVM.getName()
        mapItem.openInMaps(launchOptions: options)
    }
}

// MARK: - Send Message

extension EmployeeDetailsTableViewController: MFMessageComposeViewControllerDelegate {
    private func sendMessage(toNumber number: String) {
        if MFMessageComposeViewController.canSendText() {
            let formatedNumber = number.components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "")

            print("Messaging \(formatedNumber)")

            let messageVC = MFMessageComposeViewController()
            messageVC.recipients = [formatedNumber]
            messageVC.messageComposeDelegate = self
            present(messageVC, animated: true, completion: nil)
        }
    }

    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result {
        case .cancelled:
            print("Message was cancelled")
        case .failed:
            print("Message failed")
        case .sent:
            print("Message was sent")
        default:
            break
        }

        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Send Email

extension EmployeeDetailsTableViewController: MFMailComposeViewControllerDelegate {
    func sendEmail(toEmailAddress emailAddress: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([emailAddress])

            present(mail, animated: true)
        } else {
            print("Failed to send mail")
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            print("Mail was cancelled")
        case .failed:
            print("Mail failed")
        case .sent:
            print("Mail was sent")
        default:
            break
        }
        controller.dismiss(animated: true)
    }
}
