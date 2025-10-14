# 🎨 Kozmos Keşfet Sayfası - Görsel UI Rehberi

## Tam Sayfa Mockup

```
┌─────────────────────────────────────────────────┐
│                                                 │
│  Keşfet                           [60px top]   │
│  Sana uygun içeriği keşfet                     │
│                                                 │
│  ┌─────────────────────────────────────────┐  │
│  │ 🔍  Bir konu veya duygu ara...         │  │ ← ARAMA ÇUBUĞU
│  │     (uyku, yalnızlık, motivasyon)      │  │   (56px, beyaz)
│  └─────────────────────────────────────────┘  │
│                                                 │
├─────────────────────────────────────────────────┤
│                                                 │
│  Bugün Sana Ne İyi Gelir?                      │
│                                                 │
│  ┌────────────┐  ┌────────────┐  ┌──────────┐ │
│  │            │  │            │  │          │ │
│  │  [Mavi]   │  │  [Pembe]  │  │  [Mor]  │ │ ← KOLEKSIYONLAR
│  │            │  │            │  │          │ │   (280×200px)
│  │ ⭕ Zor Bir│  │ ⭕ Yaratıcı│  │ ⭕ Panik │ │
│  │  Konuşma  │  │   lık      │  │  Anı    │ │
│  │           │  │            │  │          │ │
│  │ 5 içerik  │  │ 7 içerik   │  │ 4 içerik│ │
│  └────────────┘  └────────────┘  └──────────┘ │
│                                          [→]   │
├─────────────────────────────────────────────────┤
│                                                 │
│  İçerik Türleri                                │
│                                                 │
│  ┌──────────────────┬──────────────────┐      │
│  │                  │                  │      │
│  │  🎧             │   💨             │      │
│  │                  │                  │      │ ← İÇERİK TÜRLERİ
│  │  Rehberli       │   Nefes          │      │   (2×2 grid)
│  │  Meditasyonlar  │   Terapileri     │      │
│  │                  │                  │      │
│  │  50+ içerik     │   4 terapi       │      │
│  └──────────────────┴──────────────────┘      │
│  ┌──────────────────┬──────────────────┐      │
│  │                  │                  │      │
│  │  📅             │   🎵             │      │
│  │                  │                  │      │
│  │  Programlar     │   Müzikler       │      │
│  │                  │   ve Sesler      │      │
│  │                  │                  │      │
│  │  5 program      │   Yakında        │      │
│  └──────────────────┴──────────────────┘      │
│                                                 │
├─────────────────────────────────────────────────┤
│                                                 │
│  [YENİ] Kozmos'taki Yenilikler                 │
│                                                 │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐    │
│  │          │  │          │  │          │    │
│  │ [Turunc]│  │ [Pembe] │  │  [Mor]   │    │ ← YENİ İÇERİKLER
│  │          │  │          │  │          │    │   (260×140px)
│  │ Sabah    │  │ 21 Gün  │  │  Hızlı   │    │
│  │ Meditasyon│ │ Şükran  │  │ Sakinleşme│   │
│  │          │  │          │  │          │    │
│  └──────────┘  └──────────┘  └──────────┘    │
│                                          [→]   │
├─────────────────────────────────────────────────┤
│                                                 │
│  Popüler Konular                               │
│                                                 │
│  ┌──────────┐ ┌─────────┐ ┌──────────────┐   │
│  │ Özgüven  │ │Affetmek │ │ Sabah Rutini │   │
│  └──────────┘ └─────────┘ └──────────────┘   │
│  ┌────────────┐ ┌──────┐ ┌───────┐ ┌──────┐  │ ← KONULAR
│  │ Motivasyon │ │ Kabul│ │  Yas  │ │Minnet│  │   (Tag cloud)
│  └────────────┘ └──────┘ └───────┘ └──────┘  │
│  ┌────────────────┐ ┌──────────┐ ┌─────────┐ │
│  │ Öfke Yönetimi  │ │ İlişkiler│ │ Kendini │ │
│  └────────────────┘ └──────────┘ └─────────┘ │
│  ┌───────┐ ┌───────┐ ┌─────────┐ ┌─────────┐ │
│  │ Sabır │ │ Korku │ │Yalnızlık│ │ Değişim │ │
│  └───────┘ └───────┘ └─────────┘ └─────────┘ │
│                                                 │
├─────────────────────────────────────────────────┤
│  [Ana Sayfa] [Keşfet] [Programlar] [Profil]   │
│      ○          ◉         ○           ○        │
└─────────────────────────────────────────────────┘
```

## Detaylı Bileşen Mockup'ları

### 1. Arama Çubuğu (Normal Durum)

```
┌──────────────────────────────────────────────────┐
│  🔍  Bir konu veya duygu ara...                 │
│      (uyku, yalnızlık, motivasyon)              │
└──────────────────────────────────────────────────┘

• Yükseklik: 56px
• Arka plan: Beyaz
• İkon: %40 opacity Dark Plum
• Metin: %40 opacity Dark Plum, 15px
• Gölge: 20px blur, %8 opacity
• Radius: 28px
```

### 2. Arama Modal Sheet (Açık Durum)

