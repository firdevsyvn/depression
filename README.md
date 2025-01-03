#Student Depression Data yı SQL le VERİ ANALİZİ

By FİRDEVS YAVAN

- **Kısa Tanıtım**

Bu belge, "Student Depression Dataset" kullanılarak öğrenciler arasındaki depresyonla ilgili ilişkileri belirlemek amacıyla SQL sorguları sağlamaktadır. Her sorgu, öğrenci demografisi, davranışları ve depresyona katkıda bulunan çevresel faktörler hakkında belirli bir soru veya hipotezi ele almaktadır.

- **Veri Seti**

Kaggle dan alınan bir veridir.Veri kümesinin csv formatındadır.Excele çevirip tabloyu ['Student Depression Dataset$'] olarak referans verilmiştir.


Önemli sütunlar şunlardır:
* Gender (Cinsiyet)
* Age (Yaş)
* Depression (1: Evet, 0: Hayır)
* Sleep Duration (Uyku Süresi)
* Study Satisfaction (Çalışma Memnuniyeti)
* Academic Pressure (Akademik Baskı)
* Work/Study Hours (Çalışma/Saatleri)
* Dietary Habits (Beslenme Alışkanlıkları)
* Have you ever had suicidal thoughts? (Hiç İntihar Düşünceniz Oldu mu?)


**Bu analizde yanıt aradığım sorular şunlardır:**

-Her bir cinsiyetteki öğrencilerin ortalama depresyon seviyesi nedir?

-Depresyonda olan öğrencilerin ortalama yaşi kaçtır ?

-Her yaş grubunda kaç öğrenci depresyondadır? ve Her yaş grubunda kaç öğrenci vardır? 

-Her bir cinsiyet ve yaş grubunda depresyon seviyesi ortalamasi nedir,depresyon orani nedir,kaç öğrenci depresyondadir ?

-Uyku süresi, çalişma memnuniyeti ve akademik baski, depresyon üzerinde nasil bir etkisi vardir? ve Farkli uyku sürelerine, çalişma memnuniyetine ve akademik baski seviyelerine sahip öğrenci gruplarinda depresyon oranlari nasil farklilik göstermektedir? 

-Çalişma memnuniyeti, akademik baski ve uyku süresinin etkileşimli olarak depresyon üzerindeki etkisini nedir?

-Düşük çalişma memnuniyeti yaşayan öğrencilerin uyku süreleri ile depresyon oranlari arasinda nasil bir ilişki vardir?

-Öğrencileri çalişma saatlerine göre öğrencilerin depresyon oranlarını nedir?

-Hangi diyet kategorisindeki öğrencilerin depresyon riski daha yüksek?

-Depresyona giren öğrencilerin intihar etme düşünce içinde olmasiyla bir ilişkisi var mi?

-İntihar etme düşüncesi olan öğrencilerin ortalama yaşi kaçtir?

-İntihar etme düşüncesi olan öğrencilerin hangi yaş gruplarinda bu düşünce daha çok vardir ?

-İntihar etmeyi düşünmüş öğrencilerin içinde bulundukları akademik baski ile ilişkisi var mı?


- **Veri Kümesi Açıklaması:**
  Tablo 'Student Depression Dataset$', 18 sutün ve 27901 satırdan oluşmaktadır.

---

## Sorgular ve Amaçlar
### 1.Cinsiyete Göre Depresyon Analizi
```SQL

SELECT Gender,
       AVG(Depression) AS Ortalama_Depresyon,
       COUNT(*) AS Toplam_Veri
FROM ['Student Depression Dataset$']
GROUP BY Gender; 
```
-- Her bir cinsiyet için ortalama depresyon seviyesini ve toplam öğrenci sayısını belirler.

### 2. Depresyondaki Öğrencilerin Ortalama Yaşı
```SQL
SELECT AVG(Age) AS Ortalama_Yaş
FROM ['Student Depression Dataset$']
WHERE Depression=1;
```
-- Depresyon yaşayan öğrencilerin ortalama yaşını hesaplar.

### 3. Yaş Gruplarına Göre Depresyon
```SQL
SELECT
   CASE
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 30 THEN '26-30'
        ELSE '30 Üstü'
    END AS Yasgrubu,
    COUNT(*) AS ToplamOgrenci,
    SUM(Depression) AS DepresyondaOlanlar
FROM ['Student Depression Dataset$']
GROUP BY 
    CASE
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 30 THEN '26-30'
        ELSE '30 Üstü'
    END;
```
-- Her yaş grubundaki toplam öğrenci sayısını ve depresyonda olanları analiz eder.

