#Использовать logos
#Использовать reflector
#Использовать "./internal"

Перем Лог;

Перем Настройки; // Соответствие
Перем СинонимыПараметров; // Массив строка 
Перем ИндексПолей; // Соответствие ключа и типа элемента массива
Перем ИндексСинонимовПолей; // Соответствие синонимов полей и наименования полей
Перем КонструкторИспользован; // Булево, признак использования объекта при чтении из соответсвтия
Перем ИнтерфейсКонструктора; // Класс объект ИнтерфейсОбъекта
Перем МожетСодержатьПроизвольныеПоля; // Булево, признак возможность не указывать поля

#Область Работа_с_конструктором_параметров

// Создает и возвращает новый экземпляр конструктора параметров
//
//  Возвращаемое значение:
//   Объект.КонструкторПараметров - ссылка на новый элемент класса <КонструкторПараметров>
//
Функция НовыеПараметры() Экспорт
	
	НовыйЭлемент = Новый КонструкторПараметров();
	
	Возврат НовыйЭлемент;

КонецФункции


// (Заготовка) Устанавливает дополнительное наименование узла параметров 
//
// Параметры:
//   НовоеСинонимыПараметров - Строка - дополнительное наименование параметров в файле
//
//  Возвращаемое значение:
//   Объект.КонструкторПараметров - ссылка на текущий элемент класса <КонструкторПараметров>
//
Функция НаименованиеУзла(Знач НовоеСинонимыПараметров) Экспорт

	СинонимыПараметров = НовоеСинонимыПараметров;
	Возврат ЭтотОбъект;

КонецФункции

// Выполняет заполнение описания параметров из произвольного объекта
//
// Параметры:
//   КлассОбъект - Объект - произвольный класс, реализуемый интерфейс Конструктора
//
//  Возвращаемое значение:
//   Объект.КонструкторПараметров - ссылка на текущий элемент класса <КонструкторПараметров>
//
Функция ИзКласса(КлассОбъект) Экспорт
	
	РефлекторОбъекта = Новый РефлекторОбъекта(КлассОбъект);
	РезультатПроверки = РефлекторОбъекта.РеализуетИнтерфейс(ИнтерфейсКонструктора);

	Если Не РезультатПроверки Тогда
		ВызватьИсключение СтрШаблон("Класс <%1> не реализовывает интерфейс <%2>", КлассОбъект, ИнтерфейсКонструктора);
	КонецЕсли;
	
	КлассОбъект.ОписаниеПараметров(ЭтотОбъект);

	Возврат ЭтотОбъект;

КонецФункции

// Копирует текущий конструктор параметров
//
//  Возвращаемое значение:
//   Объект.КонструкторПараметров - ссылка на текущий элемент класса <КонструкторПараметров>
//
Функция Скопировать() Экспорт
		
	Лог.Отладка("Выполняю копирование элемента конструтор парамеров");
	НовыйЭлемент = НовыеПараметры();

	Если МожетСодержатьПроизвольныеПоля Тогда
		НовыйЭлемент.ПроизвольныеПоля();
	КонецЕсли;

	СкопироватьПоля(НовыйЭлемент);

	Возврат НовыйЭлемент;

КонецФункции

// Устанавливает признак содержания произвольных полей конструктора параметров
//
//  Возвращаемое значение:
//   Объект.КонструкторПараметров - ссылка на текущий элемент класса <КонструкторПараметров>
//
Функция ПроизвольныеПоля() Экспорт
	МожетСодержатьПроизвольныеПоля = Истина;
	Возврат ЭтотОбъект;
КонецФункции

#КонецОбласти

#Область Работа_с_текущем_полем_настройки

// Создает и возвращает новое поле-строка конструктора параметров
//
// Параметры:
//   ИмяПоля     - Строка - имя поля, возможно передача нескольких через пробел.
//   ТипЭлемента - Строка - значение поля по умолчанию
//
//  Возвращаемое значение:
//   Объект.ПолеКонструктораПараметров - ссылка на текущий элемент класса <ПолеКонструктораПараметров>
//
Функция ПолеМассив(Знач ИмяПоля, Знач ТипЭлемента) Экспорт


	ОбъектПоля = Неопределено;

	Если Не ЭтоПростойТип(ТипЭлемента) Тогда
			
		ОбъектПоля = ПолучитьПолеИзОбъекта(ТипЭлемента);

		ТипЭлемента = Тип("КонструкторПараметров");
	
	КонецЕсли;

	ТипПоля = Тип("Массив");
	ЗначениеПоУмолчанию = Новый Массив;

	Лог.Отладка("Добавляю поле <%1> тип <%2> ТипЭлементов <%3>", ИмяПоля, ТипПоля, ТипЭлемента);

	Возврат Поле(ИмяПоля, ТипПоля, ЗначениеПоУмолчанию, ТипЭлемента, ОбъектПоля);

