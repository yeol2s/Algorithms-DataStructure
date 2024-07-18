//
//  CollectionInfo.swift
//  Algorithms
//
//  Created by 유성열 on 7/19/24.
//

// MARK: - Collection 특징 및 차이점 정리

// MARK: * Copy-On-Write
// MARK: 컬렉션 타입들은 CopyOnWirte 전략을 사용하여 성능을 최적화하고 메모리 사용을 효율적으로 관리한다. 컬렉션이 복사될 때 실제로 데이터가 복사되지 않고 (메모리)참조가 공유되는 최적화 기법으로 참조가 공유된 상태에서 하나의 참조가 수정되면 그 시점에 데이터를 실제로 복사하여 독립적인 복사본을 만든다.

// MARK: Hashable, HashTable
// MARK: Dictionary, Set은 HashTable 기반이고, Array는 아님
// 타입이 'Hashable'이라는 의미는 해당 타입을 해시함수의 Input 값으로 사용가능하다는 것이다.(해시함수를 사용해 유일한 값으로 변환이 가능한 타입인지를 확인하는 것) -> String, Int 등 기본타입은 모두 Hashable한 타입
// Dictionary, Set은 내부적으로 해시테이블 기반 자료구조이다. 값의 유일성을 보장하고 검색 속도가 빠르다. (Array는 해시 테이블 기반이 아님)
// 딕셔너리의 Key는 고유해야 하며, 이를 보장하기 위해 키 타입은 'Hashable' 프로토콜을 준수해야 한다.(값 타입은 상관없음)
// 셋은 중복을 허용하지 않으므로, 이를 위해서는 각 요소는 고유해야 한다. 따라서 셋의 요소 타입은 'Hashable' 프로토콜을 준수해야 한다. (각 요소의 해시 값을 사용)
// * 해시 함수를 통해 HashValue를 만들고 HashValue를 기반으로 HashTable을 만든다.


/*
 Array(배열) : 데이터를 순서대로 저장하는 컬렉션 (중복 값 가능)
 Dictionary(딕셔너리) : 데이터를 키와 값으로 하나의 쌍으로 만들어 관리하는 순서가 없는 컬렉션 (중복 불가능)
 Set(집합) : 수학의 집합과 비슷한 연산을 제공하는 순서가 없는 컬렉션 (중복 불가능)
   
    * -> Array는 순서가 있고, Dictionary, Set은 순서가 없음
    * -> Array는 중복이 가능하고, Dictionary, Set은 중복이 불가능하다.
 */


/*
 * 컬렉션에서 정렬 관련한 메서드의 이름이
    - 동사 원형(sort(), reverse(), shuffle() 등)인 경우는 -> '직접적으로 요소의 값을 변경(리턴하지 않음)'
    - 분사 형태(ing, ed)-(sorted(), reversed(), shuffled() 등)인 경우는 -> '직접 변환하지 않고 '배열'을 리턴함'
*/
