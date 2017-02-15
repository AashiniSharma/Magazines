//
//  ListCellCollectionViewCell.swift
//  Magazines
//
//  Created by Appinventiv on 13/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class ListViewCell: UICollectionViewCell {

    @IBOutlet weak var magazinesNames: UILabel!
    @IBOutlet weak var magazinesImages: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        func prepareForReuse() {
            self.isSelected = false
        }
                
    }

}



class ListViewFlowout : UICollectionViewFlowLayout{
    
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
   
    func setupLayout() {
        minimumInteritemSpacing = 0
        minimumLineSpacing = 1
        scrollDirection = .vertical
    }
    
    func itemWidth() -> CGFloat {
        return collectionView!.frame.width
    }
    
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width: itemWidth(), height: 120)
        }
        get {
            return CGSize(width: itemWidth(), height: 120)
        }
    }
    
//    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
//        return collectionView!.contentOffset
//    }
}
    
    



