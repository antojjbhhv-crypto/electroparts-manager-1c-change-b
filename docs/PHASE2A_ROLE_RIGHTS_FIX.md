# Роль Korrektur — исправление прав и проверка

**Дата:** 2026-11-21  
**Файл:** `work-config\Roles\Korrektur\Ext\Rights.xml`  
**База проверки:** `test-ib-d3-role` (копия `test-ib-d3`)

## Исходное состояние

В роли было три объекта:

| Объект | Права |
|---|---|
| `InformationRegister.KorrekturJournal` | Read, View |
| `DataProcessor.Korrektur` | Use, View |
| `Catalog.Komponenten` | Read, View |

Этого недостаточно: обработка создаёт и проводит документы `Verbrauch`/`Wareneingang`, пишет движения в `AccumulationRegister.Bestaende` и обновляет запись журнала.

## Что исправлено

Новый состав роли (sha256 `4139edebb065df9b2bc92d095f70ef6640a11ca5117dca46f24e862d20c5adc8`, 2 091 байт):

| Объект | Права |
|---|---|
| `AccumulationRegister.Bestaende` | Read, Update, View |
| `Catalog.Komponenten` | Read, View (без изменений) |
| `DataProcessor.Korrektur` | Use, View (без изменений) |
| `Document.Verbrauch` | Read, Insert, Update, **Posting**, View |
| `Document.Wareneingang` | Read, Insert, Update, **Posting**, View |
| `InformationRegister.KorrekturJournal` | Read, **Update**, View |

## Ключевые находки при загрузке

1. **Право проведения в XML называется `Posting`, а не `Post`.** При загрузке с `<name>Post</name>` платформа право молча отбрасывала: `DumpConfigToFiles` из базы показывал документы без права проведения. После замены на `Posting` оба документа сохраняют право — проверено дампом.
2. **Опечатка `Document.Verrauch`.** Первая загрузка дала предупреждение «Неизвестный объект метаданных — Document.Verrauch»; права документа не применялись. Исправлено на `Document.Verbrauch`, повторная загрузка чистая.

## Проверка

- Загрузка `work-config` в `test-ib-d3-role`: exit 0, предупреждений нет (`role_load4.log`).
- `DumpConfigToFiles` из базы (`temp\role-verify3`, sha256 `856333e6c1c519ecdbcb51505b696c3018c40f891da2a445678532cf82a7a4ef`): все четыре целевых объекта присутствуют с ожидаемыми правами, включая `Posting` у обоих документов.
- Поведенческая проверка прав **NOT_RUN**: в конфигурации нет справочника `Пользователи`, роль невозможно назначить пользователю; проверка ограничена структурной сверкой принятых прав.

## Хеши

- `work-config\Roles\Korrektur\Ext\Rights.xml`: 2 091, `4139edeb…adc8`
- Дамп из базы: 2 193, `856333e6…a4ef`
- `test-ib-d3-role\1Cv8.1CD`: 4 308 992, `8d2eb7825f1f6d459af815cc9ea05846ce94719d6093b0686c82b25e708d1048`
- `test-ib-d3-role\1Cv8Log\20261116000000.lgp`: 78 259, `1c6c1e02698ecb07cfa29badea58534f45c35bfae5633420fcfc3a406ec10676`
