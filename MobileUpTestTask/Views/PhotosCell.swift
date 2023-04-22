//
//  PhotosCell.swift
//  MobileUpTestTask
//
//  Created by Алексей Ревякин on 21.04.2023.
//

import UIKit

class PhotosCell: UICollectionViewCell {
    //MARK: - Variable
    let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    let indicator = UIActivityIndicatorView(style: .large)
    
    //MARK: - UI config
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
        contentView.addSubview(indicator)
    }
    
    override func layoutSubviews() {
        imageView.frame = contentView.frame
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        indicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func configure(with photo: Photo) {
        if let data = photo.data {
            imageView.image = UIImage(data: data)
        } else {
            indicator.startAnimating()
            if let url = photo.url {
                URLSession.shared.dataTask(with: URLRequest(url: url)) {[weak self] data, _, error in
                    guard let data, error == nil else {return}
                    photo.data = data
                    DispatchQueue.main.async {
                        self?.imageView.image = UIImage(data: data)
                        self?.indicator.stopAnimating()
                        self?.indicator.isHidden = true
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
