# CHANGE_B_KORREKTUR_FORM_HANDLER_FIX

- Дата: 2026-11-21. Область: `implementation-b\work-config`, `implementation-b\test-ib-d3`.
- Основание: прямое решение владельца — «узкая правка одобрена», устранение ошибки компиляции обработчика формы `Korrektur`.
- Статус: **код исправлен, загружен, компилируется**; повторный вызов — за оператором.

## 1. Preflight (выполнено фактически)

| Файл | SHA-256 до правки | Размер |
|---|---|---|
| `DataProcessors\Korrektur\Forms\Форма\Ext\Form.xml` | `d57583f7189fbffd30f3e415dc2ae4923f1d16c5292254378d8545f053f4df43` | 4613 |
| `DataProcessors\Korrektur\Forms\Форма\Ext\Form\Module.bsl` | `d67ae81685c43cdfd33d039dcdb2a9883206f25bcda61348b0f45edc35bb69d9` | 689 |
| `DataProcessors\Korrektur\Ext\ObjectModule.bsl` | `284d27b4270fa6af1609158a0fc52fe209db5443ae5cd0bc4f0c4c2f65aad99c` | 5313 |

Резервная копия трёх файлов: `backup\handler_fix_2026-11-21_1121\` (`Form.xml`, `Module.bsl`, `ObjectModule.bsl`).

Исходное состояние `test-ib-d3` зафиксировано: `1Cv8.1CD` SHA-256 `e053deaf4bda01a1192f69d0ff3b1c1f9ecf6a0cf2109957d6539a8b363ae1b3` (снимок базы до правки — `backup\test-ib_pre_fixture_2026-11-21_1047\` и `dump_d3`).

## 2. Изменения (только два)

1. `Forms\Форма\Ext\Form\Module.bsl` — строка 2: `Процедура Выполнить(Команда)` → `Процедура ВыполнитьКорректировку(Команда)`. Имя `Выполнить` совпадает со встроенной процедурой платформы и не компилировалось в контексте модуля формы (ошибка `(2,11): Ожидается имя процедуры`).
2. `Forms\Форма\Ext\Form.xml` — у команды изменено только `<Action>Выполнить</Action>` → `<Action>ВыполнитьКорректировку</Action>`.

Сохранено без изменений: имя команды `Выполнить`, заголовок и подсказка «Выполнить», кнопка `КнопкаВыполнить` с `CommandName = Form.Command.Выполнить`, вызов `Объект.ВыполнитьКорректировку(OperationID, Компонента, Изменение, Причина)`, серверная процедура `ВыполнитьНаСервере`.

BOM `EF BB BF` в обоих файлах сохранён.

## 3. Загрузка и контроль

| Шаг | Результат |
|---|---|
| `/LoadConfigFromFiles` + `/UpdateDBCfg` в `test-ib-d3` | `exit=0`, «Обновление конфигурации успешно завершено» |
| `/CheckModules` | `exit=0`, «Синтаксических ошибок не обнаружено!» |
| Обратная выгрузка в `dump_handler_fix` | `exit=0` |

### 3.1. Хеши после правки

| Файл | SHA-256 | Размер |
|---|---|---|
| `Forms\Форма\Ext\Form.xml` | `42e7d56dce07fb03b813fc3e3ad6ce2598c61622066daeb808548834c944b604` | 4639 |
| `Forms\Форма\Ext\Form\Module.bsl` | `9ffea6e9c967adb608f26c8bc2efd9fbe6400d8e5e6032987a9be254d7e27484` | 715 |

Рабочая копия и обратная выгрузка совпали побайтно, нормализации размера в этот раз не было.

### 3.2. Diff с состоянием до правки (`dump_d3` → `dump_handler_fix`)

| Категория | Файлы |
|---|---|
| Изменён | `DataProcessors\Korrektur\Forms\Форма\Ext\Form.xml` |
| Изменён | `DataProcessors\Korrektur\Forms\Форма\Ext\Form\Module.bsl` |
| Изменён | `ConfigDumpInfo.xml` (служебный) |
| Добавлен / удалён | нет |

### 3.3. Подтверждение неизменности

| Объект | SHA-256 | Вердикт |
|---|---|---|
| `DataProcessors\Korrektur\Ext\ObjectModule.bsl` | `284d27b4270fa6af1609158a0fc52fe209db5443ae5cd0bc4f0c4c2f65aad99c` | не изменён |
| `Documents\Wareneingang\Ext\ObjectModule.bsl` | `2439b0a6e3af45c8da6d4f1021598dae163540b891019ca4e6b657212241da37` | не изменён (исправление D-3 на месте) |
| `Documents\Verbrauch\Ext\ObjectModule.bsl` | `60fc9d64a83cfbb9ae680b8bc97ec9873d8577b72ac25b72e2264577c5563d1b` | не изменён |
| `InformationRegisters\KorrekturJournal.xml` | `32077662bb1b33ec0ca520db6709f6eb63ee119c70085fe6f866ae24f2f6f037` | структура не изменена |
| `Roles\Korrektur\Ext\Rights.xml` | `c44ba05493842b6a8eea554f05534eb1d549961c03860db2310386d0a1295243` | права не изменены |

Бизнес-логика, `Verbrauch`, `ManagedApplicationModule`, рабочая база, `implementation-a`, Change C, `.cf`, Git, Release, README, ARCHITEKTUR — не затрагивались.

## 4. Ограничение вердикта

`FORM_HANDLER_FIX_PASS` не присваивается: повторный вызов не выполнялся. Текущий статус — `FORM_HANDLER_FIX_PARTIAL`. Чек-лист проверки и replay — в `CHANGE_B_KORREKTUR_FORM_HANDLER_TEST.md`.
