# Реализация дополнительной стратегии oAuth 2.0

Стратегия: [passport-vkontakte](http://www.passportjs.org/packages/passport-vkontakte/)

Параметры стратегии:

options - реквизиты приложения, verify - функция проверки пользователя

Endpoints:

- `/auth/yandex` - вход через Яндекс
- `/auth/yandex/callback` - маршрут, по которому осуществляется перенаправление после авторизации
- `/auth/vkontakte` - вход через Вконтакте
- `/auth/vkontakte/callback` - маршрут, по которому осуществляется перенаправление после авторизации
