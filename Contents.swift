
func plusOne(_ digits: [Int]) -> [Int] {
    var digits = digits
    var carrier = 0
    for i in stride(from: digits.count - 1, to: -1, by: -1) {
        if digits[i] == 9 {
            digits[i] = 0
            carrier = 1
        } else {
            digits[i] += 1
            carrier = 0
            break
        }
    }
    if carrier == 1 {
        digits.insert(1, at: 0)
    }
    return digits
}
//print(plusOne([9,9,8]))
func addBinary(_ a: String, _ b: String) -> String{
    var ans = ""
    var carrier = 0
    var a = a.utf8CString.dropLast() as [Int8]
    var b = b.utf8CString.dropLast() as [Int8]
    a = a.reversed()
    b = b.reversed()
    if a.count < b.count {
        swap(&a, &b)
    }
    if a.count > b.count {
        for _ in 0...a.count - b.count - 1 {
            b.append(Int8(48))
        }
    }
    var res = Array(repeating: 0, count: a.count)
    for i in 0...a.count - 1 {
        if a[i] == Int8(48) && b[i] == Int8(48) {
            res[i] += carrier
            carrier = 0
        } else if a[i] == Int8(49) && b[i] == Int8(49) {
            res[i] += carrier
            carrier = 1
        } else {
            if carrier == 0 { res[i] = 1 } else {
                res[i] = 0
                carrier = 1
            }
        }
    }
    if carrier == 1 {
        res.append(1)
    }
    res = res.reversed()
    for i in res {
        ans += String(i)
    }
    return ans
}

//print(addBinary("111", "111110"))

func fullJustify(_ words: [String], _ maxWidth: Int) -> [String] {
    var ans = [String]()
    var copy = words
    var nowLength = 0
    var appendedWordsCount = 0
    var toMakeStrings = [String]()
    for i in 0...words.count - 1 {
        let lengthOfSingleWord = words[i].count
        if nowLength + lengthOfSingleWord + appendedWordsCount <= maxWidth {
            nowLength += lengthOfSingleWord
            appendedWordsCount += 1
            toMakeStrings.append(words[i])
            copy.removeFirst()
        } else {
            //TODO:开始插入空格 //e.g. ["this","is","an"]
            var string = ""
            let blankSpaceCount = maxWidth - nowLength
            if toMakeStrings.count == 1 {
                string += toMakeStrings[0] + String(repeating: " ", count: blankSpaceCount)
            } else {
                let frontCount = blankSpaceCount % (toMakeStrings.count - 1)
                let frontWordBlankCount: Int = frontCount == 0 ? blankSpaceCount / (toMakeStrings.count - 1) : blankSpaceCount / (toMakeStrings.count - 1) + 1
                for (index,str) in toMakeStrings.enumerated() {
                    if frontCount != 0 {
                        if index != toMakeStrings.count - 1 && index < frontCount {
                            string += str + String(repeating: " ", count: frontWordBlankCount)
                        } else if index != toMakeStrings.count - 1 && index >= frontCount{
                            string += str + String(repeating: " ", count: frontWordBlankCount - 1)
                        } else {
                            string += str
                        }
                    } else if frontCount == 0 {
                        if index != toMakeStrings.count - 1 {
                            string += str + String(repeating: " ", count: frontWordBlankCount)
                        } else {
                            string += str
                        }
                    }
                }
            }
            ans.append(string)
            toMakeStrings = [words[i]]
            nowLength = words[i].count
            appendedWordsCount = 1
        }
    }
    //TODO: 剩余的最后一行就是tomakestring
    var string = ""
    for (index, str) in toMakeStrings.enumerated() {
        if index == toMakeStrings.count - 1 {
            string += str
        } else {
            string += str + " "
        }
    }
    if string.count != maxWidth {
        for _ in 0...maxWidth - string.count - 1 {
            string += " "
        }
    }
    ans.append(string)
    return ans
}

//print(fullJustify(["What","must","be","acknowledgment","shall","be"], 16))

