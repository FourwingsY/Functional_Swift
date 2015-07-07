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

    // (["hit", "hot", "dot"], Set(["log", "cog", "dog", "lot"]))
    // -> [(["hit", "hot", "dot", "dog"], Set(["log", "cog", "lot"])),
    //     (["hit", "hot", "dot", "lot"], Set(["log", "cog", "dog"]))]
    func step(ladder: [String], wordDic: Set<String>) -> [([String], Set<String>)] {
        let lastWord = ladder.last!
        let ladders = wordDic.filter({
            (word: String) -> Bool in
            // get words of simmilar to lastWord but not in ladder
            isSimmilarWord(lastWord, and:word) && !ladder.contains(word)
        }).map({
            (word) -> ([String], Set<String>) in
            return (ladder + [word], wordDic.subtract([word]))
        })
        return ladders
    }
    
    /* for each time 'helper' function runs,
        [(["hit", "hot"], Set(["log", "cog", "dog", "dot", "lot"]))]
    
        [(["hit", "hot", "dot"], Set(["log", "cog", "dog", "lot"])), 
         (["hit", "hot", "lot"], Set(["log", "cog", "dog", "dot"]))]
    
        [(["hit", "hot", "dot", "dog"], Set(["log", "cog", "lot"])),
         (["hit", "hot", "dot", "lot"], Set(["log", "cog", "dog"])), 
         (["hit", "hot", "lot", "log"], Set(["cog", "dog", "dot"])), 
         (["hit", "hot", "lot", "dot"], Set(["log", "cog", "dog"]))]
    
        [(["hit", "hot", "dot", "dog", "log"], Set(["cog", "lot"])), 
         (["hit", "hot", "dot", "dog", "cog"], Set(["log", "lot"])), 
         (["hit", "hot", "dot", "lot", "log"], Set(["cog", "dog"])), 
         (["hit", "hot", "lot", "log", "cog"], Set(["dog", "dot"])), 
         (["hit", "hot", "lot", "log", "dog"], Set(["cog", "dot"])), 
         (["hit", "hot", "lot", "dot", "dog"], Set(["log", "cog"]))]
    */
    func helper(ladders: [([String], Set<String>)]) -> [([String], Set<String>)] {
        let next = ladders.map({
            (ladder) -> [([String], Set<String>)] in
            step(ladder.0, wordDic: ladder.1)
        }).reduce([], combine: +)
        if next.count == 0 {
            // Failed
            return [([],Set<String>())]
        }
        let possibleAnswer = next.filter({
            (ladder: ([String], Set<String>)) -> Bool in
            ladder.0.last == endWord
        })
        if possibleAnswer.count > 0 {
            // found answer
            return possibleAnswer
        }
        return helper(next)
    }
    
    let initialLadder = ([beginWord], dict)
    let result = helper([initialLadder])
    if result.count > 0 {
        return result[0].0
    }
    return []
}

let wordDictionary = Set(["hot","dot","dog","lot","log"])
wordLadder("hit", endWord: "cog", wordDic: wordDictionary)