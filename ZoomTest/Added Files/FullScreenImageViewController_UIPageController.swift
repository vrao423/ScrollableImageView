//
//  FullScreenImageViewController.swift
//  ZoomTest
//
//  Created by Venkat Rao on 3/18/19.
//  Copyright © 2019 Venkat Rao. All rights reserved.
//

import UIKit
import Photos

class FullScreenImageViewControllerPageView: UIViewController {

    private let imagesView: UIPageViewController
    private let spaceView = SpaceView(frame: .zero)

    private var showSpace = false
    private var results: PHFetchResult<PHAsset>?

    private var bottomConstraint: NSLayoutConstraint?

    private var bottomSpaceViewConstraint: NSLayoutConstraint?
    private var topSpaceViewConstraint: NSLayoutConstraint?

    private let cellIdentifier = "FullScreenImageCellIdentifier"

    private func createFetchResults() -> PHFetchResult<PHAsset>?  {
        guard PHPhotoLibrary.authorizationStatus() == .authorized else { return nil }

        let collectionsResult = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)

        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        options.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)

        return PHAsset.fetchAssets(in: collectionsResult[0], options: options)
    }

    // just basic initialization here
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        imagesView = UIPageViewController(transitionStyle: UIPageViewController.TransitionStyle.scroll, navigationOrientation: UIPageViewController.NavigationOrientation.horizontal, options: nil)

        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(imagesView.view)
        imagesView.view.translatesAutoresizingMaskIntoConstraints = false
        imagesView.dataSource = self
        imagesView.delegate = self

        imagesView.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        imagesView.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        imagesView.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bottomConstraint = imagesView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)

        let show = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(toggleShowSpace))
        self.toolbarItems = [show]
        self.navigationController?.isToolbarHidden = false
        self.navigationController?.isNavigationBarHidden = true

        imagesView.view.backgroundColor = .green
        spaceView.backgroundColor = .blue

        spaceView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spaceView)

        spaceView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        spaceView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topSpaceViewConstraint = spaceView.topAnchor.constraint(equalTo: imagesView.view.bottomAnchor)
        bottomSpaceViewConstraint = spaceView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)

        bottomConstraint?.isActive = !showSpace
        topSpaceViewConstraint?.isActive = showSpace
        bottomSpaceViewConstraint?.isActive = showSpace
        spaceView.isHidden = !showSpace
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // loading fetch resutls here
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if PHPhotoLibrary.authorizationStatus() == .notDetermined {
            PHPhotoLibrary.requestAuthorization { (status) in
                if status == .authorized {
                    DispatchQueue.main.async {
                        self.results = self.createFetchResults()
//                        self.collectionView.reloadData()
//                        self.collectionView.collectionViewLayout.invalidateLayout()
                    }
                }
            }
        } else if PHPhotoLibrary.authorizationStatus() == .authorized {
            results = createFetchResults()
//            collectionView.reloadData()
//            collectionView.collectionViewLayout.invalidateLayout()
        }

//        print("size: \(self.collectionView.bounds.size) inset: \(self.collectionView.adjustedContentInset)")
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        // help:
        // if you keep rotating device, the image is not always centered
        // also not sure how to maintain current centered scroll item in collection view, but that might be a different issue.

        coordinator.animate(alongsideTransition: { (context) in
            // empty
        }) { (context) in
//            self.imagesView.view.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: false)
//            if let cell  = self.imagesView.view.visibleCells.first as? FullScreenImageCell {
//                cell.imageView.updateZoomScale()
//            }
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    @objc func toggleShowSpace() {
//        showSpace = !showSpace
//
//        bottomConstraint?.isActive = !showSpace
//
//        topSpaceViewConstraint?.isActive = showSpace
//        bottomSpaceViewConstraint?.isActive = showSpace
//        spaceView.isHidden = !showSpace
//
//        collectionView.collectionViewLayout.invalidateLayout()
//        view.layoutIfNeeded()
//
//        if let cell = self.collectionView.visibleCells.first as? FullScreenImageCell {
//            cell.imageView.updateZoomScale()
//        }
    }
}

extension FullScreenImageViewControllerPageView: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
//    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        guard let results = results else { return 0 }
//
//        return results.count
//    }
//
//    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
//
//        return cell
//    }
}

extension FullScreenImageViewControllerPageView: UIPageViewControllerDelegate {
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        guard let cell = cell as? FullScreenImageCell else { return }
//
//        guard let results = results else { fatalError() }
//        let asset = results[indexPath.item]
//
//        PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: nil) { (image, info) in
//            cell.imageView.image = image
//
//            // setting the scroll view content inset to the collection view adjusted content inset since safe areas are not inherited.
//            cell.imageView.contentInset = collectionView.adjustedContentInset
//
//            // calling update zoom scale here
//            cell.imageView.updateZoomScale()
//        }
//    }
}
