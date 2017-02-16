
import UIKit

class MagazinesVC: UIViewController {

    @IBOutlet weak var selectionOutlet: UIButton!
    @IBOutlet weak var labelOutlet: UILabel!
   
    @IBOutlet weak var deleteOutletButton: UIButton!
   
    @IBOutlet weak var searchButtonOutlet: UIButton!
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    
    @IBOutlet weak var searchTextfield: UITextField!
    
    @IBOutlet weak var noofSelectesItems: UILabel!
    
    var flowToDisplay = flow.list
    
    
    var listView = ListViewFlowout()
    var gridView = GridViewFlowout()
    
    
    var indexPaths = [IndexPath]()
    var filtered : [String] = []
    
    var searchActive : Bool = false
    
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
        
        noofSelectesItems.isHidden = true
        
        let nib = UINib(nibName: "ListViewCell", bundle: nil)
        collectionViewOutlet.register(nib, forCellWithReuseIdentifier: "ListCellID")
        
        
        let xib = UINib(nibName: "GridView", bundle: nil)
        collectionViewOutlet.register(xib, forCellWithReuseIdentifier: "GridViewID")
        
        
        self.collectionViewOutlet.dataSource = self
        self.collectionViewOutlet.delegate = self
        
        self.collectionViewOutlet.collectionViewLayout = listView
        
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        self.collectionViewOutlet.addGestureRecognizer(longPressGesture)
        
        collectionViewOutlet.allowsSelection = false

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
            
            UIView.animate(withDuration: 0.35) { () -> Void in
            self.collectionViewOutlet.collectionViewLayout.invalidateLayout()
            self.collectionViewOutlet.setCollectionViewLayout(self.listView, animated: true)}
            
        }
        else{
            
            self.selectionOutlet.isSelected = true
            flowToDisplay = flow.grid
            
           
            
            UIView.animate(withDuration: 0.35) { () -> Void in
            self.collectionViewOutlet.collectionViewLayout.invalidateLayout()
            self.collectionViewOutlet.setCollectionViewLayout(self.gridView, animated: true)}
            
        }
       
    }
    @IBAction func deleteActionButton(_ sender: UIButton) {

        deleteOutletButton.isHidden = true
        deleteOutletButton.isEnabled = false
        noofSelectesItems.isHidden = true
        
        indexPaths = indexPaths.sorted(by: >)
        
        for index in 0..<indexPaths.count {
            
            data.remove(at: (indexPaths[index].row))
        
            collectionViewOutlet.deleteItems(at: [indexPaths[index]])
        

        }
        
        indexPaths = []
                
        collectionViewOutlet.allowsMultipleSelection = false
        collectionViewOutlet.allowsSelection = false
        
    }
    @IBAction func seacrhButtonAction(_ sender: UIButton) {
        
        labelOutlet.isHidden = true
        searchTextfield.isHidden = false
        

    }
    @IBAction func searchTextfieldAction(_ sender: UITextField) {
        
        searchText(searchText: searchTextfield, textDidChange: "")
        
//        if(collectionViewOutlet.alpha == 0){
//            collectionViewOutlet.alpha = 1
//            searchActive = true;
//            searchText(searchText: searchTextfield, textDidChange: "")
//            
//        }else{
//            collectionViewOutlet.alpha = 0
//            searchActive = false;
//        }
        
    }
    
    func searchText(searchText: UITextField, textDidChange newSearch: String) {
        
        let filtered = data.filter { (index : [String : String]) -> Bool in
            
            return searchTextfield.text == index["title"]
            
        }
        print(filtered)
    }
    
    
 // function for long tap gesture
    func handleLongPress(gesture : UILongPressGestureRecognizer!) {
        
       
        deleteOutletButton.isHidden = false
        deleteOutletButton.isEnabled = true
        
        collectionViewOutlet.allowsMultipleSelection = true
        
        
        if gesture.state == .ended {
            return
        }
        let p = gesture.location(in: self.collectionViewOutlet)
        
        if let indexPath = self.collectionViewOutlet.indexPathForItem(at: p) {
            
         collectionViewOutlet.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
            collectionView(collectionViewOutlet, didSelectItemAt: indexPath)
            
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
            
            if  (indexPaths.contains(indexPath)){
                
                cell.backgroundColor = UIColor.lightText

                
            }
            
            else{
            
            
               cell.backgroundColor = .clear
              
            }
              return cell
        }
        //MARK: grid view
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridViewID", for: indexPath) as! GridView
            cell.magazinesNanesGrid.text = data[indexPath.item]["title"]
            cell.magazinesImagesGrid.image = UIImage(named: data[indexPath.item]["values"]!)
            
            
            if  (indexPaths.contains(indexPath)){
                
                cell.backgroundColor = UIColor.lightText
                
                
            }
                
            else{

            cell.backgroundColor = .clear
          
        }
       return cell
    }
}
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        noofSelectesItems.isHidden = false
        
        
        labelOutlet.isHidden = false
        searchTextfield.isHidden = true
        if !(indexPaths.contains(indexPath)){
       
            indexPaths.append(indexPath)
            print(#function)
            noofSelectesItems.text = "\(indexPaths.count)"
            noofSelectesItems.layer.borderWidth = 1
            noofSelectesItems.layer.borderColor = UIColor.black.cgColor
        }
        let cell = self.collectionViewOutlet.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.lightText

    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print(#function)

        let cell = self.collectionViewOutlet.cellForItem(at: indexPath)
        indexPaths.remove(at: indexPaths.index(of: indexPath)!)
        cell?.backgroundColor = UIColor.clear
        
         noofSelectesItems.text = "\(indexPaths.count)"
        
        if indexPaths.isEmpty{
            deleteOutletButton.isHidden = true
            deleteOutletButton.isEnabled = false
            noofSelectesItems.text = ""
            noofSelectesItems.layer.borderWidth = 0
            collectionViewOutlet.allowsSelection = false
            collectionViewOutlet.allowsMultipleSelection = false
            
        }
        
    }
    
}


enum flow {
    case list,grid
}