КонецФункции

// Создает и возвращает новое поле-строка конструктора параметров
//
// Параметры:
//   ИмяПоля             - Строка - имя поля, возможно передача нескольких через пробел.
//   ЗначениеПоУмолчанию - строка - значение поля по умолчанию
//
//  Возвращаемое значение:
//   Объект.ПолеКонструктораПараметров - ссылка на текущий элемент класса <ПолеКонструктораПараметров>
//
Функция ПолеСтрока(Знач ИмяПоля, ЗначениеПоУмолчанию = "") Экспорт

	Возврат Поле(ИмяПоля, Тип("Строка"), ЗначениеПоУмолчанию);

КонецФункции

// Создает и возвращает новое поле-число конструктора параметров
//
// Параметры:
//   ИмяПоля             - Строка - имя поля, возможно передача нескольких через пробел.
//   ЗначениеПоУмолчанию - Число - значение поля по умолчанию
//
//  Возвращаемое значение:
//   Объект.ПолеКонструктораПараметров - ссылка на текущий элемент класса <ПолеКонструктораПараметров>
//
Функция ПолеЧисло(Знач ИмяПоля, ЗначениеПоУмолчанию = 0) Экспорт

	Возврат Поле(ИмяПоля, Тип("Число"), ЗначениеПоУмолчанию);

КонецФункции

// Создает и возвращает новое поле-дата конструктора параметров
//
// Параметры:
//   ИмяПоля             - Строка - имя поля, возможно передача нескольких через пробел.
//   ЗначениеПоУмолчанию - Дата - значение поля по умолчанию
//
//  Возвращаемое значение:
//   Объект.ПолеКонструктораПараметров - ссылка на текущий элемент класса <ПолеКонструктораПараметров>
//
Функция ПолеДата(Знач ИмяПоля, ЗначениеПоУмолчанию = Неопределено) Экспорт

	Если Не ЗначениеЗаполнено(ЗначениеПоУмолчанию) Тогда
		ЗначениеПоУмолчанию = Дата("00010101");
	КонецЕсли;

	Возврат Поле(ИмяПоля, Тип("Дата"), ЗначениеПоУмолчанию);

КонецФункции

// Создает и возвращает новое поле-булево конструктора параметров
//
// Параметры:
//   ИмяПоля             - Строка - имя поля, возможно передача нескольких через пробел.
//   ЗначениеПоУмолчанию - Булево - значение поля по умолчанию
//
//  Возвращаемое значение:
//   Объект.ПолеКонструктораПараметров - ссылка на текущий элемент класса <ПолеКонструктораПараметров>
//
Функция ПолеБулево(Знач ИмяПоля, ЗначениеПоУмолчанию = Ложь) Экспорт

	Возврат Поле(ИмяПоля, Тип("Булево"), ЗначениеПоУмолчанию);

КонецФункции

// Создает и возвращает новое поле-объект конструктора параметров
//
// Параметры:
//   ИмяПоля             - Строка - имя поля, возможно передача нескольких через пробел.
//   ОбъектПоля          - Объект.КонструкторПараметров - ссылка на объект поле
//
//  Возвращаемое значение:
//   Объект.ПолеКонструктораПараметров - ссылка на текущий элемент класса <ПолеКонструктораПараметров>
//
Функция ПолеОбъект(Знач ИмяПоля, Знач ОбъектПоля) Экспорт

	ТипПоля = Тип("КонструкторПараметров");
	
	ОбъектПоля = ПолучитьПолеИзОбъекта(ОбъектПоля);

	Лог.Отладка("Добавляю поле объект <%1>, <%2>", ИмяПоля, ТипПоля);

	Возврат Поле(ИмяПоля, ТипПоля, ОбъектПоля, , ОбъектПоля);

КонецФункции

