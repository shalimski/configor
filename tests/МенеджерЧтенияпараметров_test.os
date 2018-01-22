#использовать "../src"
#Использовать asserts
#Использовать logos
#Использовать tempfiles

Перем юТест;
Перем Лог;

Функция ПолучитьСписокТестов(Знач Тестирование) Экспорт

	юТест = Тестирование;

	ИменаТестов = Новый Массив;

	ИменаТестов.Добавить("ТестДолжен_ПроверитьПолучениеПараметровИзИндекса");
	// ИменаТестов.Добавить("ТестДолжен_ПроверитьПарсингОпций");
	// ИменаТестов.Добавить("ТестДолжен_ПроверитьПарсингМассивовОпций");

	Возврат ИменаТестов;

КонецФункции

Процедура ТестДолжен_ПроверитьПолучениеПараметровИзИндекса() Экспорт

	ТестовыеСлучаи = Новый Массив;
	ТестовыеСлучаи.Добавить(ТестовыйСлучай("{ ""version"": ""1.0"" }", "version", "1.0"));
	ТестовыеСлучаи.Добавить(ТестовыйСлучай("{ ""version"": 1.0,
	|	""values"": 
	|		{ ""import"": ""тест"" }
	|
	|}", "values.import", "тест"));

	ТестовыеСлучаи.Добавить(ТестовыйСлучай("{ ""version"": 1.0,
	|	""values"": [
	|		{ ""import"": ""тестмассива0"" },
	|		{ ""import"": ""тестмассива1"" }
	|
	|		]
	|
	|}", "values.0.import values.1.import", "тестмассива0 тестмассива1"));
	ТестовыеСлучаи.Добавить(ТестовыйСлучай("{ ""version"": 1.0,
	|	""values"": [
	|		{ ""import"": ""тестмассива0"" },
	|		{ ""test"": ""тестмассива1"" }
	|		]
	|}", "values.0.import values.1.test", "тестмассива0 тестмассива1"));
	

	МенеджерПараметров = Новый МенеджерЧтенияПараметров();

	Для каждого Тест Из ТестовыеСлучаи Цикл

		ТестовыйФайл = ПодготовитьТестовыйФайл(Тест.ТекстФайлаПроверки);
		МенеджерПараметров.УстановитьФайлПараметров(ТестовыйФайл);
		МенеджерПараметров.Прочитать();

		Для ИндексПараметра = 0 По Тест.ИменаПараметров.ВГраница() Цикл
			
			ЗначениеПараметра = МенеджерПараметров.Параметр(Тест.ИменаПараметров[ИндексПараметра]);
			Утверждения.ПроверитьРавенство(ЗначениеПараметра, Тест.Результаты[ИндексПараметра], СтрШаблон("Результат должен совпадать с ожиданиями. Для текста <%1>", Тест.ТекстФайлаПроверки));

		КонецЦикла;

	
	КонецЦикла

КонецПроцедуры

Функция ПодготовитьТестовыйФайл(Знач ТестФайла)

	ТестовыйФайл = ВременныеФайлы.НовоеИмяФайла("json");
	
	ЗаписьТекста = Новый ЗаписьТекста;
	ЗаписьТекста.Открыть(ТестовыйФайл);
	ЗаписьТекста.ЗаписатьСтроку(ТестФайла);
	ЗаписьТекста.Закрыть();

	Возврат ТестовыйФайл;

КонецФункции

Функция ТестовыйСлучай(Знач ТекстФайлаПроверки, Знач ИменаПараметров, Знач Результаты)

	Тест = Новый Структура;
	Тест.Вставить("ТекстФайлаПроверки", ТекстФайлаПроверки);
	Тест.Вставить("ИменаПараметров", СтрРазделить(ИменаПараметров, " "));
	Тест.Вставить("Результаты", СтрРазделить(Результаты, " "));

	Возврат Тест;

КонецФункции

Лог = Логирование.ПолучитьЛог("oscript.lib.configor");
Лог.УстановитьУровень(УровниЛога.Отладка);