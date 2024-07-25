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

// MARK: - Collection 공통 메서드(고차함수)
// Swift의 컬렉션 전체는 'Sequence' 및 'Collection' 프로토콜을 따르며 이로 인해 다양한 메서드를 제공받음
// TODO: 작성필요


// MARK: - 컬렉션은 힙 메모리 영역에 저장된다.
// MARK: 컬렉션은 기본적으로 값 타입이지만 힙 메모리에 저장되는 이유는?(값 타입은 기본적으로 스택 메모리에서 저장)
/*
 딕셔너리와 Set은 내부적으로 해시테이블을 사용하여 데이터를 저장하고 관리하고, 동적 크기를 가지기 때문에 힙에서 관리가 필요하다. 이러한 데이터 구조는 주로 ‘힙 메모리’에 저장되야 한다.
 (컴파일 타임에 사이즈를 정확히 알기 어렵다.)

 딕셔너리와 Set의 인스턴스는 스택에 있는 변수에 저장될 수 있지만 실제 데이터는 힙에 저장된다고 한다.
 (딕셔너리와 Set은 스위프트에서 값 타입으로 구현되어 있지만 내부적으로는 참조타입과 유사하게 동작 - 데이터 자체를 힙에 저장하고, 그에 대한 참조를 통해 접근하는 방식)

 *그렇다면 배열은?
 배열은 기본적으로 HashTable을 만들지 않기 때문에 Hashable 프로토콜을 준수하지 않기도 한다.
 배열은 힙과 스택 메모리 둘 다에 저장될 수 있고, 저장 위치는 배열의 내용과 사용 방식에 따라 달라진다. (기본적으로는 스택)
 
    1. 스택 메모리에 저장되는 경우 :
        -배열은 기본적으로 스택에 저장, 작은 크기의 배열이나 함수 내에서 지역 변수로 선언된 작은 크기의 배열은 스택에 저장
        -(고정 크기 배열)컴파일 타임에 크기가 정해져 있고 작은 크기의 배열은 스택 메모리에 저장
 
    2. 힙 메모리에 저장되는 경우 :
        -동적 크기: 배열이 커지거나 크기가 변할 수 있는 경우, 힙 메모리에 저장된다. (힙 메모리는 동적으로 할당과 해제가 가능하기 때문에 크기가 가변적인 배열을 저장하기 적합)
        - 값 복사 최적화 : Copy on Write - 배열이 수정되기 전까지는 실제 데이터가 복사되지 않고, 참조만 복사됨. 따라서 실제 데이터는 힙에 저장되어 관리
        - 클래스나 구조체의 프로퍼티로 사용되는 경우 : 배열이 클래스의 프로퍼티로 사용될 때는 그 클래스의 인스턴스가 힙에 저장되므로 배열 역시 힙 메모리에 저장

 * String은 기본적으로 컬렉션 프로토콜을 채택하고 있다.
*/

// MARK: - Swift 5.2 버전에 추가된 컬렉션으로 딕셔너리처럼 Key-Value 쌍으로 요소가 있고, 배열처럼 순서가 있는 컬렉션이 있다. 'KeyValuePairs'
// Hashable하지 않고 append, remove 같은 메서드가 없다.

// (순서가 있는)key와 value로 이루어짐
// let info: KeyValuePairs = ["A": 10, "B": 20, "C": 30]

// 기능
// info.count
// info.isEmpty

// 접근
// info[0] // [key: "A", value: 1]
// info[1].1 // '2' (key, value에서도 인덱스로 접근이 가능하다. "B"의 1번값을 가져옴)




