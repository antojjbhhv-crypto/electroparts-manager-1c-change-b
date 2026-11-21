# PHASE2A_TEMPORARY_ENTRY_POINT_REPORT

- Дата: 2026-11-21. Область: `implementation-b\work-config`, `implementation-b\test-ib`.
- Статус: **DONE** (включение в подсистему выполнено, загружено и проверено). Клиентская видимость команды — за оператором.

## 1. Выполнено фактически

### 1.1. Выбранная подсистема

Проверен состав `work-config\Subsystems`: существует ровно одна подсистема — `Lager` (uuid `aef3f7c4-9b2e-4331-b9ad-4693c74edcb8`), профильная складская. Новая подсистема не создавалась.

Состав `Content` до правки: `Catalog.Komponenten`, `Catalog.Lieferanten`, `Document.Wareneingang`, `Document.Verbrauch`, `Report.Lagerbestand`, `Report.Lieferantenuebersicht`.

После правки добавлен один элемент: `DataProcessor.Korrektur` (между `Document.Verbrauch` и `Report.Lagerbestand`).

### 1.2. Изменённый файл

| Состояние | Путь | SHA-256 | Размер |
|---|---|---|---|
| до | `backup\work-config_pre_subsystem_patch_2026-11-21_1046\Subsystems\Lager.xml` | `f4e8bd8b03b91db72c6c90e223495e0fa623f0ddf7fd7b1ce31599eada5d9bc4` | 1873 |
| после | `work-config\Subsystems\Lager.xml` | `b05c975211128f91e14b7a42027aade7506eab9178372aa3789fa6c9cb1c6fe5` | 1947 |

BOM `EF BB BF` сохранён, XML разбирается, `Content` читается в ожидаемом порядке.

### 1.3. Загрузка и проверки

| Шаг | Результат |
|---|---|
| `/LoadConfigFromFiles` + `/UpdateDBCfg` | `exit=0`, «Обновление конфигурации успешно завершено» |
| `/CheckModules` | `exit=0`, «Синтаксических ошибок не обнаружено!» |
| Контрольная выгрузка в `dump_after_subsystem` | `exit=0` |

### 1.4. Подтверждение, что изменилось только ожидаемое

Поглавное сравнение `dump_after_subsystem` с бэкапом `work-config_pre_subsystem_patch_2026-11-21_1046`:

| Категория | Файлы |
|---|---|
| Изменён | `Subsystems\Lager.xml` — единственный |
| Добавлен | `ConfigDumpInfo.xml` (служебный, регенерируется при выгрузке) |
| Удалён | нет |

### 1.5. Сохранение трёх SHA формы и модулей

| Файл | SHA-256 после загрузки | Вердикт |
|---|---|---|
| `Forms\Форма\Ext\Form.xml` | `d57583f7189fbffd30f3e415dc2ae4923f1d16c5292254378d8545f053f4df43` | не изменён |
| `Forms\Форма\Ext\Form\Module.bsl` | `d67ae81685c43cdfd33d039dcdb2a9883206f25bcda61348b0f45edc35bb69d9` | не изменён |
| `Ext\ObjectModule.bsl` | `284d27b4270fa6af1609158a0fc52fe209db5443ae5cd0bc4f0c4c2f65aad99c` | не изменён |

### 1.6. Соблюдение ограничений

- Новая подсистема не создавалась; роли и права не создавались и не изменялись.
- `ManagedApplicationModule` не изменялся.
- Код формы и объекта, бизнес-логика не изменялись (`/CheckModules` чистый, три SHA совпадают).
- `implementation-a`, рабочая база, Change C, `.cf`, Git, Release, README, ARCHITEKTUR не затрагивались.

## 2. Инструкции оператору (не выполнены)

1. Открыть `1С:Предприятие` на `test-ib`.
2. В разделе `Lager` в командной панели должна появиться команда открытия обработки `Korrektur`.
3. Открыть её и убедиться, что форма содержит поля `Operation ID`, `Компонента`, `Изменение`, `Причина` и кнопку `Выполнить`.
4. Если команда в разделе не появилась — зафиксировать это; тогда единственный вход — «Все функции» → `Обработки` → `Korrektur` (у обработки задана форма по умолчанию `DataProcessor.Korrektur.Form.Форма`).

Фактическая проверка через клиент MultiTool не выполнялась: GUI не автоматизируется.

## 3. Ограничение

Включение обработки в подсистему — временная мера для прогона Phase 2A. Перед передачей Change B дальше её следует откатить (вернуть `Lager.xml` из бэкапа и перезагрузить конфигурацию), если владелец не решит иначе.
