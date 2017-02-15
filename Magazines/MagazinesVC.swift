
import UIKit

class MagazinesVC: UIViewController {

    @IBOutlet weak var selectionOutlet: UIButton!
    @IBOutlet weak var labelOutlet: UILabel!
   
    @IBOutlet weak var deleteOutletButton: UIButton!
    @IBOutlet weak var searchButtonOutlet: UIButton!
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    
    var flowToDisplay = flow.list
    
    
    var listView = ListViewFlowout()
    var gridView = GridViewFlowout()
    
    
    var indexPaths = [IndexPath]()
    
//Magazines names and images (input data)
    var data: [[String:String]] = [
        ["title" : "INDIA TODAY", "values" : "m1"],
        ["title" : "FEMINA",      "values" : "m2"],
        ["title" : "OUTLOOK",     "values" : "m3"],
        ["title" : "OPEN",        "values" : "m4"],
        ["title" : "TEHELKA",     "values" : "m5"],
        ["title" : "TIME OUT",    "values" : "m6"],
        ["title" : "VOGUE",       "values" : "m7"],
        ["title" : "OPEN",        "values" : "m4"],
        ["title" : "FEMINA",      "values" : "m2"],
        ["title" : "OUTLOOK",     "values" : "m1"],
        ["title" : "OPEN",        "values" : "m4"],
        ["title" : "FEMINA",      "values" : "m2"],
        ["title" : "OUTLOOK",     "values" : "m4"],
        ["title" : "FEMINA",      "values" : "m2"],
        ["title" : "OPEN",        "values" : "m1"],
        ["title" : "OUTLOOK",     "values" : "m2"],
    ]
    

//MARK: View life cycle
    override func viewDidLoad(){
        super.viewDidLoad()
        
        let nib = UINib(nibName: "ListViewCell", bundle: nil)
        collectionViewOutlet.register(nib, forCellWithReuseIdentifier: "ListCellID")
        
        
        let xib = UINib(nibName: "GridView", bundle: nil)
        collectionViewOutlet.register(xib, forCellWithReuseIdentifier: "GridViewID")
        
        
        self.collectionViewOutlet.dataSource = self
        self.collectionViewOutlet.delegate = self
        
        self.collectionViewOutlet.collectionViewLayout = listView
        
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        self.collectionViewOutlet.addGestureRecognizer(longPressGesture)

        

    }
  
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
        
    }
    //MARK:IBActions
    @IBAction func selectionButton(_ sender: UIButton){
    
        self.collectionViewOutlet.reloadData()
        
        if self.selectionOutlet.isSelected{
            
            self.selectionOutlet.isSelected = false
            flowToDisplay = flow.list
            
            UIView.animate(withDuration: 1.0) { () -> Void in
                self.collectionViewOutlet.collectionViewLayout.invalidateLayout()
                self.collectionViewOutlet.setCollectionViewLayout(self.listView, animated: true)}
        
        }
        else{
            
            self.selectionOutlet.isSelected = true
            flowToDisplay = flow.grid
            
            UIView.animate(withDuration: 1.0) { () -> Void in
                self.collectionViewOutlet.collectionViewLayout.invalidateLayout()
                self.collectionViewOutlet.setCollectionViewLayout(self.gridView, animated: true)}
        }
       
    }
    @IBAction func deleteActionButton(_ sender: UIButton) {
        
        deleteOutletButton.isHidden = true
        deleteOutletButton.isEnabled = false
        
        indexPaths = indexPaths.sorted(by: >)
        
        for index in 0..<indexPaths.count {
            data.remove(at: (indexPaths[index].row))
            collectionViewOutlet.deleteItems(at: [indexPaths[index]])
        }

        
        indexPaths = []
        
        self.collectionViewOutlet.reloadData()
        
        
        
    }
 // function for long tap gesture
    func handleLongPress(gesture : UILongPressGestureRecognizer!) {
        
       
        deleteOutletButton.isHidden = false
        deleteOutletButton.isEnabled = true
        gesture.minimumPressDuration = 0.05
        
        if gesture.state != .ended {
            return
        }
        let p = gesture.location(in: self.collectionViewOutlet)
        
        if let indexPath = self.collectionViewOutlet.indexPathForItem(at: p) {
            
            let cell = self.collectionViewOutlet.cellForItem(at: indexPath)
          
            
            if !(indexPaths.contains(indexPath)){
                indexPaths.append(indexPath)
                cell?.layer.borderWidth = 5
            }else {
                indexPaths.remove(at: indexPaths.index(of: indexPath)!)
                cell?.layer.borderWidth = 0
            }
            
        print(indexPaths)
           
        }
        else {
            print("couldn't find index path")
        }
    }
    
}


//MARK: collection view,datasource,delegate,delegates of flowlayout
extension MagazinesVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return data.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        //MARK: list view
        if flowToDisplay == flow.list{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCellID", for: indexPath) as! ListViewCell
                cell.magazinesNames.text = data[indexPath.item]["title"]
                cell.magazinesImages.image = UIImage(named: data[indexPath.item]["values"]!)
//                cell.backgroundColor = .clear
                return cell
        }
        //MARK: grid view
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridViewID", for: indexPath) as! GridView
            cell.magazinesNanesGrid.text = data[indexPath.item]["title"]
            cell.magazinesImagesGrid.image = UIImage(named: data[indexPath.item]["values"]!)

            return cell
        }
     
    }
    
}



enum flow {
    case list,grid
}





