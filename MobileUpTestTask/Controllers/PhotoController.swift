//
//  PhotoController.swift
//  MobileUpTestTask
//
//  Created by Алексей Ревякин on 22.04.2023.
//

import UIKit

class PhotoController: UIViewController {
    //MARK: - Variables
    private var photoScrollView: UIScrollView = {
       let scroll = UIScrollView()
        
        return scroll
    }()
    private var photoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: - Configure UI
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        layout()
    }
    
    private func configure() {
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shared))
        
        view.addSubview(photoScrollView)
        photoScrollView.addSubview(photoImageView)
        photoScrollView.contentSize = CGSize(width: view.bounds.width, height: 375)
    }
    
    private func layout() {
        photoScrollView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(view.bounds.width)
            make.height.equalTo(375)
        }
        photoImageView.snp.makeConstraints { make in
            make.width.equalTo(view.bounds.width)
            make.height.equalTo(375)
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
        
    }
    func initialize(photo: Photo) {
        if let data = photo.data {
            photoImageView.image = UIImage(data: data)
        }
        title = photo.date
    }
}

//MARK: - Action
extension PhotoController {
    @objc func shared() {
        
    }
}