//70
func climbStairs(_ n: Int) -> Int {
    var arr: [Int] = Array(repeating: 0, count: n)
    if n == 1 { return 1 }
    if n == 2 { return 2 }
    arr[0] = 1
    arr[1] = 2
    for i in 2...n - 1 {
        arr[i] = arr[i - 1] + arr[i - 2]
    }
    return arr[arr.count - 1]
}
//print(climbStairs(40))

func simplifyPath(_ path: String) -> String {
    let components = path.split(separator: "/")
    print(components)
    var res = [String]()
    for s in components {
        if s == "." {
            continue
        } else if s == ".." {
            if !res.isEmpty {
                res.removeLast()
            }
        } else {
            res.append(String(s))
        }
    }
    return "/" + res.joined(separator: "/")
}

//print(simplifyPath("/a//b////c/d//././/.."))

func setZeroes(_ matrix: inout [[Int]]) {
    let copy = matrix
    var zeroedRows = [Int]()
    var zeroedColumns = [Int]()
    for i in 0...matrix.count - 1 {
        for j in 0...matrix[0].count - 1 {
            if copy[i][j] == 0 {
                if zeroedRows.contains(i) && !zeroedColumns.contains(j){
                    zeroedColumns.append(j)
                    for index in 0...matrix.count - 1 {
                        matrix[index][j] = 0
                    }
                } else if zeroedColumns.contains(j) && !zeroedRows.contains(i) {
                    zeroedRows.append(i)
                    for index in 0...matrix[0].count - 1 {
                        matrix[i][index] = 0
                    }
                } else if !zeroedRows.contains(i) && !zeroedColumns.contains(j){
                    zeroedRows.append(i)
                    zeroedColumns.append(j)
                    for indexOfColumn in 0...matrix[0].count - 1 {
                        matrix[i][indexOfColumn] = 0
                    }
                    for indexOfRow in 0...matrix.count - 1 {
                        matrix[indexOfRow][j] = 0
                    }
                }
            } else {
                continue
            }
        }
    }
}
//var test = [[0,1,2,0],[3,4,5,2],[1,3,1,5]]
//setZeroes(&test)
//print(test)
func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
    guard matrix.count > 0 else {
        return false
    }
    var rowToSearch = 0
    for i in 0...matrix.count - 1 {
        if target > matrix[i][0] {
            rowToSearch = i
            continue
        } else if target < matrix[i][0] {
            rowToSearch = i - 1
            break
        } else {
            return true
        }
    }
    guard rowToSearch >= 0 else { return false }
    print(rowToSearch)
    if target > matrix[rowToSearch].last! {
        return false
    }
    //二分法查找
    var low = 0
    var high = matrix[0].count - 1
    var mid: Int = (low + high) / 2
    let row = matrix[rowToSearch]
    while mid != low{
        mid = (low + high) / 2
        if row[mid] > target {
            high = mid
        } else if row[mid] < target {
            low = mid + 1
        } else {
            return true
        }
    }
    if target == row[high] {
        return true
    }
    return false
}
//print(searchMatrix([[1,3,5,7],[10,11,16,20],[23,30,34,50]],
//    30))


func sortColors(_ nums: inout [Int]) {
    var digit2Count = [0 : 0, 1 : 0, 2 : 0]
    if nums.count == 0 { return }
    for d in nums {
        digit2Count[d]! += 1
    }
    nums.removeAll()
    for i in 0...2 {
        for _ in 0..<digit2Count[i]! {
            nums.append(i)
        }
    }
}
func sortColors2(_ nums: inout [Int]) {
    var mostRight = 0
    var mostLeft = nums.count - 1
    var current = 0
    while current <= mostLeft {
        if nums[current] == 0 {
            nums.swapAt(current, mostRight)
            current += 1
            mostRight += 1
        } else if nums[current] == 2 {
            nums.swapAt(current, mostLeft)
            mostLeft -= 1
        } else {
            current += 1
        }
    }
}
//var test = [2,0,2,1,1,0]
//sortColors2(&test)

