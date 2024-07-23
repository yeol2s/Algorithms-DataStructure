//
//  DictionaryDataStructure.swift
//  Algorithms
//
//  Created by 유성열 on 7/22/24.
//
// MARK: - 딕셔너리(Dictionary)
// MARK: 데이터를 Key와 Value로 하나의 쌍으로 묶어서 관리(순서가 없음)
// 키값은 중복 불가능(해시테이블로 관리), 값은 중복 가능함
// 동일한 타입 쌍으로만 데이터를 담을 수 있다. -> [Int: String], [String: String]...
// 값에는 딕셔너리나 배열로 중첩 사용 가능하다. -> ["A": [1, 2, 3], "B": [1, 2, 3]]..
// 딕셔너리는 insert, replace, append 메서드 대신 update 메서드를 사용
// 딕셔너리의 키값은 Hashable(처리가 빠름) - 키값이 hash 함수 처리되어 HashValue(고유 번호)를 가지고 저장되는 것(HashTable로 관리)(Key는 Hashable 프로토콜을 준수해야 한다.)
// 딕셔너리는 키-값 쌍이 하나의 요소
// 서버와 통신하는 API는 대부분 딕셔너리 형태로 되어있음

/*
 * 딕셔너리의 특징
    - Key-Value 쌍으로 저장 : 각 항목은 고유한 키와 연관된 값으로 구성(Key는 Hashable 프로토콜을 준수해야 함)
    - 무작위 순서 : Key-Value 쌍을 무작위 순서로 저장(삽입 순서를 유지하지 않음)
    - 빠른 검색 : Key를 사용한 값의 검색은 매우 빠르며, 일반적으로 O(1)의 시간 복잡도를 가짐
    - 동적 크기 조정 : 딕셔너리는 필요에 따라 자동으로 크기를 조정(고정된 크기를 미리 지정할 필요 없음)
 
 * 딕셔너리의 장점 :
    - 빠른 데이터 접근 : (Hashable)Key를 통해 값에 빠르게 접근(대량의 데이터에서 특정 항목을 효율적으로 찾는 데 유용)
    - 유연한 데이터 저장 : 다양한 타입의 Key와 Value을 저장할 수 있어서 유연한 데이터 구조를 지원
    - 자동 중복 키 관리 : 같은 Key로 여러 값을 저장하려고 하면 기존 값이 새 값으로 자동 대체되므로 중복 Key 문제를 신경 쓸 필요가 없음
 
 * 딕셔너리의 단점 :
    - 메모리 사용량 : 딕셔너리는 내부적으로 HashTable을 사용하기 때문에, 다른 데이터 구조에 비해 메모리 사용량이 (상대적으로)높을 수 있음
    - 무작위 순서 : 삽입 순서가 보장되지 않음(순서가 중요하다면 딕셔너리는 적합하지 않음)
    - 느린 순회 : Array(배열)과 비교할 때 전체 요소를 순회하는 속도가 느릴 수 있음
    - 고유한 Key 필요 : Key는 고유해야 함(Key가 고유하지 않다면 딕셔너리 사용 불가)
*/

import Foundation

class DictionaryDataStructure {
    
