# ElectroParts Manager — Change B (Phase 2A)

**Version:** `v1.1.0-change-b`
**Basis:** ElectroParts Manager v1.0 (1C:Enterprise 8.3, Lernkonfiguration)

## 1. Überblick

Change B ergänzt die Lernkonfiguration um eine kontrollierte Korrektur von Lagerbewegungen. Die Korrektur läuft nicht als freie Registerbuchung, sondern über die Datenverarbeitung `Korrektur`: Eingaben prüfen, Operation im Journal `KorrekturJournal` reservieren, danach ein reguläres Dokument buchen (`Wareneingang` bei Zugang, `Verbrauch` bei Abgang). Journal-Eintrag, Dokument und Registerbewegung entstehen in einer Transaktion.

Die Basisversion v1.0 bleibt unverändert. Change B wird als XML-Dump der Konfiguration ausgeliefert, nicht als `.cf`-Build.

## 2. Funktionsweise

Die exportierte Funktion `ВыполнитьКорректировку(OperationID, Компонента, Изменение, Причина = "")` arbeitet in drei Schritten:

1. **Eingabeprüfung.** `OperationID` muss ein UUID sein, die Komponente gesetzt, die Änderung ungleich null.
2. **Reservierung im Journal.** Geschrieben wird ein Datensatz mit dem Status `Зарезервировано`. Existiert die `OperationID` bereits, wird die Transaktion abgebrochen: Bei identischem Payload (Komponente und Änderung) gibt die Funktion das gespeicherte Ergebnis zurück, bei abweichendem Payload bricht sie mit `Korrektur: OperationID уже использован с другим payload` ab.
3. **Buchung und Abschluss.** Die Korrektur darf den Mindestbestand nicht verschlechtern. Bei positivem `Изменение` entsteht ein `Wareneingang`, bei negativem ein `Verbrauch`; das Dokument wird sofort gebucht. Danach erhält der Journal-Eintrag den Status `Проведено` und die Dokumentreferenz, anschließend wird die Transaktion bestätigt. Ein Fehler auf einem dieser Schritte rollt Journal-Eintrag, Dokument und Bewegung vollständig zurück.

Das Feld `Пользователь` füllt `ИмяТекущегоПользователя()`: zuerst `ИмяПользователя()`, ersatzweise das COM-Konto (`WScript.Network`), sonst `НеОпределён`. Zur Datenverarbeitung gehört eine Form (`DataProcessors/Korrektur/Forms/Форма`).

## 3. Rolle `Korrektur`

Die Rolle gewährt Lesen, Anlegen, Ändern und **Buchen** (`Posting`) für `Wareneingang` und `Verbrauch` sowie Lesen und Ändern für `Bestaende` und `KorrekturJournal`. Das Recht heißt im XML `<name>Posting</name>`; die Schreibweise `Post` wird von der Plattform stillschweigend verworfen und ergibt eine Rolle ohne Buchungsrecht.

## 4. Paketinhalt

| Pfad | Inhalt |
|---|---|
| `config-xml/` | Konfiguration als XML-Dump (29 Dateien) zum Laden in den Konfigurator |
| `docs/` | technische Berichte, Prüfprotokolle und ein Screenshot der Phase 2A (russisch) |
| `RELEASE_NOTES.md` | Ergebnis-Matrix, Warnungen, akzeptierte Risiken, Hashes |
| `PROVENANCE.md` | Herkunft, Anonymisierung, Prüfsummen |
| `MANIFEST_SHA256.txt` | SHA-256 der Inhaltsdateien |

## 5. Installation

1. 1C:Enterprise 8.3 (Testversion 8.3.27.1508) im Konfigurator öffnen.
2. Eine Kopie der Dateibasis v1.0 anlegen.
3. Im Konfigurator die Konfiguration aus dem Verzeichnis `config-xml/` laden («Загрузить конфигурацию из файлов»).
4. Datenbankkonfiguration aktualisieren.
5. Im Modus 1C:Enterprise den Abschnitt `Lager` öffnen und die Datenverarbeitung `Korrektur` starten.

## 6. Verifikationsstand

| Prüfung | Status |
|---|---|
| Sequenzielle Idempotenz (T-I, T-I2, T-I3) | PASS |
| Grenzen des Mindestbestands (S0–S6) | PASS_WITH_SCOPE |
| Abgleich Dokumente und Bestände | PASS |
| T-F: Atomarität bei Schreibfehler im Journal | PASS |
| Rechte der Rolle `Korrektur` | PASS (strukturell) |
| Zwei-Sitzungs-Konkurrenz (T-J, D10b, T14) | WAIVED |
| Integrationsprüfung des Release-Builds | PASS |

Die vollständige Matrix mit Begründungen steht in `RELEASE_NOTES.md`.

## 7. Bekannte Einschränkungen

- **Konkurrenz nicht geprüft.** Die Lernlizenz erlaubt eine Sitzung; der zweite Start wurde abgewiesen (`docs/lic-refused-dialog.png`). Das Risiko ist vom Eigentümer akzeptiert.
- **Rollenrechte nur strukturell bestätigt.** Ein Katalog `Пользователи` fehlt, daher ist keine verhaltensbasierte Rechteprüfung möglich.
- **T14 zurückgestellt (Waiver).** Die ursprüngliche Evidenzgrundlage wurde nicht wiederhergestellt.
- **Stand-Artefakte.** In der Testbasis liegen Dokumente aus Testläufen und aus einem Zwischenfall mit einer falschen Basis; sie sind dokumentiert und keine Fehler der Geschäftslogik.

## 8. Dokumentation

Die Berichte in `docs/` sind auf Russisch. Einstiegspunkte:

- `docs/PHASE2A_RELEASE_INTEGRATION_CHECK.md` — Integrationsprüfung des Builds
- `docs/PHASE2A_TF_ATOMICITY_JOURNAL.md` — Atomaritätstest T-F
- `docs/PHASE2A_ROLE_RIGHTS_FIX.md` — Rechte der Rolle
- `docs/PHASE2A_INCIDENT_MB_BASE_POLLUTED.md` — Zwischenfall mit falscher Basis
- `docs/PHASE2A_OPERATOR_RUNBOOK.md` — Betriebshandbuch

## 9. Provenienz

Dieses Repository ist eine anonymisierte Veröffentlichung des internen Release-Pakets `ChangeB-Phase2A-20261121`. Quelle, Anonymisierung und Prüfsummen: `PROVENANCE.md`.

## 10. Lizenz

Es wurde keine Lizenz hinzugefügt.
