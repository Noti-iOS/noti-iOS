//
//  HomeResponseModel.swift
//  NOTI_Teacher
//
//  Created by 황윤경 on 2023/01/13.
//

import Foundation

struct HomeResponseModel: Codable {
    let teacherNickName: String
    let isLessonCreated: Bool
    let lessons: [Lesson]
}

// MARK: - Lesson
struct Lesson: Codable {
    let lessonId: Int
    let lessonName: String
    let startTime: String
    let endTime: String
    let homeworkCompletionRate: Int
    let students: [Student]
    let homeworks: [Homework]
    var isOpened: Bool?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isOpened = (try? values.decode(Bool.self, forKey: .isOpened)) ?? false
        lessonId = try values.decode(Int.self, forKey: .lessonId)
        lessonName = try values.decode(String.self, forKey: .lessonName)
        startTime = try values.decode(String.self, forKey: .startTime)
        endTime = try values.decode(String.self, forKey: .endTime)
        homeworkCompletionRate = try values.decode(Int.self, forKey: .homeworkCompletionRate)
        students = try values.decode([Student].self, forKey: .students)
        homeworks = try values.decode([Homework].self, forKey: .homeworks)
    }
}

// MARK: - Homework
struct Homework: Codable {
    let homeworkId: Int
    let homeworkName: String
    let content: String // TODO: - 서버 수정 후 삭제 예정
    let numberOfStudents: Int
    let numberOfCompletions: Int
}

// MARK: - Student
struct Student: Codable {
    let studentId: Int
    let studentNickname: String
    let focusStatus: Bool
    let profileImage: String?
    /// NONE, IN_PROGRESS, COMPLETION
    let homeworkProgressStatus: String
}

extension Student {
    var profileImageURL: URL? {
        guard let profileImageURL = profileImage?.encodeURL() else { return nil }
        return URL(string: profileImageURL)
    }
}
