import Vapor

extension Droplet {
    func setupRoutes() throws {
        get("hello") { req in
            var json = JSON()
            try json.set("hello", "world")
            return json
        }

        get("plaintext") { req in
            return "Hello, world!"
        }

        // response to requests to /info domain
        // with a description of the request
        get("info") { req in
            return req.description
        }
        
        //Upcase
        get("upcase") { request in
            if let words = request.query?["words"]?.string {
                
                return words.uppercased()
            }
            return "No words supplied"
        }
        
        //save name
        post("name") { req in
            if let name = req.data["name"]?.string{
                var json = JSON()
                try json.set("name", name)
                return json
            }
            return "Not a name"
        }

        //initialize the Store, after setting it to the Target membership for the "App"
        let store = Store()
        
        //adds to the store
        post("store") { req in
            if let key = req.data["key"]?.string,
                let val = req.data["value"]?.string {
                store.set(key: key, value: val)
//                print("Stored: \(store.allItems())")
                return "Stored items"
            } else {
                return "Need key and value"
            }
        }
        
        //looks it up
        get("lookup"){ req in
            if let lookup = req.query?["key"]?.string {
                if let found =  store.get(key: lookup) {
                    return found
                }else{
                    return "Key not found"
                }
            }
            return "Lookup not found"
        }

        //retrieves the data
        get("retrieve") { req in
            return ("Items: \(store.info)")
        }
        
        get("description") { req in return req.description }
        
        try resource("posts", PostController.self)
    }
    
}
