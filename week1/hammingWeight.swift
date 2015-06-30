func hammingWeight(n: Int) -> (String, Int) {
    let tString = String(n, radix: 2)
    let ones = tString.characters.filter({
        (c: Character) -> Bool in
        c == "1" ? true : false
    })
    
    return (tString, ones.count)
}

hammingWeight(35) // returns ("100011", 3)

func hammingRecursive(number: Int) -> (String, Int) {
    func helper(n: Int, str: String, cnt: Int) -> (Int, String, Int) {
        if n == 0 {
            return (n, str, cnt)
        }
        return helper(n / 2, str: String(n % 2) + str, cnt: cnt + n % 2)
    }
    let (_, hammingStr, hammingCnt) = helper(number, str: "", cnt: 0)
    return (hammingStr, hammingCnt)
}
hammingRecursive(35) // returns ("100011", 3)
