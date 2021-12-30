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
            message: "Перед использованием приложения зайдите в раздел настроек и укажите данные для расчета.  Настройки сохранятся автоматически",
            imageName: "OnBoardSettings"),
         OnboardingItem(
            message: "Если на карточке упражнения есть такая кнопка - можно посмотреть порядок его выполнения",
            imageName: "ExerciseDescription"),
         OnboardingItem(
            message: "Если слайдер стал красным - результат в упражнении ниже порогового минимума",
            imageName: "LessMinimumScore"),
         OnboardingItem(
            message: "Вы можете сначала выбрать все упражнения и сохранить результат, а потом редактировать каждое упражнение отдельно",
            imageName: "SaveButton"),
         OnboardingItem(
            message: "Просматривайте, редактируйте и удаляйте результаты. Имейте ввиду, что вместе с результатами сохраняются и настройки.",
            imageName: "DeleteResult")
        ]
    }
}
