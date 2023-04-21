//
//  GalleryController.swift
//  MobileUpTestTask
//
//  Created by Алексей Ревякин on 21.04.2023.
//

import UIKit

class GalleryController: UIViewController {
    //MARK: - Variable
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let side = view.bounds.width / 2 - 1
        layout.itemSize = CGSize(width: side, height: side)
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 1
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
    
    func configure() {
        title = "MobileUp Gallery"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Выход", style: .done, target: self, action: #selector(logout))
        
        view.addSubview(collection)
        collection.dataSource = self
        collection.delegate = self
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    func layout() {
        collection.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

//MARK: - Collection Configure
extension GalleryController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let imageView = UIImageView(image: UIImage(named: "1"))
        cell.backgroundView = imageView
        return cell
    }
}

//MARK: - Action
extension GalleryController {
    @objc func logout() {
    }
}

