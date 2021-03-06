import UIKit
import Parse

class ItemService {
    var wishlist: [String] = []
    let currUser = PFUser.current()
    
    func fetchItems(constraint: String, completion: @escaping (([Item]) -> Void)) {
        var items: [Item] = []
        let query = PFQuery(className: "Item")
        if (constraint != "") {
            query.whereKey("type", equalTo: constraint)
        }
        query.whereKey("sold", equalTo: false)
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground { (objects, error) in
            if error == nil {
                if let returnedObjects = objects {
                    for object in returnedObjects {
                            let item = Item()
                            item.setTitle(title: object["title"] as! String)
                            item.setPrice (price: object["price"] as! String)
                            item.setDescription(description: object["description"] as! String)
                            item.setUser (user: object["user"] as! PFUser)
                            item.setId(id: object.objectId!)
                           
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