// Создает и возвращает новое поле конструктора параметров
//
// Параметры:
//   ИмяПоля             - Строка - имя поля, возможно передача нескольких через пробел.
//   ТипПоля             - ОписаниеТипов - тип создаваемого поля
//   ЗначениеПоУмолчанию - Строка, Число, Дата, Неопределено - значение по умолчанию для поля
//   ТипЭлемента         - ОписаниеТипов - тип для элементов поля массив
//   ОбъектПоля          - Объект.КонструкторПараметров - ссылка на объект поле
//
//  Возвращаемое значение:
//   Объект.ПолеКонструктораПараметров - ссылка на текущий элемент класса <ПолеКонструктораПараметров>
//
Функция Поле(Знач ИмяПоля,
			 Знач ТипПоля = Неопределено,
			 Знач ЗначениеПоУмолчанию = Неопределено,
			 Знач ТипЭлемента = Неопределено,
			 Знач ОбъектПоля = Неопределено) Экспорт

	Если ТипПоля = Неопределено 
		И ЗначениеПоУмолчанию = Неопределено Тогда
		ТипПоля = Тип("Строка");
	КонецЕсли;

	Если ТипПоля = Неопределено
		И Не ЗначениеПоУмолчанию = Неопределено Тогда
		ТипПоля = ТипЗнч(ЗначениеПоУмолчанию);
	КонецЕсли;

	НовоеПолеПараметров = Новый ПолеКонструктораПараметров(ЭтотОбъект,
														   ИмяПоля,
														   ТипПоля, 
														   ТипЭлемента,
														   ОбъектПоля);
	
	ДобавитьПолеВИндекс(НовоеПолеПараметров);
	НовоеПолеПараметров.УстановитьЗначение(ЗначениеПоУмолчанию);

	Настройки.Вставить(НовоеПолеПараметров.Имя, ЗначениеПоУмолчанию);

	Возврат НовоеПолеПараметров;

КонецФункции

// Удаляет поле из конструктора параметров
//
// Параметры:
//   ИмяПоля - Строка - имя поля, возможно передача синонима поля.
//
//  Возвращаемое значение:
//   Объект.КонструкторПараметров - ссылка на текущий элемент класса <КонструкторПараметров>
//
Функция УдалитьПоле(Знач ИмяПоля) Экспорт

	УдаляемоеПоле = ИндексСинонимовПолей[ИмяПоля];

	Если УдаляемоеПоле = Неопределено Тогда
		Возврат ЭтотОбъект;
	КонецЕсли;

	ИндексПолей.Удалить(УдаляемоеПоле);
	Настройки.Удалить(УдаляемоеПоле);

	Возврат ЭтотОбъект;

КонецФункции

// Возвращает индекс полей конструктора параметров
//
//  Возвращаемое значение:
//   Соответствие - текущий индекс полей 
//
Функция ПолучитьИндексПолей() Экспорт

	Возврат ИндексПолей;

КонецФункции

#КонецОбласти

#Область Работа_с_чтением_и_выгрузкой_параметров

// Преобразовывает структуру параметров в структуру
//
//  Возвращаемое значение:
//   Структура - значение параметров в структуре
//
Функция ВСтруктуру() Экспорт

	ИсходящаяСтруктура = Новый Структура;

	Если МожетСодержатьПроизвольныеПоля Тогда
		Возврат ВСоответствие();
	КонецЕсли;

	Для каждого КлючЗначение Из Настройки Цикл

		Значение = КлючЗначение.Значение;

		ЗначениеКлюча = ЗначениеВСтруктуру(Значение);

		ИсходящаяСтруктура.Вставить(КлючЗначение.Ключ, ЗначениеКлюча);

	КонецЦикла;

	Возврат ИсходящаяСтруктура;

КонецФункции

// Преобразовывает структуру параметров в соответствие
//
//  Возвращаемое значение:
//   Соответствие - значение параметров в соответствии
//
Функция ВСоответствие() Экспорт
	
	СоответствиеРезультат = Новый Соответствие;

	Для каждого КлючЗначение Из Настройки Цикл

		Значение = КлючЗначение.Значение;

		ЗначениеКлюча = ЗначениеВСоответствие(Значение);

		СоответствиеРезультат.Вставить(КлючЗначение.Ключ, ЗначениеКлюча);

	КонецЦикла;

	Возврат СоответствиеРезультат;

КонецФункции

// (Заготовка) Выполняет чтение значений параметров из структуры
//
// Параметры:
//   ВходящаяСтруктура - Структура - структура со значениями параметров
//
//  Возвращаемое значение:
//   Объект.КонструкторПараметров - ссылка на текущий объект <КонструкторПараметров>
//
Функция ИзСтруктуры(Знач ВходящаяСтруктура) Экспорт
	
	Лог.Информация("Данная функция не реализована. Количество элементов в структуре <%1>", ВходящаяСтруктура.Количество());

	Возврат ЭтотОбъект;
	