### 4. Cinsiyet ve Yaş Gruplarına Göre Depresyon
```SQL
SELECT
    Gender, Yas_grubu,
    ROUND(AVG(Depression),2) AS Ortalama_Depresyon_Skoru,
    ROUND((SUM(Depression) / COUNT(*)) * 100, 2) AS Depresyon_Yuzdesi,
    SUM(Depression) AS Depresyonda_Olanlar,
    COUNT(*) AS Toplam_Ogrenci
FROM (
    SELECT *,
        CASE
            WHEN Age BETWEEN 18 AND 25 THEN '18-25'
            WHEN Age BETWEEN 26 AND 30 THEN '26-30'
            ELSE '30 Üstü'
        END AS Yas_grubu
    FROM ['Student Depression Dataset$']
) AS subquery
GROUP BY Gender, Yas_grubu
ORDER BY Gender, Yas_grubu;
```
-- Cinsiyet ve yaş grubu bazında ortalama depresyon skorlarını, depresyon yüzdelerini ve toplam depresyonda olan öğrencileri bulur.

### 5. Uyku Süresi, Çalışma Memnuniyeti ve Akademik Baskının Etkisi
```SQL
SELECT
    CASE
        WHEN [Sleep Duration] = '5-6 hours' OR [Sleep Duration] = 'Less than 5 hours' THEN 'Az Uyuyanlar'
        WHEN [Sleep Duration] = '7-8 hours' THEN 'Yeterli Uyuyanlar'
        WHEN [Sleep Duration] = 'More than 8 hours' THEN 'Çok Uyuyanlar'
        ELSE 'Bilinmeyen'
    END AS Uyku,
    [Study Satisfaction],
    [Academic Pressure],
    SUM(Depression) AS DepresyondaOlanlar,
    COUNT(*) AS ToplamKisi
FROM ['Student Depression Dataset$']
GROUP BY
    [Study Satisfaction],
    [Academic Pressure],
    CASE
        WHEN [Sleep Duration] = '5-6 hours' OR [Sleep Duration] = 'Less than 5 hours' THEN 'Az Uyuyanlar'
        WHEN [Sleep Duration] = '7-8 hours' THEN 'Yeterli Uyuyanlar'
        WHEN [Sleep Duration] = 'More than 8 hours' THEN 'Çok Uyuyanlar'
        ELSE 'Bilinmeyen'
    END;
```
-- Uyku süresi, çalışma memnuniyeti ve akademik baskının depresyon üzerindeki etkilerini değerlendirir.

### 6. Çalışma/Saatleri ve Depresyon
```SQL
SELECT
    CASE
        WHEN [Work/Study Hours] < 50 THEN 'Az'
        WHEN [Work/Study Hours] >= 50 AND [Work/Study Hours] < 100 THEN 'Orta' 
        WHEN [Work/Study Hours] >= 100 THEN 'Çok'
        ELSE 'Bilinmeyen'
    END AS Çalışma_Süresi_Kategorisi,
    ROUND((SUM(Depression) / COUNT(*)) * 100, 2) AS Depresyon_Yuzdesi,
    SUM(Depression) AS Depresyonda_Olanlar,
    COUNT(*) AS Toplam_Ogrenci
FROM ['Student Depression Dataset$']
GROUP BY 
    CASE
        WHEN [Work/Study Hours] < 50 THEN 'Az'
        WHEN [Work/Study Hours] >= 50 AND [Work/Study Hours] < 100 THEN 'Orta' 
        WHEN [Work/Study Hours] >= 100 THEN 'Çok'
        ELSE 'Bilinmeyen'
    END;
```
-- Öğrencileri çalışma/saat kategorilerine göre gruplandırarak depresyon yüzdelerini analiz eder.

### 7. Beslenme Alışkanlıkları ve Depresyon
```SQL
SELECT
    CASE
        WHEN [Dietary Habits] = 'Healthy' THEN 'Sağlıklı'
        WHEN [Dietary Habits] = 'Unhealthy' THEN 'Sağlıksız'
        WHEN [Dietary Habits] = 'Moderate' THEN 'Orta derece sağlıklı'
        ELSE 'Bilinmeyen'
    END AS Diyet_Kategorisi,
    ROUND((SUM(Depression) / COUNT(*)) * 100, 2) AS Depresyon_Yuzdesi,
    SUM(Depression) AS Depresyonda_Olanlar,
    COUNT(*) AS Toplam_Ogrenci
FROM ['Student Depression Dataset$']
GROUP BY 
    CASE
        WHEN [Dietary Habits] = 'Healthy' THEN 'Sağlıklı'
        WHEN [Dietary Habits] = 'Unhealthy' THEN 'Sağlıksız'
        WHEN [Dietary Habits] = 'Moderate' THEN 'Orta derece sağlıklı'
        ELSE 'Bilinmeyen'
    END;
```
-- Beslenme alışkanlıklarına göre depresyon risklerini değerlendirir.

## Sonuç:

Bu analiz, öğrenci depresyonunu etkileyen faktörler hakkında içgörüler sağlamayı amaçlamaktadır. SQL sorguları, belirli gereksinimlere göre özelleştirmek için şablon olarak kullanılabilir. Sonuçlar, öğrenci refahını artırmaya yönelik müdahalelere rehberlik edebilir.



