//滑动窗口
func minWindow(_ s: String, _ t: String) -> String {
    if s == "" || t == "" || s.count < t.count{ return "" }
    var left = 0
    var right = 0
    var dictForT = [Character: Int]()
    let charactersOfT = [Character](t)
    for char in charactersOfT {
        if dictForT[char] != nil {
            dictForT[char]! += 1
        } else {
            dictForT[char] = 1
        }
    }
    var candidates = [(Int, Int)]()
    var correctWindow: (Int, Int) = (0, 0)
    var dictForS = [Character: Int]()
    let charactersOfS = [Character](s)
    while right <= s.count - 1 {
        if dictForS[charactersOfS[right]] != nil {
            dictForS[charactersOfS[right]]! += 1
        } else {
            dictForS[charactersOfS[right]] = 1
        }
        //判断截止当前Window是否包含所有
        if isIncluded(dictForS: dictForS, dictForT: dictForT) {
            //开始收缩窗口
            candidates.append((left, right))
            if dictForT == dictForS {
                return (charactersOfS[left...right]).map{String($0)}.joined()
            }
            while true {
                dictForS[charactersOfS[left]]! -= 1
                if isIncluded(dictForS: dictForS, dictForT: dictForT) {
                    left += 1
                    correctWindow = (left,right)//TODO: correctWindow.1=?
                    candidates.append(correctWindow)
                } else {
                    dictForS[charactersOfS[left]]! += 1
                    break
                }
            }
        }
        right += 1
    }
    candidates = candidates.sorted(by: {($0.1 - $0.0) < ($1.1 - $1.0)})
    print(candidates)
    correctWindow = candidates.first ?? (0,0)
    print(correctWindow)
    let toAdd = [Character](charactersOfS[correctWindow.0...correctWindow.1])
    return correctWindow == (0, 0) ? "" : (toAdd.map { String($0) }).joined()
}

func isIncluded(dictForS: [Character: Int], dictForT: [Character: Int]) -> Bool {
    var counter = 0
    for (key, value) in dictForT {
        if dictForS[key] != nil {
            if dictForS[key]! < value {
                break
            } else {
                counter += 1
            }
        } else {
            break
        }
    }
    return counter == dictForT.count
}

//print(minWindow("sadasdsa","abc"))
class Solution {
    //initialize two pointers- left and right and initialize both to the first element of string s.
    //In any sliding window problem, we have two pointers. One right pointer whose job is to expand the current
    //window and the left pointer whose hob is to contract the given window. At any point, only one of those pointers
    //move and the other stay fixed.
    
    func minWindow(_ s: String, _ t: String) -> String {
        //convert the strings to character array
        //the map is necessary to convert uint8 to Int
        let schars = Array(s.utf8).map {Int($0)}
        let tchars = Array(t.utf8).map {Int($0)}
        
        
        //create hashmap
        var hash = Array(repeating: 0, count: 128)
        
        for tchar in tchars {
            hash[tchar] += 1
        }
        
        var count = tchars.count
        var start = 0
        var left = 0
        var right = 0
        var length = Int.max
        
        //We use the right pointer to expand the window until we get a desirable window i.e. a window that contains all of the characters of
        // t
        while right < schars.count {
            //if this character from schars is present in hash (i.e. in tchars), decrement count and also the count for that char in the hash by 1.
            if hash[schars[right]] > 0 {
                count -= 1
            }
            hash[schars[right]] -= 1
            right += 1
            
            while count == 0 {
                if right - left < length {
                    //keep updating the length value
                    length = right - left
                    start = left
                }
                //Once we have a window with all the characters, we can move the left pointer ahead one by one. If the window is still a desirable one we keep //updating the minimum window size.
                if hash[schars[left]] == 0 {
                    count += 1
                }
                hash[schars[left]] += 1
                left += 1
            }
        }
        
        //not present
        if length > schars.count {
            return ""
        }
        
        let index1 = s.index(s.startIndex, offsetBy: start)
        let index2 = s.index(s.startIndex, offsetBy: start + length)
        
        return String(s[index1..<index2])
    }
}
func backtrack(n: Int, k: Int, res: inout [[Int]], tmp: inout [Int], start: Int) {
    if tmp.count == k && start - 1 <= n {
        res.append(tmp)
        return
    } else if start > n {
        return
    }
    for i in start...n {
        tmp.append(i)
        backtrack(n: n, k: k, res: &res, tmp: &tmp, start: i + 1)
        tmp.removeLast()
    }
}

