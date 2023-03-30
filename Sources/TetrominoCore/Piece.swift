//
//  Piece.swift
//  
//
//  Created by Michael Brandt on 6/14/22.
//

public class Piece {
    public let name: String
    public let rotations: [PieceRotation]
    public let pipCount: Int
    
    public init(_ name: String, points: [Point]) {
        self.name = name
        self.pipCount = points.count
        rotations = Piece._generateRotations(points)
    }
    
    private static func _generateRotations<S: Sequence>(_ points: S) -> [PieceRotation] where S.Element == Point {
        var rotations = [PieceRotation]()
        let baseRotation = PieceRotation(points)
        rotations.append(baseRotation)
        
        var currentPoints = _rotatedPoints(points)
        for _ in 0..<3 {
            // up to 3 more rotations
            let nextRotation = PieceRotation(currentPoints)
            if rotations.contains(nextRotation) {
                break
            }
            rotations.append(nextRotation)
            currentPoints = _rotatedPoints(currentPoints)
        }
        
        return rotations
    }
    
    private static func _rotatedPoints<S: Sequence>(_ points: S) -> [Point] where S.Element == Point {
        var rotatedPoints = [Point]()
        var minY = Int.max
        for pt in points {
            let rotatedPoint = Point(x: pt.y, y: -pt.x)
            if rotatedPoint.y < minY {
                minY = rotatedPoint.y
            }
            rotatedPoints.append(rotatedPoint)
        }
        
        for i in 0..<rotatedPoints.count {
            let currentPoint = rotatedPoints[i]
            let shiftedPoint = Point(x: currentPoint.x, y: currentPoint.y - minY)
            rotatedPoints[i] = shiftedPoint
        }
        return rotatedPoints
    }
    
    // Default tetris pieces
    public static var defaultPieces = [
        Piece("T", points: [Point(x: 1, y: 0), Point(x: 0, y: 1), Point(x: 1, y: 1), Point(x: 2, y: 1)]),
        Piece("L", points: [Point(x: 0, y: 0), Point(x: 0, y: 1), Point(x: 0, y: 2), Point(x: 1, y: 2)]),
        Piece("J", points: [Point(x: 1, y: 0), Point(x: 1, y: 1), Point(x: 1, y: 2), Point(x: 0, y: 2)]),
        Piece("I", points: [Point(x: 0, y: 0), Point(x: 0, y: 1), Point(x: 0, y: 2), Point(x: 0, y: 3)]),
        Piece("S", points: [Point(x: 1, y: 0), Point(x: 2, y: 0), Point(x: 0, y: 1), Point(x: 1, y: 1)]),
        Piece("Z", points: [Point(x: 0, y: 0), Point(x: 1, y: 0), Point(x: 1, y: 1), Point(x: 2, y: 1)]),
        Piece("O", points: [Point(x: 0, y: 0), Point(x: 1, y: 0), Point(x: 0, y: 1), Point(x: 1, y: 1)]),
    ]
    
}

