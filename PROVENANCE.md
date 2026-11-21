# Provenienz und Prüfsummen

## 1. Ausgangspunkt

- Internes Release-Paket `release\ChangeB-Phase2A-20261121` (nicht öffentlich).
- Ursprüngliches Manifest `MANIFEST_SHA256.txt`: 87 Einträge, 0 Abweichungen, SHA-256 `5cb69a44a791121581ae5716d62a5eb42598ceb456b7c0af26fa9b2bc6cc2cfe`.
- Dieses Repository ist eine anonymisierte Ableitung des Pakets, erstellt am 2026-11-21.

## 2. Inhalt

- `config-xml/` — 29 Dateien, byte-identisch mit `config/` des Ausgangspakets (Vergleich per SHA-256: 0 Abweichungen).
- `docs/` — 57 Dateien (Berichte, Prüfsummenlisten, ein Screenshot).
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

Ersetzt wurden der lokale Benutzername und das Domänenpräfix durch `TEST_USER` (vier Dateien); die ursprünglichen Werte werden hier nicht wiedergegeben. Die übrigen 83 Dateien des Ausgangspakets sind unverändert; der Abgleich gegen das Ausgangsmanifest ergab 0 fehlende und genau diese 4 abweichenden Einträge.

## 4. Prüfung auf personenbezogene Daten

- Textdateien: keine Treffer für Benutzernamen, Domänen-, Maschinen- oder absolute Pfadangaben (etwa `C:\…`, `A:\…`).
- `config-xml/Configuration.xml`: Felder `Vendor`, `Copyright`, `Version`, `Comment` leer.
- `docs/lic-refused-dialog.png`: reines Dialogfenster ohne Benutzer- oder Maschinennamen; PNG enthält nur die Chunks `IHDR`, `sRGB`, `gAMA`, `pHYs`, `IDAT`, `IEND`, keine Text-Chunks.

## 5. Manifest

- `MANIFEST_SHA256.txt` enthält 88 Einträge: `config-xml/` (29), `docs/` (57), `README.md`, `RELEASE_NOTES.md`.
- Nicht aufgenommen: `MANIFEST_SHA256.txt` (Selbstreferenz), `PROVENANCE.md` (nennt die Prüfsumme des Manifests) und `.gitignore` (Repository-Konfiguration).
- SHA-256 des Manifests: `ab8db11d410f49387b09900523e60c2f45890cbe9bcdbdf00ed5752818779044`.