func combine(_ n: Int, _ k: Int) -> [[Int]] {
    guard k <= n else {
        return [[Int]]()
    }
    var res = [[Int]]()
    var tmp = [Int]()
    backtrack(n: n, k: k, res: &res, tmp: &tmp, start: 1)
    return res
}
//print(combine(4, 3))

func backtrack2(nums: [Int], n: Int, k: Int, res: inout [[Int]], tmp: inout [Int], start: Int) {
    if tmp.count == k {
        res.append(tmp)
        return
    }
    for i in start..<n {
        tmp.append(nums[i])
        backtrack2(nums: nums, n: n, k: k, res: &res, tmp: &tmp, start: i + 1)
        tmp.removeLast()
    }
}

func subsets(_ nums: [Int]) -> [[Int]] {
    let nums = nums.sorted()
    var res = [[Int]]()
    res.append([Int]())
    for i in 1...nums.count {
        var tmp = [Int]()
        backtrack2(nums: nums, n: nums.count, k: i, res: &res, tmp: &tmp, start: 0)
    }
    var addedDict = [[Int] : Bool]()
    return res.filter {
        addedDict.updateValue(true, forKey: $0) == nil
    }
}

//print(subsets([1,2,3]))
class Solution2 {
    
    func searchSolution(_ board: inout [[Character]],
                        _ letter: inout [Character],
                        _ visited: inout [[Bool]],
                        _ x: Int,
                        _ y: Int,
                        _ index: Int) -> Bool {
        
        if board[x][y] == letter[index] {
            
            visited[x][y] = true
            
            if (index + 1) >= letter.count {
                return true
            }
            
            if x > 0 {
                if visited[x-1][y] == false && searchSolution(&board, &letter, &visited, x - 1, y, index + 1) {
                    return true
                }
            }
            if x < (board.count - 1) {
                if visited[x+1][y] == false && searchSolution(&board, &letter, &visited, x + 1, y, index + 1) {
                    return true
                }
            }
            if y > 0 {
                if visited[x][y-1] == false && searchSolution(&board, &letter, &visited, x, y - 1, index + 1) {
                    return true
                }
            }
            if y < (board[0].count - 1) {
                if visited[x][y+1] == false && searchSolution(&board, &letter, &visited, x, y + 1, index + 1) {
                    return true
                }
            }
            
            visited[x][y] = false
            
        }
        
        return false
    }
    
    func exist(_ board: [[Character]], _ word: String) -> Bool {
        
        var letters = Array(word)
        var board = board
        
        if board.count <= 0 { return false }
        if board[0].count <= 0 { return false }
        
        var visited = [[Bool]](repeating: [Bool](repeating: false, count: board[0].count), count: board.count)
        
        for x in 0..<board.count {
            for y in 0..<board[0].count {
                
                if searchSolution(&board, &letters, &visited, x, y, 0) {
                    return true
                }
            }
        }
        
        return false
    }
}

func removeDuplicates(_ nums: inout [Int]) -> Int {
    if nums.count <= 2 { return nums.count }
    var current = 2
    while current <= nums.count - 1 {
        if nums[current] == nums[current - 1] && nums[current] == nums[current - 2] {
            nums.remove(at: current)
        } else {
            current += 1
        }
    }
    return current
}
var arr = [1,1,1,2,2,2,2,2,2,2,3]
//print(removeDuplicates(&arr))

