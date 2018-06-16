//
//  ViewController.swift
//  FlikrAPI
//
//  Created by Jack Wong on 2018/06/16.
//  Copyright © 2018 Jack Wong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    private let apiDao = PhotoSearchDao()
    private let resultProvider = PhotoSearchProvider()
    
    //MARK: - IBOutlet
    @IBOutlet weak var resultTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var noResultView: UIView!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(isHidden: true)
        setup()
    }
}

    //MARK: - Private func
extension ViewController {
    
    private func setupView(isHidden: Bool) {
        noResultView.isHidden = isHidden
        resultTableView.isHidden = isHidden
    }
    
    private func searchPhoto() {
        guard let tags = searchBar.text else { return }
        apiDao.fetchPhoto(tags: tags)
    }
    private func setup() {
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.delegate = self
        apiDao.returnResult = self
        resultTableView.delegate = self
        resultTableView.dataSource = resultProvider
        resultTableView.allowsSelection = false
        registerGestureRecognizer()
    }
    
    private func showAlert(message: String) {
        let alert = AlertHelper.buildAlert(message: message)
        present(alert, animated: true, completion: nil)
    }
    
    private func registerGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc private func endEditing() {
        self.view.endEditing(true)
    }
    
}

    //MARK: - ReturnResultDelegate
extension ViewController: ReturnResult {
    
    func returnResult(returnCode: FetchResult) {
        switch returnCode {
            
        case .success(let photo):
        //TODO: Paging処理 
            if photo.count != 0 {
                resultProvider.getPhotoId(items: photo)
                resultTableView.reloadData()
            } else {
                resultTableView.isHidden = true
                noResultView.isHidden = false
            }
        case .error(let message):
            LogHelper.log(message)
        
        case .offline:
             showAlert(message: "OFFLINE".localized())
        }
    }
}

    //MARK: - UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        if (searchBar.text == "") && (searchBar.text?.isEmpty)! {
            showAlert(message: "EMPTY_TEXT".localized())
        } else {
            print("Search Started")
            noResultView.isHidden = true
            resultTableView.isHidden = false
            searchPhoto()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}

    //MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