КонецФункции

// Выполняет чтение значений параметров из соответствия
//
// Параметры:
//   ВходящиеСоответствие - Соответствия - соответствие со значениями параметров
//
//  Возвращаемое значение:
//   Объект.КонструкторПараметров - ссылка на текущий объект <КонструкторПараметров>
//
Функция ИзСоответствия(Знач ВходящиеСоответствие) Экспорт

	КонструкторИспользован = Истина;

	ПрочитатьИзСоответствия(ВходящиеСоответствие);

	ПоказатьНастройкиВРежимеОтладки(Настройки);

	Возврат ЭтотОбъект;

КонецФункции

// Возвращает признак использования объекта при конвертации из соответствия
//
// Возвращаемое значение:
//   Булево - признак использования объекта при конвертации из соответствия
//
Функция Использован() Экспорт
	Возврат КонструкторИспользован;
КонецФункции

#КонецОбласти

#Область Вспомогательные_процедуры_и_функции

// Добавляет синонимы поля в индекс полей
//
// Параметры:
//   ПолеПараметров - Объект.ПолеКонструктораПараметров - класс <ПолеКонструктораПараметров> для чтения синонимов
//
Процедура ДобавитьСинонимыПоляВИндекс(Знач ПолеПараметров) Экспорт

	ИмяПоля = ПолеПараметров.Имя;

	Лог.Отладка("Количество <%1> синонимов поля <%2>", ПолеПараметров.Синонимы.Количество(), ИмяПоля);

	Для каждого Синоним Из ПолеПараметров.Синонимы Цикл
		Лог.Отладка("Добавляю синонимы <%1> для поля <%2>", Синоним, ИмяПоля);
		ИндексСинонимовПолей.Вставить(Синоним, ИмяПоля);
	КонецЦикла;

КонецПроцедуры

Функция НайтиПолеВИндексеПолей(Знач ИмяПоля)

	ИмяПоляВИндексе = ИндексСинонимовПолей[ИмяПоля];

	Лог.Отладка("Имя поля <%1> в индексе для ключа <%2>", ИмяПоляВИндексе, ИмяПоля);

	Если ИмяПоляВИндексе = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;

	Возврат ИндексПолей[ИмяПоляВИндексе];

КонецФункции

Процедура СкопироватьПоля(НовыйЭлемент)

	Для каждого ПолеПараметра Из ИндексПолей Цикл
		
		КлассПоля = ПолеПараметра.Значение;

		ОписаниеПоля = КлассПоля.ОписаниеПоля();
		
		Если ТипЗнч(ОписаниеПоля.ОбъектЭлемента) = Тип("КонструкторПараметров") Тогда
			ОбъектЭлемента = ОписаниеПоля.ОбъектЭлемента.Скопировать();
		Иначе
			ОбъектЭлемента = ОписаниеПоля.ОбъектЭлемента;
		КонецЕсли;

		Лог.Отладка("Копирую поле: 
		| - Имя: <%1>
		| - Тип: <%2>
		| - ЗначениеПоУмолчанию: <%3>
		| - ТипЭлемента: <%4>
		| - ОбъектЭлемента: <%5>",
		ОписаниеПоля.Имя,
		ОписаниеПоля.Тип,
		ОписаниеПоля.ЗначениеПоУмолчанию,
		ОписаниеПоля.ТипЭлемента,
		ОбъектЭлемента);

		НовыйЭлемент.Поле(ОписаниеПоля.Имя,
						  ОписаниеПоля.Тип,
						  ОписаниеПоля.ЗначениеПоУмолчанию,
						  ОписаниеПоля.ТипЭлемента,
						  ОбъектЭлемента
						  );

	КонецЦикла;

КонецПроцедуры

Процедура ДобавитьПолеВИндекс(ПолеПараметров)
	
	ИндексПолей.Вставить(ПолеПараметров.Имя, ПолеПараметров);

	ДобавитьСинонимыПоляВИндекс(ПолеПараметров);

КонецПроцедуры

