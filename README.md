# "Копейка" (Coin Saver)
## Контроль личных финансов
#### Разработчики: Данилов Сергей, Средницкий Алексей

### Задача приложения:
#### *управление личными финансами за счет учета доходов и расходов, потсановки целей и контроля расходов*.

### Функциональные модкли приложения:

1.	Авторизация/регистрация (для авторизации используем )
2.	Get started. Выбор внешнего вида -> установка начального бюджета -> выбор нужных категорий расходов (из предложенных либо добавление своих) -> установка начальных целей (лимит трат, сколько % от бюджета нужно сберечь, например) -> настройка нужного уровня. После мастера настроек конфигурацию для профиля можно хранить в json файле
3.	Главный экран. Хедер: отображение бюджета + остатка + границы. Тело: установленные цели и прогресс по ним.
4.	Экран с категориями. В каждую категорию записываются затраты. Для каждой категории отображается общая сумма трат.
5.	Экран истории трат. Фильтры: по дню/неделе/месяцу/году (записи храним в БД), по категориям, по убыванию/возрастанию.   
6.	Личный кабинет: настройки внешнего вида, настройки уведомлений (уровень уведомлений), настройки аккаунта
7.	Уведомления. Отправлять при достижении какого-либо лимита/цели.

### Страницы приложения:

#### Board (Main page)
![Board.jpg](https://github.com/iOS-HSE/CoinSaver/blob/master/screens/board.jpg)
#### Start page (Если пользователеь еще не вошел)
![Board.jpg](https://github.com/iOS-HSE/CoinSaver/blob/master/screens/start.jpg)
#### Budget (Выбрать категории траты)
![Board.jpg](https://github.com/iOS-HSE/CoinSaver/blob/master/screens/budget.jpg)
#### Goals (Цели)
![Board.jpg](https://github.com/iOS-HSE/CoinSaver/blob/master/screens/goals.jpg)
#### Settings (Настройки)
![Board.jpg](https://github.com/iOS-HSE/CoinSaver/blob/master/screens/settings.jpg)
#### Sign in (Вход)
![Board.jpg](https://github.com/iOS-HSE/CoinSaver/blob/master/screens/sign%20in.jpg)
#### Sign up (Регистрация)
![Board.jpg](https://github.com/iOS-HSE/CoinSaver/blob/master/screenssign%20up.jpg)
#### Success (Успешное действие)
![Board.jpg](https://github.com/iOS-HSE/CoinSaver/blob/master/screens/success.jpg)


