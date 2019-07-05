//
//  ViewController.swift
//  0800 CollectionView 12
//
//  Created by Trương Quang on 7/3/19.
//  Copyright © 2019 Trương Quang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var myCollectionView: UICollectionView!
    var array = [Int](1...27)
    var estimateWidth: CGFloat = 130
    var interitemSpacing: CGFloat = 3
    var lineSpacing: CGFloat = 3
    
    let pagingScrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        
//        // Initialize Paging scrollView
//        self.initScrollView()
//        
//        // Add custom paging scrollView
//        self.view.addSubview(self.pagingScrollView)
//        
//        // Disable standard gesture recognizer for UICollectionView scrollView and add custom
//        self.myCollectionView?.addGestureRecognizer(self.pagingScrollView.panGestureRecognizer)
//        self.myCollectionView?.panGestureRecognizer.isEnabled = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setGrid()
        DispatchQueue.main.async {
            self.myCollectionView.reloadData()
        }
    }
    
    func setGrid() {
        let layout = myCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = lineSpacing
        layout.minimumInteritemSpacing = interitemSpacing
        
        let width = calculator()
        layout.itemSize = CGSize(width: width, height: width)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func calculator() -> CGFloat {
        let countCell = Int(view.frame.size.width/estimateWidth)
        print(countCell)
        let width: CGFloat = (view.frame.size.width - (interitemSpacing*(CGFloat(countCell)-1)))/CGFloat(countCell)
        return width
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCell
        cell.myImageView.image = UIImage(named: String(array[indexPath.row]) + ".jpg")
        return cell
    }
    
    //

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // Override native UICollectionView scrollView events
        if scrollView == self.pagingScrollView {
            print("Im Here")
            var contentOffset = scrollView.contentOffset
            
            // Include offset from left
            if let contentOffsetX = self.myCollectionView?.contentInset.left {
                contentOffset.x = contentOffset.x - contentOffsetX
                self.myCollectionView?.contentOffset = contentOffset
                print(contentOffset)
            }
        }
    }
    
    // MARK: - Initialize scrollView with proper size and frame
    func initScrollView() {
        
        // Get UICollectionView frame
        if let collectionViewFrame = self.myCollectionView?.frame {
            
            // Set proper frame
            self.pagingScrollView.frame = collectionViewFrame
            self.pagingScrollView.isHidden = true
            
            // Enable paging
            self.pagingScrollView.isPagingEnabled = true
            
            self.pagingScrollView.contentSize = CGSize(width: pagingScrollView.contentSize.width,height: pagingScrollView.frame.size.height)
            
            // Set delegate
            self.pagingScrollView.delegate = self
            
            // Set bounds for scrollView
            self.pagingScrollView.bounds = CGRect(x: 0, y: 0, width: self.calculator() + self.interitemSpacing, height: collectionViewFrame.size.height)
            
//            self.pagingScrollView.bounds = CGRect(x: 0, y: 0, width: self.calculator() + self.interitemSpacing, height: 0)
            
            // Number of items in UICollectionView
            if let numberOfItemsInCollectionView = self.myCollectionView?.numberOfItems(inSection: 0) {
//                print("\(numberOfItemsInCollectionView)" + "Im here")
                // Calculcate full width (with spacing) for contentSize
                let collectionViewWidth = CGFloat(numberOfItemsInCollectionView) * (self.calculator() + self.interitemSpacing)
                
                // Set contentSize
                self.pagingScrollView.contentSize = CGSize(width: collectionViewWidth, height: view.frame.size.height)
            }
        }
    }
    
    
    
    
}

