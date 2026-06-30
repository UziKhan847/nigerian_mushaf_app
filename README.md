# Nigerian Mushaf App

A Quran Mushaf reader for the **Nigerian (West African Maghribī) Mushaf**, built with Flutter. It presents all **604 pages** as high-resolution images while preserving the original colouring, rubrication, diacritics, and the distinctive Maghribī orthography of the Nigerian tradition.

Each page is rendered as two layers — an **ink** layer and a **coloured-decoration** layer — so themes can recolour the text without ever touching the decorative borders.

---

## Features

- **Faithful page rendering** — 604 page images, two-layer (ink + border) compositing on the GPU.
- **Reading modes**
  - Vertical or horizontal scroll direction.
  - **Scroll mode** (smooth, continuous) or **Swipe mode** (page-snapping).
  - **Dual-page** spread for wide / landscape screens.
  - Landscape-vertical continuous scroll through zoomed pages.
- **Zoom mode** — pinch / Ctrl-scroll to zoom and pan, with floating axis-aware navigation arrows. Kept separate from normal reading so zoom gestures never fight with swipe.
- **Independent theming**
  - App chrome themes: **Light** (warm cream + amber), **Dark**, **OLED Black**.
  - **Page colour** is independent of the app theme — default white, with a full HSL colour picker and presets. Dark / OLED always render the page inverted on a dark container.
- **Navigation & search**
  - Sūrah, Page, Verse, and Juzʾ index screens.
  - Full-text search in **Qiyāsī**, **Uthmānī**, and **root** modes.
- **Bookmarks** — save any page (shown with its sūrah name) and jump back instantly.
- **Resume on launch** — reopens to your last-read page.
- **In-app brightness** — dim overlay for comfortable night reading (no OS permission needed).
- **Arabic page headers** — current sūrah (`سُورَة …`) and juzʾ (`جُزْء …`) above each page, in the Ruwudu font.
- **Localization** — English, العربية, Hausa, Yorùbá, Igbo, and Français, with automatic RTL handling. Page headers and sūrah names always stay Arabic.
- **Immersive full-screen** reading, with system bars restored on index / about screens.
- **Performance** — page images decode at display resolution (`cacheWidth`) and adjacent pages are precached for flicker-free swiping.

---

## Screenshots

> _Add screenshots to `docs/` and reference them here, e.g.:_
>
> | Reading | Sūrah Index | Themes |
> | --- | --- | --- |
> | `docs/reading.png` | `docs/surah_index.png` | `docs/themes.png` |

---

## Getting started

### Prerequisites

- Flutter SDK `^3.10.1` (Dart `^3.10`)
- Android Studio / Xcode for device builds

### Setup

```bash
git clone https://github.com/UziKhan847/nigerian_mushaf_app.git
cd nigerian_mushaf_app
flutter pub get
```

### Fonts

Place the following font files in `fonts/` (the `Ruwudu` family is available from Google Fonts):

- `fonts/N8_5.ttf` — Nigerian Mushaf script
- `fonts/Ruwudu-Regular.ttf`
- `fonts/Ruwudu-Bold.ttf`

Without these, text falls back to the system font.

### Localization

The app uses Flutter's generated localizations (`generate: true`). Regenerate them whenever the ARB files change:

```bash
flutter gen-l10n
```

`flutter run` also triggers generation automatically.

### Run

```bash
flutter run
```

---

## Launcher icons

Icon generation is configured in `flutter_launcher_icons.yaml` (Android adaptive + monochrome, and iOS). After adding/updating the icon assets:

```bash
flutter pub get
dart run flutter_launcher_icons -f flutter_launcher_icons.yaml
```

---

## Project structure

```
lib/
├─ main.dart                     # App entry, MaterialApp, routes, immersive observer
├─ my_themes.dart                # App themes + mushaf page colour rendering
├─ loading_page.dart
├─ data/
│  └─ mushaf_index_data.dart     # 114 sūrahs + 30 juzʾ, page-lookup helpers
├─ providers/                    # Riverpod state
│  ├─ theme_provider.dart        # app theme + independent page colour
│  ├─ locale_provider.dart       # persisted UI language
│  ├─ current_page_provider.dart # last-read page (persisted)
│  ├─ bookmarks_provider.dart
│  ├─ screen_dim_provider.dart   # in-app brightness
│  ├─ is_zoomed_provider.dart
│  ├─ mushaf_view_settings_provider.dart
│  ├─ mushaf_controller_registry.dart
│  └─ ...
├─ mushaf/
│  ├─ mushaf_list_view_builder.dart  # page/list/edge layouts, zoom, dim overlay
│  └─ mushaf_page.dart               # two-layer page + Arabic header
├─ custom_nav_rail/              # animated nav rail + nav items
├─ pages/index_pages/            # sūrah / page / verse / juzʾ indexes + tiles
├─ search_by_word/               # search delegate, results, suggestions
└─ l10n/                         # app_en/ar/ha/yo/ig/fr.arb
assets/
├─ pages/content/                # 604 ink-layer PNGs
└─ pages/borders/                # 604 decoration-layer PNGs
```

---

## Architecture notes

- **State management:** Riverpod (`^3.x`). A single `currentMushafPageProvider` (absolute 0–603 page index) is the source of truth, kept in sync by the active scroll controller.
- **Rendering:** each page is `Stack([content, border])` inside a sized box. A `ColorFilter` is applied to the ink layer only; the coloured border layer is never filtered, so original decoration colours are always preserved.
- **Reading layouts:** a single hybrid view chooses between a `PageView` (most modes) and a tall-item `ListView` (landscape-vertical continuous scroll); controllers are recreated on layout changes with the correct initial page so switches are seamless.
- **Theming:** app chrome and page colour are decoupled — see `ThemeState { appTheme, pageColor }`.
- **Persistence:** `shared_preferences` (theme, page colour, locale, last page, bookmarks, screen dim, reading settings).

---

## Tech stack

| Area | Choice |
| --- | --- |
| Framework | Flutter (Dart) |
| State | Riverpod |
| Rendering | Two-layer PNG (ink + borders) |
| Page images | 1930 × 2480 px |
| Pages | 604 |
| Persistence | shared_preferences |
| Localization | flutter gen-l10n (6 languages) |

---

## Roadmap

- Reworked reading layout and home screen (continue-reading card, āyah of the day).
- Juzʾ navigation refinements.
- Recitation audio.
- Accessibility semantics and larger tap targets.
- Native-speaker review of Hausa / Yorùbá / Igbo translations.

---

## Contributing

Issues and pull requests are welcome. For translation fixes, edit the relevant `lib/l10n/app_<code>.arb` file and run `flutter gen-l10n`.

---

## Credits

Developed by **Quran Quorum**.

The Nigerian Mushaf is a sacred manuscript deeply rooted in the West African Quranic tradition. All rights to the Nigerian Mushaf script belong to their respective custodians and scholarly communities.

---

## License

> _No license file is currently included. Add a `LICENSE` file and reference it here (e.g. MIT, Apache-2.0) — and note any separate terms that apply to the Mushaf page images, which may not be freely redistributable._