//
//  TupleDataStructure.swift
//  Algorithms
//
//  Created by 유성열 on 7/30/24.
//
// MARK: - 튜플(Tuple) with. 네임드 튜플(Named Tuple)
// MARK: 튜플도 '타입'이다. (고유한 이름이 아닌 타입들의 조합으로 이루어진 구조적 타입으로 간단한 그룹화를 위해 설계되어 타입의 명시 필요성이 없으므로 대문자로 시작하지 않는 특별한 타입이다.) - * 튜플은 함수의 반환 타입으로도 사용 가능
// 서로 다른 타입의 여러 값을 하나의 그룹으로 묶은 구조(각 데이터의 이름을 지정할 수 있음)(2개 이상의 연관 데이터를 저장하는 Compound(복합) 타입
// 변수를 선언과 동시 해당 멤버(데이터 종류 및 개수)는 결정되어 '추가/삭제' 불가능(같은 데이터 타입으로는 변경(추가/삭제) 가능)

import Foundation

class TupleDataStructure {
    
    let twoNumbers: (Int, Int) = (1, 2) // type(of: twoNumbers) -> (Int, Int) 타입의 두 값을 가지는 twoNumbers 튜플 타입이다.
    let numbers = (1, 2, 3) // (Int, Int, Int) 튜플 생성
    typealias GridPoint = (Int, Int) // 타입앨리어스로 치환도 가능(GridPoint = (Int, Int))
    
    // MARK: 네임드 튜플(Named Tuple) - 이름이 매겨진 튜플
    var person = (name: "Cook", age: 30) // 네임드 튜플 생성 type: (name: String, age: Int)
    
    func tupleBasic() {
        
        // MARK: 튜플의 접근
        let name = person.name // 튜플 데이터 이름으로 접근
        let age = person.1 // 인덱스로 접근(0번 인덱스는 name)
        person.age = 25 // 데이터 변경 가능(같은 데이터 타입으로만)
        
        // MARK: 튜플 데이터 분해
        let (first, second, third) = numbers // 튜플 데이터 분해(분해하여 상수(변수)에 저장)
        print(first) // 1
        print(second) // 2
        print(third) // 3
        
        // MARK: 튜플 비교 연산
        // 두개의 튜플 비교 가능(최대 7개 요소 미만만 비교 가능)
        // 왼쪽 멤버부터 한번에 하나씩 비교함 -> 같을 경우 다음 멤버를 비교(왼쪽 멤버에서 true, false가 결정나고 동일한(==)경우 다음 멤버를 비교
        // 문자열의 경우 앞글자만 비교하는데 a로 시작하는 문자는 b로 시작하는 문자보다 낮음(a가 가장 낮음 z가 가장 높음)(Bool 값은 비교 불가능-에러)
        let a = (1, "zoom") < (2, "apple") // true : 1이 2보다 작고 여기서 결정되므로 뒤에 문자는 비교하지 않음
        let b = (3, "apple") < (3, "baby") // true : 앞 3은 같고, apple은 baby보다 작음
        
        // MARK: 튜플의 활용(switch문)
        let user = (firstName: "유", age: 30)
        
        switch user {
        case ("유", 30):
            print("30세이상 유씨입니다.")
        default:
            break
        }
        
        // switch 바인딩 + where절
        let coordinate = (3, 0)
        
        switch coordinate {
        case let (x, y) where x == y: // 먼저 x, y 상수에 바인딩하고 where절로 조건을 한번 더 비교
            print("(\(x), \(y))의 좌표는 y = x 1차 함수의 그래프 위에 있음")
        case (let x, let y) where x == -y:
            print("(\(x), \(y))의 좌표는 y = -x 1차 함수의 그래프 위에 있음")
        case let (x, y):
            print("\(x), \(y)의 좌표는 y = x, 또는 y = -x 그래프가 아닌 임의의 지점에 있다.")
            // default가 생략된 이유는 어떤 상황이든 변수에 정수가 들어가게 됨
        }
    }
}
