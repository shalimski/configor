Перем ИндексФайлов;

Функция ПолучитьКлассФайла(Знач ИмяФайла, Знач ВерсияФайла) Экспорт

	ДанныеИндекса = ИндексФайлов[ИмяФайла];

	Если ДанныеИндекса = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;

	ИмяКлассаФайла = ДанныеИндекса[ВерсияФайла];

	Если ИмяКлассаФайла = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;

	Возврат Новый (ИмяКлассаФайла);

КонецФункции

Процедура ДобавитьФайлВИндекс(Знач ИмяФайла, Знач ВерсияФайла, Знач ИмяКлассаФайла)

	ДанныеИндекса = ИндексФайлов[ИмяФайла];

	Если ДанныеИндекса = Неопределено Тогда
		ДанныеИндекса = Новый Соответствие;
	КонецЕсли;

	ДанныеИндекса.Вставить(ВерсияФайла, ИмяКлассаФайла);

КонецПроцедуры

Процедура Инциализация()
	
	ИндексФайлов = Новый Соответствие;

	///////////////////////////////////
	// БЛОК АВТОМАТИЧЕСКОЙ ГЕНЕРАЦИИ //
	///////////////////////////////////

	// {НАЧАЛО_БЛОК}
	// {БЛОК}
	// {КОНЕЦ_БЛОК}

КонецПроцедуры

Инциализация();



