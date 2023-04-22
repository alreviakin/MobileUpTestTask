//
//  Resources.swift
//  MobileUpTestTask
//
//  Created by Алексей Ревякин on 23.04.2023.
//

import Foundation

enum R {
    static var isRussian = true
    
    enum Auth {
        static var buttonTitle: String { R.isRussian ? "Вход через ВК" : "Login VK" }
    }
    
    enum Gallery {
        static var exit: String { R.isRussian ? "Выход" : "Logout" }
        static var date: String { R.isRussian ? "ru_Ru" : "en_US" }
    }
    
    enum Error {
        static var authorization: String { R.isRussian ? "Ошибка авторизации" : "Authorization error" }
        static var notLogged: String { R.isRussian ? "Вы не были авторизованы" : "You were not logged in" }
        static var noInternet: String { R.isRussian ? "Нет подключения к интернету" : "No internet connection" }
        static var dataLoading: String { R.isRussian ? "Ошибка загрузки данных" : "Data loading error" }
        static var photoTransition: String { R.isRussian ? "Ошибка передачи фотографии" : "Photo transmission error" }
    }
    
    enum Shared {
        static var photoSave: String { R.isRussian ? "Фото успешно сохранено" : "Photo saved successfully" }
        static var photoMail: String { R.isRussian ? "Фото успешно отправлено по почте" : "The photo was successfully sent by mail" }
        static var photoAirDrop: String { R.isRussian ? "Фото успешно отправлено по AirDrop" : "The photo was successfully sent by AirDrop" }
        static var actionDone: String { R.isRussian ? "Действие выполнено успешно" : "The action was completed successfully" }
        static var actionNotDone: String { R.isRussian ? "Действие не было совершено" : "The action was not performed" }
    }
}
