//
//  TaskSplitParallel.swift
//  my roadmap
//
//  Created by ahmed on 01/08/2025.
//

import Foundation
import Combine

enum errorTaskBranch: Error{
    case listIsAtFullLengthOfMax2
}
final class TaskBranch: GenericState{
    
    
    
    var posX: CGFloat
    var posY: CGFloat
    
    var id: UUID
    var type: StateType
    var title: String
    var progress: Int
    var startDate: Date?
    var completed: Bool
    var completedAt: Date?
    var expectedDeadline: Date?
    
    private(set) var parallelBranches: [ListOfTasks] = []
    
    
    func setProgress(_ progress: Int) throws {
        self.progress = 100
    }
    
    init(title: String) {
        self.id = UUID()
        self.type = .branch
        self.title = title
        self.progress = 100
        self.startDate = Date.now
        self.completed = false
        self.completedAt = Date.now
        self.expectedDeadline = Date.now
        
        posX = 0
        posY = 0
    }
    
    func addBranch(branch: ListOfTasks) throws {
        guard parallelBranches.count < 2 else {
            throw errorTaskBranch.listIsAtFullLengthOfMax2
        }
        parallelBranches.append(branch)
    }
    
    func isCompleted() -> Bool {
        guard parallelBranches.count == 2 else {
            return parallelBranches[0].isListCompleted()
        }
        return parallelBranches[0].isListCompleted() && parallelBranches[1].isListCompleted()
    }
    
    // MARK: Drawable
    func calcWidth() -> CGFloat {
        if parallelBranches.count == 1{
            return parallelBranches[0].calcWidth()
        } else {
            return parallelBranches[0].calcWidth() + parallelBranches[1].calcWidth()
        }
        
    }
    
    func calcHeight() -> CGFloat {
        let heightList1 = parallelBranches[0].calcHeight()
        let heightList2 = parallelBranches[1].calcHeight()
        return max(heightList1,  heightList2)
    }
    
    func calcMarginedWidth() -> CGFloat {
        if parallelBranches.count == 1{
            return parallelBranches[0].calcMarginedWidth() + DrawableConstants.margin
        } else {
            return parallelBranches[0].calcMarginedWidth() + parallelBranches[1].calcMarginedWidth() + DrawableConstants.margin
        }
    }
    
    func calcMarginedHeight() -> CGFloat {
        if parallelBranches.count == 1{
            return parallelBranches[0].calcMarginedHeight() + DrawableConstants.margin
        } else {
            return parallelBranches[0].calcMarginedHeight() + parallelBranches[1].calcMarginedHeight() + DrawableConstants.margin
        }
    }
    
    func getJson() -> String {
        let branch1Str: String = parallelBranches[0].getJson()
        let branch2Str: String = parallelBranches[1].getJson()
        
        let branch1Data = branch1Str.data(using: .utf8)!
        let branch2Data = branch2Str.data(using: .utf8)!
        
        let branch1Object = try! JSONSerialization.jsonObject(with: branch1Data)
        let branch2Object = try! JSONSerialization.jsonObject(with: branch2Data)
        
        let result: [String: Any] = [
            "type": "branch",
            "branch1": branch1Object,
            "branch2": branch2Object
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: result, options: []),
              let jsonString = String(data: jsonData, encoding: .utf8) else {
            return "{}"
        }
        
        return jsonString
        
    }
}
