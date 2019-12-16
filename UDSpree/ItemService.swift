import UIKit
import Parse

class ItemService {

    
    func fetchItems(completion: @escaping (([Item]) -> Void)) {
        var items: [Item] = []
        let query = PFQuery(className: "Item")
        query.findObjectsInBackground { (objects, error) in
            if error == nil {
                if let returnedObjects = objects {
                    for object in returnedObjects {
                        let item = Item()
                        item.setTitle(title: object["title"] as! String)
                        item.setPrice (price: object["price"] as! String)
                        item.setUser (user: object["user"] as! PFUser)
                        
                        //attaching image
                        let itemImageFile = object["image"] as! PFFileObject
                        itemImageFile.getDataInBackground { (imageData: Data?, error: Error?) in
                            if let error = error {
                                print(error.localizedDescription)
                                
                            } else if let imageData = imageData {
                                item.setImage(image: UIImage(data:imageData)!)
                            }
                        }
                        items.append(item)
                    }
                    
                    completion(items)
                }
            } else {
                completion([])
            }
        }
    }
}
