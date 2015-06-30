func makePascalTriangle(numOfRows: Int) -> ([[Int]]) {
    /*
     * getNextRow([1,2,1]) returns
     *
     *   [0, 1, 2, 1]
     * + [1, 2, 1, 0]
     * --------------
     *   [1, 3, 3, 1]
     */
    func getNextRow(arr: [Int]) -> [Int] {
        let a = Zip2([0]+arr, arr+[0])
        return a.map({
            (e: (Int, Int)) -> Int in
            e.0 + e.1
        })
    }
    
    func helper(countDown: Int, results: [[Int]]) -> (Int, [[Int]]) {
        if countDown == 0 {
            return (countDown, results)
        }
        let row = getNextRow(results.last!)
        return helper(countDown - 1, results: results + [row])
    }
    
    let initialPascal = [1]
    let (_, pascals) = helper(numOfRows, results: [initialPascal])
    return pascals
}

makePascalTriangle(10)
//    returns
//  [
//    [1],
//    [1, 1],
//    [1, 2, 1],
//    [1, 3, 3, 1],
//    [1, 4, 6, 4, 1],
//    [1, 5, 10, 10, 5, 1],
//    [1, 6, 15, 20, 15, 6, 1],
//    [1, 7, 21, 35, 35, 21, 7, 1],
//    [1, 8, 28, 56, 70, 56, 28, 8, 1],
//    [1, 9, 36, 84, 126, 126, 84, 36, 9, 1],
//    [1, 10, 45, 120, 210, 252, 210, 120, 45, 10, 1]
//  ]


