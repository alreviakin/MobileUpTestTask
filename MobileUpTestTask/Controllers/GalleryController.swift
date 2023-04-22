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
    private var photos = [Photo]()
    private var languageSegmented: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Ru", "En"])
        segment.tintColor = .white
        segment.backgroundColor = .lightGray
        segment.selectedSegmentIndex = 0
        return segment
    }()
    
    //MARK: - Configure UI
    override func viewDidLoad() {
        super.viewDidLoad()
        request()
        configure()
        layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if currentReachabilityStatus == .notReachable {
            let alert = UIAlertController(title: R.Error.noInternet)
            present(alert, animated: true)
        }
    }
    
    func configure() {
        title = "MobileUp Gallery"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: R.Gallery.exit, style: .done, target: self, action: #selector(logout))
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular)], for: .normal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: languageSegmented)
        languageSegmented.addTarget(self, action: #selector(changeLanguage), for: .valueChanged)
        languageSegmented.selectedSegmentIndex = R.isRussian ? 0 : 1
        
        view.addSubview(collection)
        collection.dataSource = self
        collection.delegate = self
        collection.register(PhotosCell.self, forCellWithReuseIdentifier: "cell")
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
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotosCell
        cell.configure(with: photos[indexPath.row])
        
        return cell
    }
}

//MARK: - Action
@objc extension GalleryController {
    func logout() {
        AuthService.shared.logout()
    }
    
    func changeLanguage() {
        R.isRussian = !R.isRussian
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: R.Gallery.exit, style: .done, target: self, action: #selector(logout))
        for photo in photos {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMMM yyyy"
            if R.Gallery.date == "ru_Ru" {
                dateFormatter.locale = Locale(identifier: "en_US")
            } else {
                dateFormatter.locale = Locale(identifier: "ru_Ru")
            }
            let date = dateFormatter.date(from: photo.date)
            dateFormatter.locale = Locale(identifier: R.Gallery.date)
            photo.date = dateFormatter.string(from: date!)
        }
    }
}

//MARK: - Transition
extension GalleryController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PhotoController()
        vc.initialize(photos: photos, index: indexPath.row)
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: Request
extension GalleryController {
    func request() {
        NetworkService.shared.request(path: API.photosGet, params: ["owner_id": "-128666765", "album_id": "266310117"]) {[weak self] photos, error in
            guard let self else {return}
            guard error == nil else {
                let alert = UIAlertController(title: R.Error.dataLoading)
                present(alert, animated: true)
                return
            }
            if let photos = photos {
                for responsePhoto in photos.response.items {
                    let dateFormater = DateFormatter()
                    dateFormater.locale = Locale(identifier: R.Gallery.date)
                    dateFormater.dateFormat = "dd MMMM yyyy"
                    let date = Date(timeIntervalSince1970: TimeInterval(responsePhoto.date))
                    let url = URL(string: responsePhoto.sizes.last!.url)
                    let photo = Photo(date: dateFormater.string(from: date), url: url)
                    self.photos.append(photo)
                }
                collection.reloadData()
            }
        }
    }
}

