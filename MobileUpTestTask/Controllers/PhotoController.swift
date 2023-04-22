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
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(PhotosCell.self, forCellWithReuseIdentifier: "photoCell")
        return collection
    }()
    private var photos = [Photo]()
    
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
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        view.addSubview(photoScrollView)
        photoScrollView.addSubview(photoImageView)
        photoScrollView.contentSize = CGSize(width: view.bounds.width, height: 375)
        photoScrollView.delegate = self
        view.addSubview(collection)
    }
    
    private func layout() {
        photoScrollView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(view.bounds.width)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview().offset(-100)
        }
        collection.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-34)
            make.left.right.equalToSuperview()
            make.height.equalTo(54)
        }
    }
    func initialize(photos: [Photo], index: Int) {
        let photo = photos[index]
        if let data = photo.data {
            photoImageView.image = UIImage(data: data)
        }
        title = photo.date
        self.photos = photos
//        collection.reloadData()
    }
}

//MARK: - Action
extension PhotoController {
    @objc func shared() {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let data = photos[indexPath.row].data {
            photoImageView.image = UIImage(data: data)
        }
    }
}

//MARK: - Zoom
extension PhotoController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }
}

extension PhotoController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotosCell
        cell.configure(with: photos[indexPath.row])
        return cell
    }
}
