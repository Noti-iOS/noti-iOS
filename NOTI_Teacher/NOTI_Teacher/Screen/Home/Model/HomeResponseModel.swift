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
}

// MARK: - Homework
struct Homework: Codable {
    let homeworkId: Int
    let homeworkName: String
    let content: String
    let numberOfStudents: Int
    let numberOfCompletions: Int
}

// MARK: - Student
struct Student: Codable {
    let studentId: Int
    let studentNickname: String
    let focusStatus: Bool
    let profileImage: String?
    let homeworkProgressStatus: String
}