    // MARK: 딕셔너리 사용
    var info: Dictionary<String, String> = [:] // 정식 문법([:] -> 빈값)
    //var info: [String: String] = [:] // 단축 문법
    //var info: [String: Int?] // 값 옵셔널 선언(선언시 명시적으로 옵셔널 선언하면 초기화시에도 nil 할당 가능 -> 선언시에 옵셔널을 선언하지 않으면 값 추가 시에는 nil 할당(삭제)이 가능하지만 초기화시에 nil 할당하는 것은 안됨)
    /* 값 타입이 옵셔널로 선언되지 않은 경우 : 딕셔너리의 값은 옵셔널이 아니지만, Key를 통한 (검색)접근 결과는 항상 옵셔널(nil로 값을 설정하면 '키-값' 쌍 삭제)
       값 타입을 옵셔널로 선언한 경우(명시적) : 딕셔너리의 값이 실제 'nil'일 수 있으며, Key를 통한 접근 결과도 여전히 옵셔널 */
    //var info = Dictionary<Int, String>()
    //var info = [Int: String]()
    
    
    // MARK: 딕셔너리 Key: Value(초기값 생성)
    var dicData = ["A": 123, "B": 456]
    //print(dicData) // 딕셔너리는 순서가 없으므로 print함수로 출력해도 실행시마다 순서가 뒤바뀜(딕셔너리를 비교연산하는 경우 두 개의 딕셔너리가 같은 요소로 순서가 달라도 같다고 판단함)
    
    
    func dictionaryBasic() {
        // MARK: 딕셔너리 접근
        // 딕셔너리는 key값으로 접근한다(서브스크립트 문법) - 딕셔너리는 기본적으로 (Key를 전달)서브스크립트 문법을 주로 사용(값만 검색은 불가능)
        var a = dicData["A"] // 접근시 옵셔널 타입으로 리턴한다(값이 없을 수도 있으므로(nil), 언래핑해서 사용해야 함)
        // var a = dicData["A", default: "Empty"] // 기본값으로 Empty(value)를 제시하는 방법(값이 없을 때 "Empty"를 사용하도록(nil 가능성을 없앰)
        
        // MARK: 딕셔너리 기능
        dicData.count // 요소의 개수(몇쌍인지)
        dicData.isEmpty // 비어있는지 여부
        dicData.randomElement() // (옵셔널)랜덤으로 한쌍을 반환(네임드 튜플형태)
        //dicData.contains(where: <#T##((key: String, value: Int)) throws -> Bool#>) // 포함여부(클로저)
        
        dicData.keys // 딕셔너리의 Key만 모아서 뽑아줌
        dicData.values // 딕셔너리의 Value만 모아서 뽑아줌
        
        dicData.keys.sorted() // Key를 배열 형태로 반환
        dicData.values.sorted() // Value를 배열 형태로 반환
        // for key in dicData.keys.sorted() { } // 반복문으로 배열 형태로 반환해서 key값이나 value값을 뽑아냄
        
        // MARK: 딕셔너리 중요 기능
        // 딕셔너리는 update(업데이트), remove(삭제) 기능을 사용한다. (배열과는 다르게 insert(삽입), replace(교체), append(추가) 메서드가 없고 대신 'update'를 사용)
        info["A"] = "Apple" // 새로 삽입
        info["B"] = "Jobs" // 추가 삽입
        info["B"] = "Cook" // (업데이트) 덮어쓰기(동일한 키가 있으므로)
        info.updateValue("Musk", forKey: "C") // 추가 삽입(새로운 요소가 추가되면 -> nil 반환(기존 요소가 있다면 기존 요소를 반환)(예전 값을 지우면서 반환하는 것, 비어있었다면 nil이 반환되는 것)
        info = ["A": "B"] // 딕셔너리 요소 전체 교체(["A": "B"]만 존재하게 됨(덮어쓰는 것))
        
        info["B"] = nil // "B": "Jobs" (키-값 쌍 삭제)
        info.removeValue(forKey: "B") // 키-값 쌍 삭제(삭제된 값이나 (Key가 존재하지 않는 경우)nil 반환) *Key의 존재 여부를 확인하는데 유용
        info.removeAll() // 전체 삭제
        info.removeAll(keepingCapacity: true) // (메모리 공간 유지) 전체 삭제
        
        // MARK: 딕셔너리 중첩 사용
        var dicArray = [String: [Int]]() // 딕셔너리 값에 [배열] 중첩
        // dics["A"] = [1, 2, 3] // Key: "A", value: [1, 2, 3]
        var dics = [String: [String: Int]]() // 딕셔너리 값게 딕셔너리 중첩
        // dics["B"] = ["name": 1, "gender": 2] // Key: "B", value: [Key: "name", value: 1", Key: "gender", value: 2]
        
        // MARK: 딕셔너리 반복문 응용
        var studentScores: [String: Int] = ["Kim": 80, "Yoo": 70, "OH": 100]
        
        for (student, score) in studentScores { // 키-값을 네임드 튜플 형태로 하나씩 받음(순서가 없으므로 실행 마다 순서가 다름)
            print("\(student)의 점수는: \(score)")
        }
//        for (student, _) in studentScores { // 키 값만 꺼내기(반대로 값만 꺼낼때는 (_, value)
//            print("\(student)의 점수는: \(score)")
//        }
    }
}