func search(_ nums: [Int], _ target: Int) -> Bool {
    if nums.count == 0 { return false }
    if nums.count == 1 { return target == nums[0] }
    var low = 0
    var high = nums.count - 1
    while low <= high {
        let mid: Int = (low + high) / 2
        if nums[mid] == target { return true }
        if nums[low] == nums[mid] && nums[mid] == nums[high] {
            low += 1
            high -= 1
        } else if nums[low] <= nums[mid] {
            if nums[low] <= target && target < nums[mid] {
                high = mid - 1
            } else {
                low = mid + 1
            }
        } else {
            if nums[mid] < target && target <= nums[high] {
                low = mid + 1
            } else {
                high = mid - 1
            }
        }
    }
    return false
}
class ListNode {
    var val: Int
    var next: ListNode?
    init(_ val: Int) {
        self.val = val
    }
}

func deleteDuplicates(_ head: ListNode?) -> ListNode? {
    guard head != nil else { return nil }
    if head?.next == nil { return head }
    let dummyHead = ListNode(Int.max)
    dummyHead.next = head
    var first: ListNode? = dummyHead
    var second = first?.next
    var current = head?.next
    var neetToDelete = false
    while current != nil {
        if current?.val != second?.val {
            if neetToDelete {
                first?.next = current
            } else {
                first = second
            }
            second = current
            current = current?.next
            neetToDelete = false
            continue
        }
        else {
            current = current?.next
            neetToDelete = true
            continue
        }
    }
    if neetToDelete {
        first?.next = nil
    }
    return dummyHead.next
}

func makeNode(_ nums: [Int]) -> ListNode? {
    var ans: ListNode? = ListNode(Int.max)
    let res = ans
    for i in nums {
        ans?.next = ListNode(i)
        ans = ans?.next
    }
    return res?.next
}

//var node = makeNode([1,1,1,2,3,4,4,4,5,5])
//var ans = deleteDuplicates(node)
//while ans != nil {
//    print(ans?.val)
//    ans = ans?.next
//}

func calculateArea(nums: [Int], start: Int, end: Int) -> Int {
    if start > end { return 0 }
    var minIndex = start
    for i in start...end {
        if nums[minIndex] > nums[i] {
            minIndex = i
        }
    }
    return max(nums[minIndex] * (end - start + 1), max(calculateArea(nums: nums, start: start, end: minIndex - 1), calculateArea(nums: nums, start: minIndex + 1, end: end)))
}

func largestRectangleArea(_ heights: [Int]) -> Int {
    return calculateArea(nums: heights, start: 0, end: heights.count - 1)
}


func partition(_ head: ListNode?, _ x: Int) -> ListNode? {
    if head == nil { return head }
    var current = head
    var small: ListNode? = ListNode(0)
    let headOfSmall = small
    var big: ListNode? = ListNode(0)
    let headOfBig = big
    while current != nil {
        if current!.val < x {
            small?.next = ListNode(current!.val)
            small = small?.next
        } else {
            big?.next = ListNode(current!.val)
            big = big?.next
        }
        current = current?.next
    }
    small?.next = headOfBig?.next
    return headOfSmall?.next
}
//var ans = partition(makeNode([12,2,312,12312,12,1]), 100)
//while ans != nil {
//    print(ans!.val)
//    ans = ans?.next
//}

func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
    let countOfNums1 = nums1.count
    let countToDelete = countOfNums1 - m
    for _ in 0..<countToDelete {
        nums1.removeLast()
    }
    nums1 += nums2
    nums1.sort()
}

//var arr2 = [1]
//merge(&arr2, 1, [], 0)
//print(arr2)

func grayCode(_ n: Int) -> [Int] {
    var gray = [Int]()
    gray.append(0)
    for i in 0..<n {
        let add = 1 << i
        for j in stride(from: gray.count - 1, to: -1, by: -1) {
            gray.append(gray[j] + add)
        }
    }
    return gray
}

//print(grayCode(2))
//print(subsets([1,2,2]))

func insertNode(head: ListNode?, newHead: ListNode) -> ListNode {
    newHead.next = head
    return newHead
}

