//
//  RSZoomableImageView.swift
//  ZoomTest
//
//  Created by Venkat Rao on 3/4/19.
//  Copyright © 2019 Venkat Rao. All rights reserved.
//

import UIKit

class RSZoomableImageView: UIScrollView {
    
    /*
     The image being displayed by the image view within the scroll view.
     Note: Setting an image resizes the image view according to its instrinsic size constraints and may trigger a layout pass of the scroll view.
     */
    
    var image: UIImage? {
        didSet {
            self.imageView.image = self.image
            self.imageView.sizeToFit()
            self.layoutIfNeeded()
        }
    }
    
    /*
     The tap gesture recognizer within the scroll view.
     Note: The user may double tap to trigger a zoom out transition within `RSZoomableImageView.doubleTapRecognized(_:)`.
     */
    
    private lazy var doubleTapGestureRecognizer: UITapGestureRecognizer = {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RSZoomableImageView.doubleTapRecognized(_:)))
        gestureRecognizer.numberOfTapsRequired = 2
        return gestureRecognizer
    }()
    
    /*
     The image view displayed within the scroll view.
     Note: The scroll view registers this image view as its view for handling zoom interactions within `UIScrollViewDelegate.viewForZooming(in:).
     */
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: frame)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    /*
     The following properties configure the layout constraints for the image view.
     Note: The constants of these constraints may be modified to center the image view within the scroll view while zooming.
     */
    
    private lazy var imageViewTopConstraint: NSLayoutConstraint = {
        return self.imageView.topAnchor.constraint(equalTo: self.topAnchor)
    }()
    
    private lazy var imageViewLeftConstraint: NSLayoutConstraint = {
        return self.imageView.leftAnchor.constraint(equalTo: self.leftAnchor)
    }()
    
    private lazy var imageViewRightConstraint: NSLayoutConstraint = {
        return self.imageView.rightAnchor.constraint(equalTo: self.rightAnchor)
    }()
    
    private lazy var imageViewBottomConstraint: NSLayoutConstraint = {
        return self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // scroll view
        // had to comment this out so image would be under safe areas when larger than screen
        self.contentInsetAdjustmentBehavior = .never
        self.delegate = self
        self.scrollsToTop = false
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false

        // image view
        self.addSubview(self.imageView)

        // image view layout constraints
        NSLayoutConstraint.activate([self.imageViewTopConstraint, self.imageViewLeftConstraint, self.imageViewRightConstraint, self.imageViewBottomConstraint])
        
        // gesture recognizer
        self.addGestureRecognizer(self.doubleTapGestureRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func doubleTapRecognized(_ gestureRecognizer: UITapGestureRecognizer) {
        self.setZoomScale(self.minimumZoomScale, animated: true)
    }
    
    /*
     The following method updates the zoom scale of the scroll view.
     Note: The calculation is based on the ration between the visible frame of the scroll view and that of the image size via image view bounds.
     */
    
    func updateZoomScale() {
        // the ratio of the scroll view width vs the image width at full scale.
        let widthScale = (self.frame.width - self.adjustedContentInset.left - self.adjustedContentInset.right)  / self.imageView.bounds.width

        // the ratio of the scroll view height vs the image height at full scale.
        let heightScale = (self.frame.height - self.adjustedContentInset.top - self.adjustedContentInset.bottom) / self.imageView.bounds.height

        // the minimum zoom scale is the lesser of the two scale ratios.
        let minimumZoomScale = min(widthScale, heightScale)
        self.minimumZoomScale = minimumZoomScale
        self.zoomScale = minimumZoomScale

        center()
    }

    func center() {
        let horizontalOffset = max(0, (self.bounds.width - self.imageView.frame.width) / 2)
        self.imageViewLeftConstraint.constant = horizontalOffset
        self.imageViewRightConstraint.constant = horizontalOffset

        // vertically center the image view within the scroll view as it zooms.
        let verticalOffset = max(0, (self.bounds.height - self.adjustedContentInset.top - self.adjustedContentInset.bottom - self.imageView.frame.height) / 2)
        self.imageViewTopConstraint.constant = verticalOffset
        self.imageViewBottomConstraint.constant = verticalOffset
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        print("RSZoomableImageView: layoutSubView height: \(bounds.height)")
    }
}

// MARK: UIScrollViewDelegate

extension RSZoomableImageView: UIScrollViewDelegate {
    
    /*
     The delegate method responsible for executing any time the zoom scale changes within the scroll view.
     */
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        // horizontally center the image view within the scroll view as it zooms.

        center()
        self.layoutIfNeeded()
    }
    
    /*
     The delegate method responsible for returning a view which will be scaled during a zoom interaction within the scroll view.
     */
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}