Функция ПолучитьПолеПараметровИзКласса(КлассОбъект)
	
	ИмяПараметров = Строка(ТипЗнч(КлассОбъект));

	РефлекторОбъекта = Новый РефлекторОбъекта(КлассОбъект);

	РезультатПроверки = РефлекторОбъекта.РеализуетИнтерфейс(ИнтерфейсКонструктора);

	Если Не РезультатПроверки Тогда
		ВызватьИсключение СтрШаблон("Класс <%1> не реализовывает интерфейс <%2>", КлассОбъект, ИнтерфейсКонструктора);
	КонецЕсли;
	
	КонструкторПараметровКласса = НовыеПараметры();
	
	КлассОбъект.ОписаниеПараметров(КонструкторПараметровКласса);

	Возврат КонструкторПараметровКласса;
	
КонецФункции

Функция ПолучитьПолеИзОбъекта(ОбъектПоля)

	ТипОбъекта = ТипЗнч(ОбъектПоля);
	
	Лог.Отладка("Тип объекта: <%1>", ТипОбъекта);
	Лог.Отладка("Поле объект: <%1>", ОбъектПоля);

	Если Тип("ПолеКонструктораПараметров") = ТипОбъекта Тогда

		Возврат ОбъектПоля.Конструктор().Скопировать(); 

	ИначеЕсли Тип("КонструкторПараметров") = ТипОбъекта Тогда
	
		Возврат ОбъектПоля.Скопировать();
	
	КонецЕсли;

	Возврат ПолучитьПолеПараметровИзКласса(ОбъектПоля); 

КонецФункции

Функция ЗначениеВСоответствие(Значение)

	ТипЗначения = ТипЗнч(Значение);

	Если ТипЗначения = Тип("Массив") Тогда

		МассивЗначений = Новый Массив;

		Для Каждого ЭлМассива Из Значение Цикл

			МассивЗначений.Добавить(ЗначениеВСоответствие(ЭлМассива));

		КонецЦикла;

		Возврат МассивЗначений;

	ИначеЕсли ТипЗначения = Тип("КонструкторПараметров") Тогда

		Возврат Значение.ВСоответствие();

	Иначе

		Возврат Значение;

	КонецЕсли;

КонецФункции

Функция ЗначениеВСтруктуру(Значение)

	ТипЗначения = ТипЗнч(Значение);

	Если ТипЗначения = Тип("Массив") Тогда

		МассивЗначений = Новый Массив;

		Для Каждого ЭлМассива Из Значение Цикл

			МассивЗначений.Добавить(ЗначениеВСтруктуру(ЭлМассива));

		КонецЦикла;

		Возврат МассивЗначений;

	ИначеЕсли ТипЗначения = Тип("КонструкторПараметров") Тогда

		Возврат Значение.ВСтруктуру();

	Иначе

		Возврат Значение;

	КонецЕсли;

КонецФункции

Процедура ПрочитатьИзСоответствия(Знач ВходящиеСоответствие)

	Лог.Отладка("Всего полей <%1>", ИндексПолей.Количество());
	Лог.Отладка("Всего синонимов полей <%1>", ИндексСинонимовПолей.Количество());

	Для каждого КлючЗначение Из ВходящиеСоответствие Цикл

		ИмяКлюча = КлючЗначение.Ключ;
		Значение = КлючЗначение.Значение;
		Лог.Отладка("Загружаю поле <%1>, <%2>", ИмяКлюча, Значение);
		
		ПолеПараметров = НайтиПолеВИндексеПолей(ИмяКлюча);
				
		Если ПолеПараметров = Неопределено Тогда
		
			Если МожетСодержатьПроизвольныеПоля Тогда
				Настройки.Вставить(ИмяКлюча, Значение);
			Иначе
				Лог.Отладка("Поле <%1> в индексе не найдено", ИмяКлюча);
			КонецЕсли;

			Продолжить;
		
		КонецЕсли;

		ЗначениеПараметра = ПреобразоватьЗначение(Значение, ПолеПараметров);

		ПолеПараметров.УстановитьЗначение(ЗначениеПараметра);

		ДобавитьВНастройкуЗначение(ПолеПараметров, ЗначениеПараметра);

	КонецЦикла;

КонецПроцедуры

Процедура ДобавитьВНастройкуЗначение(ПолеПараметров, ЗначениеПараметра, ВключаяСинонимы = Ложь)

	Если ВключаяСинонимы Тогда

		Для каждого Синоним Из ПолеПараметров.Синонимы Цикл

			Настройки.Вставить(Синоним, ЗначениеПараметра);
			
		КонецЦикла;
	Иначе
		
		Настройки.Вставить(ПолеПараметров.Имя, ЗначениеПараметра);
		
	КонецЕсли;
	
