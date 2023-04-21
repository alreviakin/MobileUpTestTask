//
//  PhotosCell.swift
//  MobileUpTestTask
//
//  Created by Алексей Ревякин on 21.04.2023.
//

import UIKit

class PhotosCell: UICollectionViewCell {
    let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        contentView.addSubview(imageView)
    }
    
    override func layoutSubviews() {
        imageView.frame = contentView.frame
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(with photo: Photo) {
        if let data = photo.data {
            imageView.image = UIImage(data: data)
        } else {
            if let url = photo.url {
                URLSession.shared.dataTask(with: URLRequest(url: url)) {[weak self] data, _, error in
                    guard let data, error == nil else {return}
                    photo.data = data
                    DispatchQueue.main.async {
                        self?.imageView.image = UIImage(data: data)
                    }
                }.resume()
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
