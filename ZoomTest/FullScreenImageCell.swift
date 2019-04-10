//
//  FullScreenImageCell.swift
//  ZoomTest
//
//  Created by Venkat Rao on 3/18/19.
//  Copyright © 2019 Venkat Rao. All rights reserved.
//

import UIKit

class FullScreenImageCell: UICollectionViewCell {

    let imageView = RSZoomableImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        backgroundColor = .purple
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        print("FullScreenImageCell: in layoutSubviews height: \(bounds.height)")
    }

    override func prepareForReuse() {
        imageView.image = nil
    }
}