КонецПроцедуры

Функция ПреобразоватьЗначение(Значение, ПолеПараметров, ТипЗначения = Неопределено)

	Если ТипЗначения = Неопределено Тогда

		ТипЗначения = ПолеПараметров.Тип;

	КонецЕсли;
	
	Лог.Отладка("Тип значение <%1> 
	|	Тип значения из поля: <%2> 
	|	Тип значения: <%3>", ТипЗначения, ПолеПараметров.Тип, ТипЗнч(Значение));

	Если ТипЗначения = Тип("Строка") Тогда

		Возврат ?(ТипЗнч(Значение) = Тип("Строка"), Значение, Строка(Значение));

	ИначеЕсли ТипЗначения = Тип("Дата") Тогда

		Если ТипЗнч(Значение) = Тип("Дата") Тогда
			Возврат Значение;
		КонецЕсли;

		Возврат СтрокаВДату(Значение);
	
	ИначеЕсли ТипЗначения = Тип("Число") Тогда

		Возврат Число(Значение);

	ИначеЕсли ТипЗначения = Тип("Булево") Тогда

		Возврат ?(ТипЗнч(Значение) = Тип("Булево"), Значение, Булево(Значение));

	ИначеЕсли ТипЗначения = Тип("Массив") Тогда

		Возврат ПреобразоватьМассив(Значение, ПолеПараметров);

	ИначеЕсли ТипЗначения = Тип("КонструкторПараметров") Тогда

		Возврат ПолеПараметров.ИзСоответствия(Значение);
	
	Иначе

		ВызватьИсключение СтрШаблон("Не правильный тип настройки поля <%1>", Строка(ТипЗначения));

	КонецЕсли;

КонецФункции

Функция ПреобразоватьМассив(ВходящийМассив, ПолеПараметров)

	МассивЗначений = Новый Массив;
	ТипЭлементовМассива = ПолеПараметров.ТипЭлемента;
	
	Лог.Отладка("Обрабатываю массив количество <%1> ", ВходящийМассив.Количество());
		
	Для каждого ЭлементМассива Из ВходящийМассив Цикл
		
		МассивЗначений.Добавить(ПреобразоватьЗначение(ЭлементМассива, ПолеПараметров, ТипЭлементовМассива));

	КонецЦикла;

	Возврат МассивЗначений;

КонецФункции

Функция ЭтоПростойТип(ТипЗначения)

	Возврат ТипЗначения = Тип("Строка")
			ИЛИ ТипЗначения = Тип("Число")
			ИЛИ ТипЗначения = Тип("Дата")
			ИЛИ ТипЗначения = Тип("Булево")
			ИЛИ ТипЗначения = Тип("Строка");
	
КонецФункции

Процедура ПоказатьНастройкиВРежимеОтладки(ЗначенияПараметров)
	
	ПроцессорВывода = Новый ВыводВРежимеОтладки(Лог);
	ПроцессорВывода.ПоказатьНастройкиВРежимеОтладки(ЗначенияПараметров);

КонецПроцедуры

Процедура ПриСозданииОбъекта()

	Настройки = Новый Соответствие;
	ИндексПолей = Новый Соответствие;
	ИндексСинонимовПолей = Новый Соответствие;

	КонструкторИспользован = Ложь;
	МожетСодержатьПроизвольныеПоля = Ложь;

	ИнтерфейсКонструктора = Новый ИнтерфейсОбъекта;
	ИнтерфейсКонструктора.ПроцедураИнтерфейса("ОписаниеПараметров", 1);

КонецПроцедуры

// Процедура СтрокаВДату преобразует строку в дату по шаблону форматной строки
Функция СтрокаВДату(Знач Значение)
	
	// Поиск.
	Попытка
		Возврат Дата(Лев(Значение, 4) + Сред(Значение, 06, 2) + Сред(Значение, 09, 2) + 
					 Сред(Значение, 12, 2) + Сред(Значение, 15, 2) + Сред(Значение, 18, 2));
	Исключение
		ВызватьИсключение ИсключениеНекорректныйФорматДаты(Значение);
	КонецПопытки;
КонецФункции 

Функция ИсключениеНекорректныйФорматДаты(Значение)

	Возврат СтрШаблон("Некорректный формат даты [%1]", Значение);

КонецФункции 

#КонецОбласти

Лог = Логирование.ПолучитьЛог("oscript.lib.configor.constructor");
