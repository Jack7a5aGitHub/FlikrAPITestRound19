//
//  ViewController.swift
//  FlikrAPI
//
//  Created by Jack Wong on 2018/06/16.
//  Copyright © 2018 Jack Wong. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    //MARK: - Properties
    private let apiDao = PhotoSearchDao()
    private let resultProvider = PhotoSearchProvider()
    private var currentPage = 1
    private var photoList = [PhotoList]()
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
    
    private func searchPhoto(tag: String) {
        apiDao.fetchPhoto(tags: tag, page: currentPage)
    }
    private func setup() {
        title = "PHOTOS".localized()
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.delegate = self
        apiDao.returnResult = self
        setupTableView()
        registerGestureRecognizer()
    }
    private func setupTableView() {
        registerNib()
        resultTableView.delegate = self
        resultTableView.dataSource = resultProvider
        resultTableView.allowsSelection = false
    }
    private func registerNib() {
        let photoNib = UINib(nibName: PhotoCell.nibName, bundle: nil)
        resultTableView.register(photoNib, forCellReuseIdentifier: PhotoCell.identifier)
    }
    private func showAlert(message: String) {
        let alert = AlertHelper.buildAlert(message: message)
        present(alert, animated: true, completion: nil)
    }
    
    private func fetchNextPage() {
        currentPage += 1
        guard let tags = searchBar.text else {
            return
        }
        searchPhoto(tag: tags)
    }
    
    private func registerGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc private func endEditing() {
        self.view.endEditing(true)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if maximumOffset - currentOffset <= 10 {
            self.fetchNextPage()
        }
    }
    
}

//MARK: - ReturnResultDelegate
extension ViewController: ReturnResult {
    
    func returnResult(returnCode: FetchResult) {
        switch returnCode {
            
        case .success(let photo):
            if photo.count != 0 {
                photoList = []
                for item in photo {
                    photoList.append(PhotoList(imageUrl: "https://farm\(item.farm).staticflickr.com/\(item.server)/\(item.id)_\(item.secret).jpg",
                                               title: item.title))
                }
                resultProvider.getPhotoId(items: photoList)
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
            guard let tags = searchBar.text else {
                return
            }
            searchPhoto(tag: tags)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
}

    //MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
