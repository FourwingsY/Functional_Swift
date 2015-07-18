enum JSONNode {
    case NullNode
    case StringNode(String)
    case NumberNode(Float)
    case BoolNode(Bool)
    case ArrayNode([JSONNode])
    case ObjectNode([String:JSONNode])
}

func jsonStringify(json: JSONNode) -> String {
    func jsonArrayStringify(array: [JSONNode]) -> String {
        if array.isEmpty {
            return ""
        }
        let stringArray = array.map({
            node in
            jsonStringify(node)
        })
        let head = stringArray[0]
        let tail = stringArray[1..<stringArray.count]
        return tail.reduce(head) {
            "\($0), \($1)"
        }
    }
    
    func jsonObjectStringify(object: [String:JSONNode]) -> String {
        if object.isEmpty {
            return ""
        }
        let stringArray = object.map() {
            (key, value) in
            "\"\(key)\": \(jsonStringify(value))"
        }
        let head = stringArray[0]
        let tail = stringArray[1..<stringArray.count]
        return tail.reduce(head) {
            a, b in
            "\(a), \(b)"
        }
    }
    
    switch json {
        case .NullNode:
            return "null"
        case .StringNode(let str):
            return "\"\(str)\""
        case .NumberNode(let num):
            return String(num)
        case .BoolNode(let bool):
            return String(bool)
        case .ArrayNode(let array):
            return "[\(jsonArrayStringify(array))]"
        case .ObjectNode(let object):
            return "{\(jsonObjectStringify(object))}"
    }
}


/* Test Code */

let x : JSONNode = .ArrayNode([
    .NumberNode(10.0),
    .StringNode("hello"),
    .BoolNode(false)
])
let y : JSONNode = .ObjectNode([
    "one" : .NullNode,
    "two" : x,
    "three": .StringNode("hi")
])

jsonStringify(x)
jsonStringify(y)
