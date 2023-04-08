//
//  PieceRotation.swift
//  
//
//  Created by Michael Brandt on 6/14/22.
//

public class PieceRotation : Equatable {
    public let pips: Set<Point>
    public let size: Size
    public let topPipX: Int
    public let heightByX: [Int]
    
    public init<S:Sequence>(_ points: S) where S.Element == Point {
        var maxX = 0
        var maxY = 0
        var minTopRowX = Int.max
        var pts = Set<Point>()
        var isAligned = 0
        var maxYByX: [Int:Int] = [:]
        for p in points {
            precondition(p.x >= 0 && p.y >= 0)
            if p.x > maxX {
                maxX = p.x
            }
            if p.y > maxY {
                maxY = p.y
            }
            if p.y == 0 && p.x < minTopRowX {
                minTopRowX = p.x
            }
            if p.x == 0 {
                isAligned |= 1
            }
            if p.y == 0 {
                isAligned |= 2
            }
            pts.insert(p)
            maxYByX[p.x] = max(p.y, maxYByX[p.x, default: 0])
        }
        
        precondition(maxX >= 0 && maxY >= 0 && minTopRowX <= maxX)
        precondition(isAligned == 3)
        self.pips = pts
        self.size = Size(width: maxX + 1, height: maxY + 1)
        self.topPipX = minTopRowX
        var heightByX = [Int](repeating: 0, count: size.width)
        for x in 0..<size.width {
            heightByX[x] = maxYByX[x, default: 0]
        }
        self.heightByX = heightByX
    }
    
    public func contains(_ pt: Point) -> Bool {
        return pips.contains(pt)
    }
    
    public static func == (lhs: PieceRotation, rhs: PieceRotation) -> Bool {
        return lhs.pips == rhs.pips
    }
}
