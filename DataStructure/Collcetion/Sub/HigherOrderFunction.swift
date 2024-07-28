//
//  HigherOrderFunction.swift
//  Algorithms
//
//  Created by 유성열 on 7/26/24.
//
// MARK: - Collection 공통 메서드(고차함수)
// Swift의 컬렉션 전체는 'Sequence' 및 'Collection' 프로토콜을 따르며 이로 인해 다양한 메서드를 제공받음
// MARK: 컬렉션 타입에서 많이 사용되는 고차함수(map, filter, reduce, forEach, compactMap)(Sequence, Collection 프로토콜을 따르는 컬렉션에 기본적으로 구현되어있음-옵셔널타입 포함)
// 고차함수는 '함수'를 파라미터로 사용하거나, 함수 실행의 결과를 '함수'로 반환하는 함수(일급객체의 조건)
// MARK: 고차함수는 (체이닝)조합하여 사용 가능( ex: filter { $0 % 2 == 0 }.map { $0 * $0 }.reduce(0) { $0 + $1 } ..
// MARK: 고차함수는 rethrows 작동방식이 있음. 고차함수는 내부적으로 rethrows 키워드를 사용하여 변환함수가 에러를 던질때만 함수 자체가 에러를 던치도록 허용(변환함수가 throws를 사용하지 않는 경우 함수도 에러를 던지지 않는다.)

import Foundation

class HigherOrderFunction {
    
    var arryIntData: [Int] = [1, 2, 3, 4, 5, 6]
    var arryStrData: [String] = ["Apple", "Baby", "Crocs", "Drake", "Boss"]
    var dicData: [String: Int] = ["A": 10, "B": 20, "C": 30, "D": 40, "E": 80, "F": 100]
    var setData: Set<Int> = [1, 4, 5, 6, 8]
    
    // MARK: map 함수(맵은 결국 매핑하는 것) -> 새로운 배열로 반환
    // 기존 배열의 각 아이템을 새롭게 매핑하여 새로운 배열을 반환(매핑방식은 내가 클로저로 제공)(Sequence 프로토콜을 따르는 모든 타입에서 사용할 수 있음)
    func mapBasic() {
        
        //arryData.map(<#T##transform: (Int) throws -> T##(Int) throws -> T#>) // func map<T>(_ transform: (Element) -> T) -> [T]
        // (Int) : 현재 컬렉션의 요소 타입
        // T : 변환 후 결과 컬렉션의 요소 타입.
        // transform : 각 요소에 적용할 변환 함수
        
        // MARK: 클로저 형태로 매핑방식을 제공(정수를 number로 받아서 하나씩 문자열로 변환하여 배열 만듦)
        var newArryData = arryIntData.map { (number) -> String in
            return "숫자: \(number)"
        }
        print(newArryData) // ["숫자: 1", "숫자: 2", "숫자: 3", "숫자: 4", "숫자: 5", "숫자: 6"]
        
        // MARK: 축약형태
        // 리턴타입 생략(아래 return 타입 형태로 타입 추론)
        var newArryData2 = arryIntData.map { (number) in
            return "숫자: \(number)"
        }
        // 파라미터, 리턴 생략($0 -> 첫번째 파라미터)
        var newArryData3 = arryIntData.map { "숫자: \($0)" }
        
    }
    
    // MARK: - filter 함수(필터는 결국 걸러내는 것) -> 새로운 배열로 반환
    // 배열을 하나씩 뽑아서 조건을 만족하는 요소만을 포함하는 새로운 배열을 반환(true만 나오는 아이템들만 모아가지고 다시 배열을 만들어서 반환)
    // 필터는 두번 연속으로도 사용 가능하다.(배열을 반환받아서 거기에 또 조건을 걸어서 필터하고)
    func filterBasic() {
        
        //arryStrData.filter(<#T##isIncluded: (String) throws -> Bool##(String) throws -> Bool#>)
        
        // MARK: 클로저로 논리 조건 제공(참과 거짓 판단 후 false는 버리고 true만 모아서 다시 배열을 반환)
        // 각 아이템을 필터링
        var newArrayData = arryStrData.filter { (name) -> Bool in
            return name.contains("B") // 문자열 배열에서 대문자 "B"를 포함하고 있는 것들만 꺼내서 새로운 배열을 만들어냄 -> ["Baby", "Boss"]
        }
        
        var newArrayData2 = arryIntData.filter { $0 % 2 == 0 } // (축약) 짝수만 걸러내서 새로운 배열 반환 -> [2, 4, 6]
        
        // MARK: filter 중첩 사용(체이닝)
        var newArrayData3 = arryIntData.filter { $0 % 2 == 0}.filter{ $0 >= 4 } // 짝수 걸러낸 새로운 배열 -> 4보다 큰 정수 -> [4, 6]
    }
    
    // MARK: - reduce 함수(결합) -> 단 하나의 결과값 반환(배열 반환 아님)
    // 기존 배열등의 각 아이템을 결합해서 마지막 결과값 반환(배열로 반환하는 것이 아닌 '단 하나의 결과값'을 반환)
    // 초기값 제공이 필요하고 결합 방식은 클로저로 제공(지정된 연산을 반복적으로 적용하여 최종 결과를 생성해내는 것)
    func reduceBasic() {
        
        //arryIntData.reduce(<#T##initialResult: Result##Result#>, <#T##nextPartialResult: (Result, Int) throws -> Result##(Result, Int) throws -> Result##(_ partialResult: Result, Int) throws -> Result#>)
        
        // MARK: reduce(0)은 초기값, sum(Result)은 결과값이고 num은 배열 첫번째 요소값을 시작으로 처음은 0(reduce) + 1(배열 첫번째 값) = 1 -> sum(Result)가 1이되고 + 2(배열 두번째 값) = 3 ->.. 이런식으로 배열의 각 숫자를 순회하며 누적 합계를 계산
        var resultSum = arryIntData.reduce(0) { (sum, num) in
            return sum + num // 결과값 : 21
        }
        
        // 초기값 100에서 배열의 요소 값 만큼 누적으로 빼기
        var resultSub = arryIntData.reduce(100) { $0 - $1 } // 결과값 : 79
        
        // 배열의 최대값 찾기(max() 함수)
        var maxNumber =  arryIntData.reduce(Int.min) { (currentMax, number) in
            max(currentMax, number) // 결과값 : 6
        }
        
        // 문자열 변환 반환
        // 초기값을 문자열 "0"으로 함으로써 strArray는 String 타입이 됨
        var strArray = arryIntData.reduce("0") { (result, item) in
            return result + String(item) // item은 문자열로 변환하여 더함 // 결과 값 : "0123456"(문자열)
        }
        
        // 문자열 배열 결합
        // 중간에 삼항연산자로 띄어쓰기하여 하나의 문자열 결합
        var resultStr = arryStrData.reduce("") { (result, str) in
            result + (result.isEmpty ? "" : " ") + str // "Apple Baby Crocs Drake Boss"
        }
    }
    
    // MARK: - map, filter, reduce 결합 사용
    func combinationFunc() {
        
        let numbersArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        
        // 홀수만 제곱해서 그 숫자를 다 더한 값
        var resultArray = numbersArray
            .filter { $0 % 2 != 0 } // 홀수 뽑아내기(걸러내기)
            .map { $0 * $0 } // 제곱(각각 맵핑)
            .reduce(0) { $0 + $1 } // 다 더하기(결합)
        
        // 1, 9, 25, 49, 81 ==> 결과 값 : 165
    }
    
    // MARK: - (기타 고차함수) forEach, compactMap, flatMap
    
    // MARK: forEach(각각의)(각각을 가지고 일을하고 끝냄, 반환 타입이 없음)
    // 기존 배열 등의 각 아이템을 사용해서 각 아이템별로 작업을 실행(작업 방식은 클로저로 제공)
    func forEachBasic() {
        let numbersArray = [1, 2, 3, 4, 5, 6]
        
        numbersArray.forEach { num in
            print(num) // 각각 번호를 출력하고 끝남 1, 2, 3, 4, 5, 6 을 하나씩 출력
        }
    }
    
    // MARK: - compactMap(map + 옵셔널 제거 새로운 배열 반환)
    // 기존 배열 등의 각 아이템을 새롭게 매핑하면서 옵셔널 요소는 제거하고 새로운 배열 반환(옵셔널 바인딩 기능이 내장된 map - 옵셔널은 아예 제거해준다)
    func compactMapBasic() {
        let strArray: [String?] = ["A", nil, "B", nil, "C"]
        
        var newStrArray = strArray.compactMap { $0 } // nil은 제거되고, 옵셔널이 아닌 String 타입으로 요소들을 반환(if let 바인딩 내장)
        
        let numbersArray = [-2, -1, 0, 1, 2]
        
        var newNumbersArray = numbersArray.compactMap { $0 >= 0 ? $0 : nil } // (삼항연산자 사용) 음수는 nil 처리하여 nil은 제거시키므로 -> [0, 1, 2] 배열 반환(filter로도 구현가능한 부분))
    }
    
    // MARK: - flatMap(플랫='평평'하게 매핑 - 중첩 배열 제거 후 배열 반환)
    // (내부 중첩된 배열을 제거하고)중첩된 배열의 각 배열을 새롭게 매핑한다.(매핑방식은 클로저로 제공)
    func flatMapBasic() {
        let nestedArray = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] // 중첩 배열
        
        var newArray = nestedArray.flatMap { $0 } // 내부에 중첩된 배열 제거해서 하나의 배열로 반환 [1, 2, 3, 4, 5, 6, 7, 8, 9]
        
        let nestedArray2 = [[[1, 2, 3], [4, 5, 6], [7, 8, 9]], [[10, 11], [12, 13, 14]]] // 3중 중첩 배열
        
        var newArray2 = nestedArray2
            .flatMap{ $0 }
            .flatMap{ $0 } // flatMap을 2번 사용하면 두번의 중첩이 벗겨짐 [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    }
    
    // MARK: - 클로저의 (input)파라미터는 함수로 전달 가능 (클로저도 결국 함수니까)
    
    // 짝수인지 판별하는 함수
//    func isEven(_ i: Int) -> Bool {
//        return i % 2 == 0
//    }
//    
//    let evens = arryIntData.filter(isEven) // 필터 함수 파라미터로 짝수 판별하는 함수 전달
}