func reverseBetween(_ head: ListNode?, _ m: Int, _ n: Int) -> ListNode? {
    if head == nil || m == n { return head }
    let referedHead: ListNode? = ListNode(-1)
    referedHead?.next = head
    var currentNode = referedHead
    var headOfReverse: ListNode?
    var index = 0
    var begin: ListNode?
    while index != m - 1 {
        currentNode = currentNode?.next
        index += 1
    }
    begin = currentNode
    currentNode = currentNode?.next
    index += 1
    while index <= n  {
        headOfReverse = insertNode(head: headOfReverse, newHead: ListNode(currentNode!.val))
        
        currentNode = currentNode?.next
        index += 1
    }
    begin?.next = headOfReverse
    while headOfReverse?.next != nil {
        headOfReverse = headOfReverse?.next
    }
    headOfReverse?.next = currentNode
    return referedHead?.next
}

//let node3 = makeNode([5,2])
//var node4 = reverseBetween(node3, 1, 2)
//while node4 != nil {
//    print(node4!.val)
//    node4 = node4?.next
//}

//netease
func score(nums: [Int]) -> Int {
    var arr = [0,0,0]
    var score = 0
    for  num in nums {
        arr[num - 1] += 1
    }
    while arr[0] != 0 && arr[1] != 0 && arr[2] != 0 {
        score += 1
        arr[0] -= 1
        arr[1] -= 1
        arr[2] -= 1
    }
    return score
}
//print(score(nums: [1,1,2,2,2,3,1,2,3,3]))

func doze(n: Int, k: Int, scores: [Int], alive: [Int]) -> Int {
    var res = 0
    var sleep = [Int]()
    for (index,num) in alive.enumerated() {
        if num == 0 {
            sleep.append(index)
        }
    }
    for sleepTime in sleep {
        var index = 0
        var singleScore = 0
        while index < sleepTime {
            if alive[index] == 1 {
                singleScore += scores[index]
            }
            index += 1
        }
        for i in index..<index + k {
            if i >= n {
                break
            }
            singleScore += scores[index]
            index += 1
        }
        while index < n {
            if alive[index] == 1 {
                singleScore += scores[index]
            }
            index += 1
        }
        res = max(res, singleScore)
    }
    return res
}
//print(doze(n: 20, k: 3, scores: [7671,1710,3898,2147,7451,7607,7069,8984,5614,1284,7274,4168,4317, 5432, 523 ,1117 ,5245, 3378, 8196, 368], alive: [0, 1, 0, 0, 0 ,1 ,1 ,1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 0, 1, 0
//]))

func insertSort(arr: inout [Int]) {
    for i in 1..<arr.count {
        if arr[i] < arr[i - 1] {
            let tmp = arr[i]
            var j = i - 1
            while j>=0 && arr[j] > tmp {
                arr[j + 1] = arr[j]
                j -= 1
            }
            arr[j + 1] = tmp
        }
    }
}

var arr111 = [3,2,4,5,1,7,6]
//insertSort(arr: &arr111)
//print(arr111)

func shellSort(arr: inout [Int]) {
    if arr.count == 0 || arr.count == 1 { return }
    var step = arr.count / 2
    while step >= 1 {
        for i in stride(from: step, to: arr.count, by: step) {
            if arr[i] < arr[i - step] {
                let tmp = arr[i]
                var j = i - step
                while j >= 0 && arr[j] > tmp {
                    arr[j + step] = arr[j]
                    j -= step
                }
                arr[j + step] = tmp
            }
        }
        step /= 2
    }
}
//shellSort(arr: &arr111)
//print(arr111)

func selectSort(arr: inout [Int]) {
    for i in 0..<arr.count - 1 {
        var minIndex = i
        for j in i + 1..<arr.count {
            if arr[j] < arr[minIndex] {
                minIndex = j
            }
        }
        if i != minIndex {
            let tmp = arr[i]
            arr[i] = arr[minIndex]
            arr[minIndex] = tmp
        }
    }
}
//selectSort(arr: &arr111)
//print(arr111)

