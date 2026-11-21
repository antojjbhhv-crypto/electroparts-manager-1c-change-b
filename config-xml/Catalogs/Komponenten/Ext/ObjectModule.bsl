Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если Mindestbestand < 0 Тогда
		Отказ = Истина;
		Сообщить("Mindestbestand darf nicht negativ sein.");
		Возврат;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Lieferant) Тогда
		СтарыйПоставщик = Справочники.Lieferanten.ПустаяСсылка();
		Если ЗначениеЗаполнено(Ссылка) Тогда
			СтарыйПоставщик = Ссылка.ПолучитьОбъект().Lieferant;
		КонецЕсли;
		
		Если СтарыйПоставщик <> Lieferant И Не Lieferant["Aktiv"] Тогда
			Отказ = Истина;
			Сообщить("Inaktiver Lieferant kann einem neuen Artikel nicht zugeordnet werden.");
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры
