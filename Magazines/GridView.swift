//
//  GridView.swift
//  Magazines
//
//  Created by Appinventiv on 13/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class GridView: UICollectionViewCell {

    @IBOutlet weak var magazinesImagesGrid: UIImageView!
    
    
    @IBOutlet weak var magazinesNanesGrid: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        func prepareForReuse() {
            self.isSelected = false
        }
        
       
      
    }

}


class GridViewFlowout : UICollectionViewFlowLayout{
    
    
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
        return collectionView!.frame.width/2 - 1
    }
    
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width: itemWidth(), height: 165)
        }
        get {
            return CGSize(width: itemWidth(), height: 165)
        }
    }
    
//    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
//        return collectionView!.contentOffset
//    }
}

