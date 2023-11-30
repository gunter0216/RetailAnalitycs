# RetailAnalitycs

В данном проекте реализован web-интерфейс для ранее созданной базы данных.<br>
Приложение поддерживает CRUD-операции, импорт/экспорт таблиц, авторизацию, запуск операций/функций базы через графический интерфейс, а также логирование действий пользователя.<br>
Web-приложение реализовано с использованием **ASP.NET MVC Framework**.<br>
В качестве ORM фреймворка выбран **Entity Framework Core**<br>
SPA-frontend реализован на **Angular**.

### Авторизация
Существуют два заранее созданных аккаунта
- Username - admin, Password - admin
- Username - user,  Password - user

![image info](./misc/images/1.jpeg)

### Retail Analytics
Вкладка *Retail Analytics* включается в себя все доступные вкладки

user:
![image info](./misc/images/2.jpeg)

admin:
![image info](./misc/images/6.jpeg)

### Tables
Вкладка *Tables* показывает все доступные таблицы базы данных.<br>
User способен только просматривать таблицы.<br>
Admin способен редактировать таблицы, импортировать и экспортировать.

![image info](./misc/images/3.jpeg)

Таблица sku(user):
![image info](./misc/images/5.jpeg)

Таблица sku(admin):
![image info](./misc/images/8.jpeg)

Таблица sku, редактирование(admin):
![image info](./misc/images/9.jpeg)

### Offers
Вкладка *Offers* показывает 3 функции базы данных и позволяет их выполнять и экспортировать.<br>
Доступна только *admin*.

![image info](./misc/images/7.jpeg)

Функция Cross-selling
![image info](./misc/images/10.jpeg)

### About
Вкладка *About* показывает информацию о разработчиках

![image info](./misc/images/4.jpeg)

### Логирование
В контейнере api в папке app/logs каждый день создаётся новый файл с логами.

![image info](./misc/images/11.png)
