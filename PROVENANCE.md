# Provenienz und Prüfsummen

## 1. Ausgangspunkt

- Internes Release-Paket `release\ChangeB-Phase2A-20261121` (nicht öffentlich).
- Ursprüngliches Manifest `MANIFEST_SHA256.txt`: 87 Einträge, 0 Abweichungen, SHA-256 `5cb69a44a791121581ae5716d62a5eb42598ceb456b7c0af26fa9b2bc6cc2cfe`.
- Dieses Repository ist eine anonymisierte Ableitung des Pakets, erstellt am 2026-11-21.

## 2. Inhalt

- `config-xml/` — 29 Dateien, byte-identisch mit `config/` des Ausgangspakets (Vergleich per SHA-256: 0 Abweichungen).
- `docs/` — 58 Dateien (Berichte, Prüfsummenlisten, ein Screenshot).
- `RELEASE_NOTES.md` — Begleitdokument, bis auf die unten genannten Änderungen unverändert.
- `README.md` — neu für dieses Repository.
- Nicht enthalten: Dateibasen (`*.1CD`), Registrierungsprotokolle (`*.lgp`, `*.lgf`), Sicherungen, temporäre Testbasen, lokale Umgebungsdateien, Zugangsdaten.

## 3. Änderungen gegenüber dem Ausgangspaket

| Datei | Änderung | SHA-256 Quelle | SHA-256 Repository |
|---|---|---|---|
| `RELEASE_NOTES.md` | Anonymisierung; Pfade `config/` → `config-xml/` | `f7c588dffe2bf5ed14b472f998c6e856c35f9c5910e5c24dea896554746614b2` | `17d96f02ada46b6d7040ce2ed80cf4e02d2e9f1e7b7f73433628a22547273f51` |
| `docs/PHASE2A_FIX_USER_FIELD.md` | Anonymisierung | `fb3d6a7b292eb91e71213127e44c3c2525545b9de9b4413786e2faf9ef0642bd` | `4da60b037caf0a03187e94e970463a8f1b04c0de8646f2c46074eabbbec08e32` |
| `docs/PHASE2A_OPERATOR_RUNBOOK.md` | Anonymisierung | `65c48cd89a26b5caa3394e0976e1ffb5467888f8bdbdc6a4b2581f627a0b574a` | `c7feab8a4d2274f1d40c91ba46114ba843d1aa9119de68ae1f6f60a64c8c2420` |
| `docs/PHASE2A_RELEASE_INTEGRATION_CHECK.md` | Anonymisierung | `a0cbd927596475b6d48740a76f682b464871a34fab12b1d7fd0cb1f530120e79` | `974c11ecc2009c11a9a546aa2bf8136fbc7e8b8f3b9902599489a9c24ea6211c` |
| `config-xml/DataProcessors/Korrektur/Ext/ObjectModule.bsl` | Payload-Vergleich + eng begrenzter privilegierter Journalschreibzugriff (Branch-Kandidat) | `255b72bfdbf9f0ad1271c566c1eed0ab310299f714a7e3662ff8c09ee0f0840b` | `8fbf81872ea85994a74a999beb73a0f8b4b0c56958c80388ba5397f220ea1382` |
| `config-xml/Roles/Korrektur/Ext/Rights.xml` | Direkte Update-Rechte auf Registern entfernt (Branch-Kandidat) | `4139edebb065df9b2bc92d095f70ef6640a11ca5117dca46f24e862d20c5adc8` | `02535a6ec02bf8398c80b85a161e393f796a1a2579c1f05b356f9f88dc7a9067` |

Im ursprünglichen Veröffentlichungsderivat wurden der lokale Benutzername und das Domänenpräfix durch `TEST_USER` ersetzt (vier Dateien). Im Follow-up-Branch `audit-remediation` wurden zusätzlich `config-xml/DataProcessors/Korrektur/Ext/ObjectModule.bsl` und `config-xml/Roles/Korrektur/Ext/Rights.xml` geändert; ein neuer Sicherheitsnachtrag wurde ergänzt. Damit sind sechs der 87 ursprünglichen Paketdateien geändert und 81 unverändert; zusätzlich enthält das Repository das README und den neuen Nachtrag.

## 4. Prüfung auf personenbezogene Daten

- Textdateien: keine Treffer für Benutzernamen, Domänen-, Maschinen- oder absolute Pfadangaben (etwa `C:\…`, `A:\…`).
- `config-xml/Configuration.xml`: Felder `Vendor`, `Copyright`, `Version`, `Comment` leer.
- `docs/lic-refused-dialog.png`: reines Dialogfenster ohne Benutzer- oder Maschinennamen; PNG enthält nur die Chunks `IHDR`, `sRGB`, `gAMA`, `pHYs`, `IDAT`, `IEND`, keine Text-Chunks.

## 5. Manifest

- `MANIFEST_SHA256.txt` enthält 89 Einträge: `config-xml/` (29), `docs/` (58), `README.md`, `RELEASE_NOTES.md`.
- Nicht aufgenommen: `MANIFEST_SHA256.txt` (Selbstreferenz), `PROVENANCE.md` (nennt die Prüfsumme des Manifests) und `.gitignore` (Repository-Konfiguration).
- SHA-256 des Manifests: `daad18258a77512d82f154943139eee9bcbad0958066078ba1c4eaf6b551572c`.

## 6. Follow-up branch `audit-remediation`

- Ausgangscommit: `0fe671baacc7c491c8bce99c5bf6d486f7dd451d`.
- Der Branch ist ein unveröffentlichter Remediation-Kandidat; der bestehende Release-Tag `v1.1.0-change-b` bleibt unverändert.
- Die aktualisierte SHA-256-Liste enthält 89 Dateien; SHA-256: `daad18258a77512d82f154943139eee9bcbad0958066078ba1c4eaf6b551572c`.
- Die Änderungen an Rechten und Payload-Identität sind statische Kandidaten und müssen vor dem Merge auf 1C:Enterprise 8.3.27.1508 getestet werden.