func adjustHeap(arr: inout [Int], i: Int, count: Int) {
    var i = i
    let tmp = arr[i]
    var k = 2 * i + 1
    while k < count {
        if k + 1 < count && arr[k] < arr[k + 1] {
            k += 1
        }
        if arr[k] > tmp {
            arr.swapAt(i, k)//这里也可以不用交换，而是写成arr[i] = arr[k],再在while循环外面补充一句arr[i] = tmp
            i = k
        } else {
            break
        }
        k = k * 2 + 1
    }
}
func heapSort(arr: inout [Int]) {
    for i in (0...(arr.count / 2) - 1).reversed() {
        adjustHeap(arr: &arr, i: i, count: arr.count)
    }
    for j in (1...arr.count - 1).reversed() {
        arr.swapAt(0, j)
        adjustHeap(arr: &arr, i: 0, count: j)
    }
}

//heapSort(arr: &arr111)
//print(arr111)

func makeIncrementer(forIncrement amout: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amout
        return runningTotal
    }
    return incrementer
}

//let incrementByTen = makeIncrementer(forIncrement: 10)
//print(incrementByTen())
//print(incrementByTen())
//let refOfPlusTen = incrementByTen
//print(refOfPlusTen())

func bubbleSort(arr: inout [Int]) {
    for i in 0...arr.count - 1 {
        for j in 0..<arr.count - i - 1{
            if arr[j] > arr[j + 1] {
                arr.swapAt(j, j + 1)
            }
        }
    }
}
//bubbleSort(arr: &arr111)
//print(arr111)
func quickSort(arr: inout [Int], start: Int, end: Int) {
    if start > end {
        return
    }
    var i = start
    var j = end
    let key = arr[i]
    while i < j {
        while i < j && arr[j] >= key {
            j -= 1
        }
        arr[i] = arr[j]
        while i < j && arr[j] <= key {
            i += 1
        }
        arr[j] = arr[i]
    }
    arr[i] = key
    quickSort(arr: &arr, start: start, end: i - 1)
    quickSort(arr: &arr, start: i + 1, end: end)
}
//quickSort(arr: &arr111, start: 0, end: arr111.count - 1)
//print(arr111)
func merge(leftPile: [Int], rightPile: [Int]) -> [Int] {
    // 1
    var leftIndex = 0
    var rightIndex = 0
    
    // 2
    var orderedPile = [Int]()
    orderedPile.reserveCapacity(leftPile.count + rightPile.count)
    
    // 3
    while leftIndex < leftPile.count && rightIndex < rightPile.count {
        if leftPile[leftIndex] < rightPile[rightIndex] {
            orderedPile.append(leftPile[leftIndex])
            leftIndex += 1
        } else if leftPile[leftIndex] > rightPile[rightIndex] {
            orderedPile.append(rightPile[rightIndex])
            rightIndex += 1
        } else {
            orderedPile.append(leftPile[leftIndex])
            leftIndex += 1
            orderedPile.append(rightPile[rightIndex])
            rightIndex += 1
        }
    }
    
    // 4
    while leftIndex < leftPile.count {
        orderedPile.append(leftPile[leftIndex])
        leftIndex += 1
    }
    
    while rightIndex < rightPile.count {
        orderedPile.append(rightPile[rightIndex])
        rightIndex += 1
    }
    
    return orderedPile
}

func mergeSort(_ arr: [Int]) -> [Int] {
    guard arr.count > 1 else { return arr }
    let middleIndex = arr.count / 2
    let leftArray = mergeSort(Array(arr[0..<middleIndex]))
    let rightArray = mergeSort(Array(arr[middleIndex..<arr.count]))
    return merge(leftPile: leftArray, rightPile: rightArray)
}
import Foundation
let queue2 = DispatchQueue(label: "concurrent", qos: .default, attributes: .concurrent, autoreleaseFrequency: .never, target: nil)
//print(1)
//queue2.async {
//    quickSort(arr: &arr111, start: 0, end: arr111.count - 1)
//    print(2)
//}
//print(3)
//queue2.sync {
//    print(4)
//}

/*
var arr3 = [Int]()
for i in 0..<10 {
    queue2.sync {
        arr3.append(i)
    }
}
queue2.sync {
    print("--------")
}
for i in 10..<20 {
    queue2.sync {
        arr3.append(i)
    }
}
 */

