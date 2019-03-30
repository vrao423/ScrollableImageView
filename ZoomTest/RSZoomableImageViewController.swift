//
//  RSZoomableImageViewController.swift
//  ZoomTest
//
//  Created by Venkat Rao on 3/4/19.
//  Copyright © 2019 Venkat Rao. All rights reserved.
//

import UIKit

class RSZoomableImageViewController: UIViewController {
    
    private var image: UIImage?
    private let imageView = RSZoomableImageView()
    
    convenience init(image: UIImage) {
        self.init(nibName: nil, bundle: nil)
        self.image = image
    }
    
    /*
     Because the zoomable image view is a `UIScrollView` subclass, we should add it as a subview,
     instead of the main view of a view controller, to achieve the expected zooming behavior.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // image view
        imageView.image = image
        view.addSubview(imageView)
        
        // image view layout constraints
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    /*
     Update the image view zoom scale when the view hierarchy of the view controller finished laying out its subviews.
     */
    override func viewDidLayoutSubviews() {
        imageView.updateZoomScale()
    }
}
