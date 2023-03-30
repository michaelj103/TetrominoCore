//
//  Types.swift
//  
//
//  Created by Michael Brandt on 6/14/22.
//

public struct Point : Hashable {
    public let x: Int
    public let y: Int
    
    public func pointAbove() -> Point {
        return Point(x: x, y: y-1)
    }
    
    public func pointBelow() -> Point {
        return Point(x: x, y: y+1)
    }
    
    public func pointRight() -> Point {
        return Point(x: x+1, y: y)
    }
    
    public func pointLeft() -> Point {
        return Point(x: x-1, y: y)
    }
    
    public func pointUpLeft() -> Point {
        return Point(x: x-1, y: y-1)
    }
    
    public func pointUpRight() -> Point {
        return Point(x: x+1, y: y-1)
    }
    
    public func pointDownLeft() -> Point {
        return Point(x: x-1, y: y+1)
    }
    
    public func pointDownRight() -> Point {
        return Point(x: x+1, y: y+1)
    }
}

public struct Size {
    public let width: Int
    public let height: Int
}

public struct PlacedPiece {
    public let id: Int
    public let rotation: Int
    public let position: Point
}
