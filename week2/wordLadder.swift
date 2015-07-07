func wordLadder(beginWord: String, endWord: String, wordDic: Set<String>) -> [String] {
    let dict = wordDic.union([endWord])
    
    func isSimmilarWord(word: String, and another: String) -> Bool {
        let zipped = Zip2(word.characters, another.characters)
        let differentLength = zipped.filter({
            (w1, w2) -> Bool in
            w1 != w2
        }).count
        return differentLength == 1
    }

    // [hit, hot, dot] -> [[hit, hot, dot, dog], [hit, hot, dot, lot]]
    func step(ladder: [String], wordDic: Set<String>) -> [[String]] {
        let lastWord = ladder.last!
        let ladders = wordDic.filter({
            (word) -> Bool in
            // get words of simmilar to lastWord but not in ladder
            isSimmilarWord(lastWord, and:word) && !ladder.contains(word)
        }).map({
            (word) -> [String] in
            return ladder + [word]
        })
        return ladders
    }
    
    /* for each time 'helper' function runs,
        [[hit]]
        [[hit, hot]]
        [[hit, hot, dot],
         [hit, hot, lot]]
        [[hit, hot, dot, dog],
         [hit, hot, dot, lot],
         [hit, hot, lot, log],
         [hit, hot, lot, dot]]
        [[hit, hot, dot, dog, log],
         [hit, hot, dot, dog, cog],
         [hit, hot, dot, lot, log],
         [hit, hot, lot, log, cog],
         [hit, hot, lot, log, dog],
         [hit, hot, lot, dot, dog]]
    */
    func helper(ladders: [[String]]) -> [[String]] {
        let next = ladders.map({
            (ladder: [String]) -> [[String]] in
            step(ladder, wordDic: dict)
        }).reduce([], combine: +)
        if next.count == 0 {
            // Failed
            return [[]]
        }
        let possibleAnswer = next.filter({
            (ladder: [String]) -> Bool in
            ladder.last == endWord
        })
        if possibleAnswer.count > 0 {
            // found answer
            return possibleAnswer
        }
        return helper(next)
    }
    
    let initialLadder = [beginWord]
    let result = helper([initialLadder])
    if result.count > 0 {
        return result[0]
    }
    return []
}

let wordDictionary = Set(["hot","dot","dog","lot","log"])
wordLadder("hit", endWord: "cog", wordDic: wordDictionary)