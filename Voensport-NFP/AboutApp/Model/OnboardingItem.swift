//
//  OnboardingItem.swift
//  Voensport-NFP
//
//  Created by Кирилл on 29.12.2021.
//

import Foundation

struct OnboardingItem {
    let message: String
    let imageName: String
    
    static func generateItems() -> [OnboardingItem] {
        [OnboardingItem(
            message: "Перед использованием приложения зайдите в раздел настроек и укажите данные для расчета",
            imageName: "OnBoardSettings"),
         OnboardingItem(
            message: "Нажав на эту кнопку Вы можете посмотреть порядок выполнения упражнения",
            imageName: "ExerciseDescription"),
         OnboardingItem(
            message: "Если слайдер стал красным - результат в упражнении ниже порогового минимума",
            imageName: "LessMinimumScore"),
         OnboardingItem(
            message: " Сохраняйте результаты, вы в любой момент сможете их отредактировать",
            imageName: "SaveButton"),
         OnboardingItem(
            message: "Просматривайте, редактируйте и удаляйте результаты. При сохранении вместе с результатами сохраняются и настройки",
            imageName: "DeleteResult")
        ]
    }
}