```
┌─────────────────────────────────────────────────┐
│              _____ (Handle)                     │
│                                                 │
│  ┌───────────────────────────────────────────┐ │
│  │ 🔍  Ara...                              × │ │
│  └───────────────────────────────────────────┘ │
│                                                 │
│  Popüler Aramalar                              │
│                                                 │
│  ┌─────────────────────────────────────────┐  │
│  │ 📈  uyku                              → │  │
│  └─────────────────────────────────────────┘  │
│  ┌─────────────────────────────────────────┐  │
│  │ 📈  stres                             → │  │
│  └─────────────────────────────────────────┘  │
│  ┌─────────────────────────────────────────┐  │
│  │ 📈  kaygı                             → │  │
│  └─────────────────────────────────────────┘  │
│  ┌─────────────────────────────────────────┐  │
│  │ 📈  motivasyon                        → │  │
│  └─────────────────────────────────────────┘  │
│  ┌─────────────────────────────────────────┐  │
│  │ 📈  özgüven                           → │  │
│  └─────────────────────────────────────────┘  │
│  ┌─────────────────────────────────────────┐  │
│  │ 📈  nefes çalışması                   → │  │
│  └─────────────────────────────────────────┘  │
│                                                 │
└─────────────────────────────────────────────────┘

• Yükseklik: Ekranın %85'i
• Arka plan: Warm Cream
• Handle: 40×4px, %20 opacity
• Trending icon: Gold
• Her satır: 16px padding, alt kenarlık
```

### 3. Koleksiyon Kartı Detayları

```
┌────────────────────────────────────┐
│                                    │
│  [Gradient: Mavi → Koyu Mavi]     │
│  [Glassmorphism: Beyaz overlay]    │
│                                    │
│  ┌──────┐                         │
│  │  💬  │ (48×48px daire)         │
│  └──────┘                         │
│                                    │
│                                    │
│                                    │
│  Zor Bir Konuşmadan Önce          │
│  Sakin ve odaklanmış ol            │
│                                    │
│  ┌───────────┐                    │
│  │ 5 içerik  │ (Badge)            │
│  └───────────┘                    │
│                                    │
└────────────────────────────────────┘

BOYUTLAR:
• Genişlik: 280px
• Yükseklik: 200px
• Radius: 20px
• Padding: 20px
• İkon daire: Beyaz %30 opacity
• Badge: Beyaz %25 opacity, 12px radius

METİNLER:
• Başlık: 18px, kalın, beyaz
• Alt başlık: 13px, orta, beyaz %90
• Badge: 11px, kalın, beyaz
```

### 4. İçerik Türü Kartı

```
┌─────────────────────┐
│                     │
│         ┌──┐       │
│         │🎧│       │
│         └──┘       │
│                     │
│    Rehberli        │
│   Meditasyonlar    │
│                     │
│    50+ içerik      │
│                     │
└─────────────────────┘

BOYUTLAR:
• Kare (aspect ratio 1:1)
• Radius: 16px
• İkon daire: 60×60px

RENKLER:
• Arka plan: Beyaz
• İkon daire: Kategori rengi %15 opacity
• İkon: Kategori rengi (solid)
• Başlık: Dark Plum, 14px
• Sayı: Dark Plum %50, 12px

GRID:
• 2 sütun
• 16px spacing (x ve y)
```

### 5. Yeni İçerik Kartı

```
┌────────────────────────────────┐
│                                │
│  [Gradient Background]         │
│                                │
│                                │
│  [Dark Overlay (alt)]          │
│                                │
│  Yeni: Sabah Meditasyonu      │
│  [Meditasyon] 12 Dakika       │
│                                │
└────────────────────────────────┘

BOYUTLAR:
• Genişlik: 260px
• Yükseklik: 140px
• Radius: 16px

KATMANLAR:
1. Gradient (full)
2. Dark overlay (bottom, %40 siyah)
3. Metin (padding: 16px)

METİN:
• Başlık: 15px, kalın, beyaz
• Tip badge: 11px, beyaz %25 bg
• Süre: 12px, beyaz %90
```

### 6. Konu Tag'i

```
┌──────────────┐
│   Özgüven   │
└──────────────┘

• Arka plan: Beyaz
• Kenarlık: Dark Plum %15, 1px
• Padding: 16×10px
• Radius: 20px
• Font: 14px, medium, Dark Plum
• Hafif gölge: 8px blur, %4 opacity
• Spacing: 8px (wrap)
```

## Renk Paleti Uygulaması

### Ana Renk Kullanımları:

**Warm Cream (#FFFDD0):**
```
█████ Sayfa arka planı
█████ Modal sheet arka planı
```

**Beyaz (#FFFFFF):**
```
█████ Arama çubuğu
█████ İçerik türü kartları
█████ Konu tag'leri
```

**Dark Plum (#4A2C4B):**
```
█████ Başlıklar (solid)
█████ Alt başlıklar (%60)
█████ Placeholder (%40)
█████ Tag metinleri
```

**Soft Gold (#D4AF37):**
```
█████ "YENİ" badge
█████ Trend ikonları
█████ Seçili tab
```

### Gradient Paletleri:

**Koleksiyon 1 - Mavi:**
```
█████ #87CEEB (Açık Mavi)
  ↓
█████ #5F9FD9 (Koyu Mavi)
```

**Koleksiyon 2 - Pembe:**
```
█████ #FFB6C1 (Açık Pembe)
  ↓
█████ #FF8FAB (Koyu Pembe)
```

**Koleksiyon 3 - Mor:**
```
█████ #B8A5D4 (Açık Mor)
  ↓
█████ #9C88C2 (Koyu Mor)
```

**Koleksiyon 4 - Turuncu:**
```
█████ #FFA07A (Açık Turuncu)
  ↓
█████ #FF7F50 (Koyu Turuncu)
```

**Koleksiyon 5 - İndigo:**
```
█████ #6A5ACD (Açık İndigo)
  ↓
█████ #483D8B (Koyu İndigo)
```

## İnteraktif Durumlar

### Arama Çubuğu:

**Normal:**
```
┌────────────────────────────┐
│ 🔍  Ara...                │
└────────────────────────────┘
```

**Odaklanmış (Modal Açık):**
```
┌────────────────────────────┐
│ 🔍  [Yazılan metin]     × │
│       (cursor)             │
└────────────────────────────┘
+ Klavye görünür
+ Popüler aramalar altında
```

### Koleksiyon Kartı:

**Normal:**
```
┌──────────────┐
│ [Gradient]   │
│ [İçerik]     │
└──────────────┘
Gölge: 8px offset
```

**Basıldığında:**
```
┌──────────────┐
│ [Gradient]   │
│ [İçerik]     │
└──────────────┘
Hafif scale: 0.98
Gölge: 4px offset
```

### İçerik Türü Kartı:

**Normal:**
```
┌─────┐
│ 🎧  │
│ Text │
└─────┘
Opacity: 1.0
```

**Basıldığında:**
```
┌─────┐
│ 🎧  │
│ Text │
└─────┘
Opacity: 0.7
```

### Konu Tag'i:

**Normal:**
```
┌──────────┐
│ Özgüven  │
└──────────┘
Kenarlık: %15 opacity
```

**Basıldığında:**
```
┌──────────┐
│ Özgüven  │
└──────────┘
Arka plan: Gold %10
Kenarlık: Gold %30
```

## Tipografi Hiyerarşisi

```
│
│  KEŞFET                           ← 36px, ince
│  Sana uygun içeriği keşfet        ← 16px, orta
│
│  ─────────────────────────────────
│
│  Bugün Sana Ne İyi Gelir?         ← 20px, kalın
│
│  ─────────────────────────────────
│
│  ┌──────────────────────┐
│  │ Zor Bir Konuşmadan   │         ← 18px, kalın (kart)
│  │ Önce                 │
│  │ Sakin ve odaklanmış  │         ← 13px, orta (kart)
│  │ ol                   │
│  └──────────────────────┘
│
│  ─────────────────────────────────
│
│  İçerik Türleri                   ← 20px, kalın
│
│  ─────────────────────────────────
│
│  ┌──────────────┐
│  │ Rehberli     │                 ← 14px, kalın
│  │ Meditasyonlar│
│  │ 50+ içerik   │                 ← 12px, orta
│  └──────────────┘
│
```

## Spacing Sistemi

```
Dış Padding: 24px
├─ Başlık
├─ 8px
├─ Alt başlık
├─ 24px
├─ Arama çubuğu
│
├─ 16px (bölüm arası)
│
├─ Bölüm başlığı
├─ 16px
├─ İçerik (carousel/grid)
│
├─ 32px (büyük bölüm arası)
│
├─ Bölüm başlığı
├─ 16px
├─ İçerik
│
└─ 100px (bottom spacing)
```

## Gölge Sistemi

**Küçük Gölge (Tag'ler):**
```
• Blur: 8px
• Offset: 0, 2px
• Opacity: %4
• Color: Dark Plum
```

**Orta Gölge (Kartlar):**
```
• Blur: 15px
• Offset: 0, 4px
• Opacity: %5-%8
• Color: Dark Plum
```

**Büyük Gölge (Arama, Koleksiyonlar):**
```
• Blur: 20px
• Offset: 0, 8px
• Opacity: %8
• Color: Dark Plum
```

## Animasyon Önerileri (Gelecek)

1. **Sayfa Girişi:**
   - Fade in + yukarı kayma
   - Stagger efekti (bölümler sırayla)

2. **Arama Modal:**
   - Yukarı slide animation
   - Arka plan fade in
   - Klavye ile senkronize

3. **Kart Tıklama:**
   - Hafif scale (0.98)
   - Gölge azaltma
   - 100ms duration

4. **Carousel Kaydırma:**
   - Momentum scroll
   - Smooth deceleration

5. **Tag Tıklama:**
   - Renk değişimi (200ms)
   - Hafif pulse efekti

---

Bu görsel rehber, Keşfet sayfasının tüm bileşenlerini detaylı olarak gösterir ve geliştiricilerin pixel-perfect implementasyon yapmasını sağlar! 🎨✨
