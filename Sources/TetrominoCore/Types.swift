//
//  Types.swift
//  
//
//  Created by Michael Brandt on 6/14/22.
//

public struct Point : Hashable {
    public let x: Int
    public let y: Int
    
    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
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
    
    public init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
}

public struct PlacedPiece {
    public let id: Int
    public let rotation: Int
    public let position: Point
    
    public init(id: Int, rotation: Int, position: Point) {
        self.id = id
        self.rotation = rotation
        self.position = position
    }
}
