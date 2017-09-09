//
//  AvatarPickerVC.swift
//  SmackChat
//
//  Created by David Ortiz on 9/7/17.
//  Copyright © 2017 David Ortiz. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    //outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var seguementControl: UISegmentedControl!
    
    // variables
    var avatarType = AvatarType.dark
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell {
            cell.configureCell(index: indexPath.item, type: avatarType)//here is were we add the index number for image name and the type
            return cell
        }
        
        return AvatarCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
//seguement controller function
    @IBAction func seguementControlChange(_ sender: Any) {
        if seguementControl.selectedSegmentIndex == 0 {//seguement controller choose 0 for dark 1 for light
            avatarType = .dark
        }else {
            avatarType = .light
        }
        collectionView.reloadData()//to reload the data so it can change the interface
    }
// this is to resize the items depending on the device screen
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var numOfColumns : CGFloat = 3// columns if the screen is smaller than 320
        if UIScreen.main.bounds.width > 320 {//seting 4 columns if the device size is bigger than 320
            numOfColumns = 4
        }
        //resizeng the the columns
        let spaceBetweenCells : CGFloat = 10
        let padding : CGFloat = 40
        let cellDimention = ((collectionView.bounds.width - padding) - (numOfColumns - 1) * spaceBetweenCells) / numOfColumns
        return CGSize(width: cellDimention, height: cellDimention)
    }
//to select the avatar
//selecting the avatar and saving it depending on the file named UserDataServices.swift
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == .dark {
            UserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
        } else {
            
            UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
