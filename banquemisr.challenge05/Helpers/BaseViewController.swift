//
//  BaseViewController.swift
//  banquemisr.challenge05
//
//  Created by Mohammed Balegh on 16/03/2024.
//

import UIKit

class BaseViewController: UIViewController {
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let loadingBackgroundView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupActivityIndicator()
    }
    
    private func setupActivityIndicator() {
        loadingBackgroundView.layer.cornerRadius = 5
        loadingBackgroundView.clipsToBounds = true
        loadingBackgroundView.isOpaque = false
        loadingBackgroundView.backgroundColor = .white
        
        activityIndicator.style = .medium
        activityIndicator.color = .black
        
        loadingBackgroundView.frame = CGRectMake(0, 0, 48, 48)
        loadingBackgroundView.center = view.center
        activityIndicator.center = view.center
        activityIndicator.frame =  CGRectMake(0, 0, 48, 48)
        
        view.addSubview(loadingBackgroundView)
        loadingBackgroundView.addSubview(activityIndicator)
    }
    
    private func showLoadingIndicator() {
        loadingBackgroundView.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func hideLoadingIndicator() {
        activityIndicator.stopAnimating()
        loadingBackgroundView.isHidden = true
    }
    
    func startLoadingIndicator(isLoading: Bool) {
        isLoading ? showLoadingIndicator() : hideLoadingIndicator()
    }
    
    func showError(_ error: NetworkError) {
        let alertController = UIAlertController(title: "Error", message: error.specificError?.errorDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
