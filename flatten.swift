import UIKit

var obj: [String:Any] = ["a":["x":1,"y":2], "b":["z":["o":1],"w":3], "nested":[[10,20],[["a":10,"b":"20"],40]], "arr":[1,["q":[2.1,3.1,3.2],"w":2.2],3]]

print(flatten(obj: obj))


func flatten(obj: [String:Any]) -> [[String:Any]] {
    var returnDictionary = [[String:Any]]()
    var count = 1
    
    for dict in obj {
        let dictVal = dict.value
        let dictKey = dict.key
        
        //Checking if type is Array
        if dictVal is Array<Any> {
            let value = dictVal as! Array<Any>
            var index = 0
            for val in value {
                //Check if Array Type
                if val is Array<AnyObject> {
                   let arr = val as! Array<AnyObject>
                    var innerIndex = 0
                    //Iterate through array
                    for i in arr {
                        //Check if Dictionary Type
                        if i is Dictionary<String, Any> {
                            let dict = i as! Dictionary<String, Any>
                            
                            for (a, b) in dict {
                                let newKey = "\(dictKey).\(index).\(innerIndex).\(a)"
                                let newDict: [String:Any] = ["key":newKey, "value": b]
                                returnDictionary.append(newDict)
                            }
                        } else {
                            // Else Any - immediately append
                            let newKey = "\(dictKey).\(index).\(innerIndex)"
                            let newDict: [String:Any] = ["key":newKey, "value": i]
                            returnDictionary.append(newDict)
                        }
                        
                        innerIndex += 1
                    }
                    //Else it is Dictionary Type
                } else if val is Dictionary<String, Any> {
                    let dict = val as! Dictionary<String, Any>
                    //Iterate through dictionary
                    for (a, b) in dict {
                        // check if value is an array
                        if b is Array<AnyObject> {
                            let arr = b as! Array<AnyObject>
                            
                            var innerIndex = 0
                            //for value in array append
                            for c in arr {
                                let newKey = "\(dictKey).\(index).\(a).\(innerIndex)"
                                let newDict: [String:Any] = ["key":newKey, "value": c]
                                returnDictionary.append(newDict)
                                innerIndex += 1
                            }
                        } else {
                            // else immediately append
                            let newKey = "\(dictKey).\(index).\(a)"
                            let newDict: [String:Any] = ["key":newKey, "value": b]
                            returnDictionary.append(newDict)
                        }
                    }
                } else {
                    // else immediately append val
                    let newKey = "\(dictKey).\(index)"
                    let newDict: [String:Any] = ["key":newKey, "value": val]
                    returnDictionary.append(newDict)
                }
                
                index += 1
            }
        } else {
            //It is type Dictionary
            let value = dictVal as! Dictionary<String, Any>
                
            // iterate through dictionary
            for (keyName, keyVal) in value {
                //check if keyVal is a dictionary
                if keyVal is Dictionary<String, Any> {
                    let dict = keyVal as! Dictionary<String, Any>
                    
                    //iterate through dictionary and append b (value)
                    for (a, b) in dict {
                        let newKey = "\(dictKey).\(keyName).\(a)"
                        let newDict: [String:Any] = ["key":newKey, "value": b]
                        returnDictionary.append(newDict)
                    }
                //immediately append keyVal
                } else {
                    let newKey = "\(dictKey).\(keyName)"
                    let newDict: [String:Any] = ["key":newKey, "value": keyVal]
                    returnDictionary.append(newDict)
                }
            }
        }
        count += 1
    }
    
    return returnDictionary
}

/*
 flatten(obj) => [
 {"key":"a.x","value":1},
 {"key":"a.y","value":2},
 {"key":"b.z.o","value":1},
 {"key":"b.w","value":3},
 {"key":"arr.0", "value":1},
 {"key":"arr.1.q.0", "value":2.1},
 {"key":"arr.1.q.1", "value":3.1},
 {"key":"arr.1.q.2", "value":3.2},
 {"key":"arr.1.w", "value":2.2},
 {"key":"arr.2", "value":3},
 {"key":"nested.0.0", "value": 10},
 {"key":"nested.0.1", "value": 20},
 {"key":"nested.1.0.a", "value": 10},
 {"key":"nested.1.0.b", "value": 20},
 {"key":"nested.1.1", "value": 40}
 ]
 */
