//
//  DenominationViewController.swift
//  WedeChurchIOS
//
//  Created by Muluken on 6/7/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit

class DenominationViewController:  UIViewController,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout , UISearchBarDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var menuBar: UIBarButtonItem!
    
    @IBOutlet weak var denominationSearchBar: UISearchBar!
    
    var cellIdentifier = "denomCell"
    var numberOfItemsPerRow : Int = 2
    var denominationNames:[String]?
    var denominationLogos:[String]?
    var dataSourceForSearchResult:[String]?
    var searchBarActive:Bool = false
    var searchBarBoundsY:CGFloat?
    var refreshControl:UIRefreshControl?
    
    // sending denominationName to detail denomination Controller view
    var denominationName: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "denominationName") as AnyObject?
        }
        set {
            UserDefaults.standard.set(newValue!, forKey: "denominationName")
            UserDefaults.standard.synchronize()
        }
    }
    //sending denomination logo to detail denomination view controller
    var denominationLogo: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "denominationLogo") as AnyObject?
        }
        set {
            UserDefaults.standard.set(newValue!, forKey: "denominationLogo")
            UserDefaults.standard.synchronize()
        }
    }
    // collection items size
    var cellWidth:CGFloat{
        return collectionView.frame.size.width/2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // navigation drawer in menu bars
        if revealViewController() != nil {
            
            menuBar.target = revealViewController()
            menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        
        // navigation controller items control
        // self.navigationController?.setNavigationBarHidden(true, animated: true)
        denominationSearchBar.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        self.denominationNames = ["Mekane Yesus" , "Mulu Wongel" , "Hiwot BIrhan" , "Church1","Beza International" , "Meserete Christos" , "Kale Hiwot" , "You Go" , "Bethel" , "Glorious"]
        self.denominationLogos = ["church","mekane","yougo","church","mekane","yougo","church","mekane","yougo", "church","mekane","yougo"]
        self.dataSourceForSearchResult = [String]()
    }
    
    // MARK: Search
    func filterContentForSearchText(searchText:String){
        self.dataSourceForSearchResult = self.denominationNames?.filter({ (text:String) -> Bool in
            return text.contains(searchText)
        })
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count > 0 {
            self.searchBarActive    = true
            self.filterContentForSearchText(searchText: searchText)
            self.collectionView?.reloadData()
        }else{
            self.searchBarActive = false
            self.collectionView?.reloadData()
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self .cancelSearching()
        self.collectionView?.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBarActive = true
        self.view.endEditing(true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.denominationSearchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchBarActive = false
        self.denominationSearchBar.setShowsCancelButton(false, animated: false)
    }
    func cancelSearching(){
        self.searchBarActive = false
        self.denominationSearchBar.resignFirstResponder()
        self.denominationSearchBar.text = ""
    }
    
    
    // MARK: <UICollectionViewDataSource>
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! DenominationCollectionViewCell
        cell.indexPath = indexPath
        //  cell.topButton.backgroundColor = UIColor .blue
        // cell.topLabel.textColor = UIColor.blue
        cell.denominationImage.image = UIImage(named: (self.denominationLogos?[indexPath.row])!)
        if (self.searchBarActive) {
            cell.deniminationName!.text = self.dataSourceForSearchResult![indexPath.row];
        }else{
            cell.deniminationName!.text = self.denominationNames![indexPath.row];
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.searchBarActive {
            return self.dataSourceForSearchResult!.count;
        }
        return self.denominationNames!.count
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
        
        denominationName = denominationNames? [indexPath.row] as AnyObject?
        denominationLogo = denominationLogos? [indexPath.row] as AnyObject?
        
        
    }
    
}
