//
//  ChurchDetailViewController.swift
//  WedeChurchIOS
//
//  Created by Muluken on 5/30/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit

class ChurchDetailViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var detailChurchLogo: UIImageView!
    @IBOutlet weak var detailChurchName: UILabel!
    
    // get data eventnamesfrom event main controller
    var labeldetail: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "churchName") as AnyObject?
        }
        
    }
    //get imagesfrom main eventviewcntroller
    var imageDetail: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "churchImage") as AnyObject?
        }
        
    }
    @IBOutlet weak var collectionView: UICollectionView!
    var cellIdentifier = "churchEvents"
    var numberOfItemsPerRow : Int = 2
    var churchEventNames:[String]?
    var churchEventImages:[String]?
    
    var refreshControl:UIRefreshControl?
    
    // sending images to detail event view
    var sendChurchEventTitle: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "churchEventName") as AnyObject?
        }
        set {
            UserDefaults.standard.set(newValue!, forKey: "churchEventName")
            UserDefaults.standard.synchronize()
        }
    }
    var sendChurchEventImages: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "churchEventImage") as AnyObject?
        }
        set {
            UserDefaults.standard.set(newValue!, forKey: "churchEventImage")
            UserDefaults.standard.synchronize()
        }
    }
    // collection items size
    var cellWidth:CGFloat{
        return collectionView.frame.size.width/2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailChurchName.text = labeldetail as? String
        detailChurchLogo.image = UIImage(named: imageDetail as! String)
        
        
        // navigation controller items control
        // self.navigationController?.setNavigationBarHidden(true, animated: true)
        collectionView.dataSource = self
        collectionView.delegate = self
        self.churchEventNames = ["Event1","Event2","Event3","Event4","Event5","Event6","Event7","Event8","Event9", "Event10"]
        self.churchEventImages = ["church","mekane","yougo","church","mekane","yougo","church","mekane","yougo", "church","mekane","yougo"]
    }
    
    
    // MARK: <UICollectionViewDataSource>
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! OneChurchCollectionViewCell
        cell.indexPath = indexPath
        //  cell.topButton.backgroundColor = UIColor .blue
        cell.layer.cornerRadius = 20.0;
        // cell.layer.borderColor = UIColor.green.cgColor
        // cell.topLabel.textColor = UIColor.blue
        cell.churchEventImage.image = UIImage(named: (self.churchEventImages?[indexPath.row])!)
        
        cell.churchEventName!.text = self.churchEventNames![indexPath.row];
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.churchEventNames!.count
    }
    
    
    
    // MARK: <UICollectionViewDelegateFlowLayout>
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfItemsPerRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberOfItemsPerRow))
        return CGSize(width: size, height: size)
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        sendChurchEventTitle = churchEventNames? [indexPath.row] as AnyObject?
        sendChurchEventImages = churchEventImages? [indexPath.row] as AnyObject?
        
        
    }
    
}


