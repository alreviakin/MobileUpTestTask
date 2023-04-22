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
        scroll.minimumZoomScale = 1.0
        scroll.maximumZoomScale = 3.5
        return scroll
    }()
    private var photoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 54, height: 54)
        layout.minimumLineSpacing = 2
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collection
    }()
    
    //MARK: - Configure UI
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        layout()
    }
    
    override func viewWillLayoutSubviews() {
        photoImageView.snp.makeConstraints { make in
            make.width.equalTo(view.bounds.width)
            make.height.equalTo(photoScrollView.snp.height)
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
    }
    
    private func configure() {
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shared))
        
        view.addSubview(photoScrollView)
        photoScrollView.addSubview(photoImageView)
        photoScrollView.contentSize = CGSize(width: view.bounds.width, height: 375)
        photoScrollView.delegate = self
    }
    
    private func layout() {
        photoScrollView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(view.bounds.width)

            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview().offset(-100)
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

//MARK: - Zoom
extension PhotoController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }
}