//queue2.sync {
//    print(arr3)
//}
//let delayQueue = DispatchQueue(label: "delay", qos: .userInitiated)
//print(Date())
//delayQueue.asyncAfter(deadline: .now() + 3) {
//    print(Date())
//}
func workItemTest() {
    var num = 9
    let workItem = DispatchWorkItem{
        num += 5
    }
    workItem.perform()
    let queue = DispatchQueue.global(qos: .utility)
    queue.async(execute: workItem)
    workItem.notify(queue: DispatchQueue.main) {
//        print("workItem完成后的通知")
    }
}
workItemTest()
let semaphore = DispatchSemaphore(value: 1)
var count = 0
func asyncTask() {
    semaphore.wait(timeout: .distantFuture)//会将j信号量-1
    count += 1
    sleep(1)
    print("执行任务\(count)")
    semaphore.signal()//会将信号量+1
}
//for _ in 0...100 {
//    DispatchQueue.global().async {
//        asyncTask()//当信号量<0时需等待，于是完成了锁操作
//    }
//}

var ticketsCount = 50
let lock = NSLock()
let queue0 = OperationQueue()
let queue1 = OperationQueue()

queue0.maxConcurrentOperationCount = 1
queue1.maxConcurrentOperationCount = 1
func op() {
    while true {
        if ticketsCount > 0 {
            lock.lock()
            ticketsCount -= 1
            print("剩余票数\(ticketsCount)")
            lock.unlock()
            sleep(1)
        }
        lock.unlock()
        if ticketsCount <= 0 {
            print("sell out")
            break
        }
    }
}
let operation1 = BlockOperation(block: op)
let operation2 = BlockOperation(block: op)
//queue0.addOperation(operation1)
//queue1.addOperation(operation2)


func reverseString(_ str: String) -> String  {
    var s = [Character](str)
    for i in 0..<str.count / 2 {
        s.swapAt(i, str.count - i - 1)
    }
    return (s.map{String($0)}).joined()
}
//print(reverseString("hello"))

func reverseList(head: ListNode?) -> ListNode? {
    if head == nil || head?.next == nil { return head}
    let newHead = reverseList(head: head?.next)
    head?.next?.next = head
    head?.next = nil
    return newHead
}//递归函数栈！
var head = reverseList(head: makeNode([1,2,3,4,5,6]))
//while head != nil {
//    print(head!.val)
//    head = head?.next
//}

func recurseString(_ str: String) -> String {
    if str.count <= 1 { return str }
    return recurseString(String(str.suffix(str.count - 1))) + String(str.first!)
}

//print(recurseString("hello"))

func lengthOfLongestSubstring(_ s: String) -> Int {
    if s.count == 0 { return 0 }
    let s = [Character](s)
    var maxLength = 1
    var i = 0
    var j = 0
    var map = [Character]()
    while i < s.count - maxLength && j < s.count {
        if map.contains(s[j]){
            while map.contains(s[j]) {
                map.removeFirst()
                i += 1
            }
        } else {
            map.append(s[j])
            j += 1
            maxLength = max(maxLength, j - i)
        }
    }
    return maxLength
}

//print(lengthOfLongestSubstring("pwwkew"))

func decodeString(_ s: String) -> String {
    var res = [Character]()
    for char in s {
        if char == "]" {
            var chars = [Character]()
            var nums = [Int]()
            while res[res.count - 1] != "[" {
                chars.append(res.removeLast())
            }
            res.removeLast()
            chars = chars.reversed()
            while res.count != 0 {
                if let number = Int(String(res[res.count - 1])) {
                    nums.append(number)
                    res.removeLast()
                } else {
                    break
                }
            }
            var count = 0
            for i in nums.reversed() {
                count = count * 10 + i
            }
            for _ in 0..<count {
                res += chars
            }
        } else {
            res.append(char)
        }
    }
    return (res.map{String($0)}).joined()
}
print(decodeString("3[a2[c]]"))

func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var dict = [Int: Int]()
    for i in 0..<nums.count {
        if let index = dict[target - nums[i]] {
            return [index, i]
        }
        dict[nums[i]] = i
    }
    return []
}


