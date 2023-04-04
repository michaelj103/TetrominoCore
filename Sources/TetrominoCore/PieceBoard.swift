//
//  PieceBoard.swift
//  
//
//  Created by Michael Brandt on 6/15/22.
//

public class PieceBoard<T: Equatable> {
    public let size: Size
    private var filledSpaces: [T]
    private var unfilledValue: T
    
    public init(_ size: Size, unfilled: T) {
        precondition(size.width > 0 && size.height > 0)
        self.size = size
        self.filledSpaces = [T](repeating: unfilled, count: size.width * size.height)
        unfilledValue = unfilled
    }
    
    public func nextAvailable() -> Point? {
        guard let idx = filledSpaces.firstIndex(of: unfilledValue) else {
            return nil
        }
        
        let x = idx % size.width
        let y = idx / size.width
        return Point(x: x, y: y)
    }
    
    public func clear() {
        for i in 0..<filledSpaces.count {
            filledSpaces[i] = unfilledValue
        }
    }
    
    @discardableResult
    public func clearCompletedRows() -> Set<Int> {
        var clearedRows: Set<Int> = []
        for row in 0..<size.height {
            var filledInRow = 0
            for col in 0..<size.width {
                if isFilled(at: Point(x: col, y: row)) {
                    filledInRow += 1
                } else {
                    break
                }
            }
            if filledInRow == size.width {
                clearedRows.insert(row)
                for col in 0..<size.width {
                    _unfill(at: Point(x: col, y: row))
                }
            }
        }
        
        var shiftAmount = 0
        for row in (0..<size.height).reversed() {
            if clearedRows.contains(row) {
                shiftAmount += 1
            } else if shiftAmount > 0 {
                for col in 0..<size.width {
                    let existing = _unfill(at: Point(x: col, y: row))
                    _fill(at: Point(x: col, y: row + shiftAmount), with: existing)
                }
            }
        }
        
        return clearedRows
    }
    
    @discardableResult
    public func addPiece(_ piece: PieceRotation, at point: Point, with val: T) -> Bool {
        assert(point.x >= 0 && point.y >= 0)
        for piecePoint in piece.pips {
            let fillPoint = Point(x: point.x + piecePoint.x, y: point.y + piecePoint.y)
            if !_canFill(at: fillPoint) {
                return false
            }
        }
        for piecePoint in piece.pips {
            let fillPoint = Point(x: point.x + piecePoint.x, y: point.y + piecePoint.y)
            _fill(at: fillPoint, with: val)
        }
        return true
    }
    
    public func removePiece(_ piece: PieceRotation, at point: Point) {
        assert(point.x >= 0 && point.y >= 0)
        for piecePoint in piece.pips {
            let fillPoint = Point(x: point.x + piecePoint.x, y: point.y + piecePoint.y)
            _unfill(at: fillPoint)
        }
    }
    
    public func isFilled(at pt: Point) -> Bool {
        assert(pt.x >= 0 && pt.y >= 0 && pt.x < size.width && pt.y < size.height)
        let idx = (pt.y * size.width) + pt.x
        return filledSpaces[idx] != unfilledValue
    }
    
    private func _canFill(at pt: Point) -> Bool {
        guard pt.x < size.width && pt.y < size.height else {
            return false
        }
        let idx = (pt.y * size.width) + pt.x
        return filledSpaces[idx] == unfilledValue
    }
    
    private func _fill(at pt: Point, with val: T) {
        assert(pt.x >= 0 && pt.x < size.width && pt.y >= 0 && pt.y < size.height)
        let idx = (pt.y * size.width) + pt.x
        filledSpaces[idx] = val
    }
    
    @discardableResult
    private func _unfill(at pt: Point) -> T {
        assert(pt.x >= 0 && pt.x < size.width && pt.y >= 0 && pt.y < size.height)
        let idx = (pt.y * size.width) + pt.x
        let existing = filledSpaces[idx]
        filledSpaces[idx] = unfilledValue
        return existing
    }
}
