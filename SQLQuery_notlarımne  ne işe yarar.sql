AVG(Depression) AS Ortalama_Depresyon
% depression değerleri 0 ve 1 lerden oluştuğu için AVG(Depression) ortalama depresyonu hesaplar
%AS Ortalama_Depresyon  ise AVG(Depression) sonuçalarını Ortalama_Depresyon  sutünuna yazar


COUNT(*) AS Toplam_Veri
% tablodaki toplam satır sayısını hesaplar ve sonucu Toplam_Veri adıyla bir sütun olarak döndürür.

AVG(Age) AS Ortalama_Yaş
AVG(Age) Age nin ortalamsını bulur ve bu değerleri AS Ortalama_Yaş ile Ortalama_Yaş sutünuna ekler

FROM ['Student Depression Dataset$'] WHERE Depression=1
Depression=1 olan  Student Depression Dataset$ tablosundaki öğrencilere işlem yapar.

    CASE
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 30 THEN '26-30'
        ELSE '30 Üstü'
    END AS Yasgrubu
yapısı yaş 18 25 arasında olan öğrencileri 18-25 ,yaş 26 30 arasında olan öğrencileri 26-30,yaşı 30 üstü  olan öğrencileri 30 Üstü olarak sınıflar. ve bu sutünun
ismine Yasgrubu der.

SUM(Depression) AS DepresyondaOlanlar
Depresyonda_Olanlar adında yeni bir sütun oluşturur ve bu sütuna, o gruptaki tüm öğrencilerin depresyon değerlerinin toplamını atar.

ROUND(AVG(Depression),2) AS Ortalama_Depresyon_Skoru
Depresyo sütunundaki değerlerin ortalamasını alır, bu ortalamayı iki ondalık basamağa yuvarlar ve sonucu Ortalama_Depresyon_Skoru adında yeni bir sütun olarak
gösterir.

ROUND((SUM(Depression) / COUNT(*)) * 100, 2) AS Depresyon_Yuzdesi
Depresyon sütunundaki değerlerin toplamını alarak, bu toplamı satır sayısına bölerek ve sonucu yüzdeye çevirerek, depresyon yüzdesini hesaplar. Daha sonra bu 
değeri iki ondalık basamağa yuvarlar ve sonucu Depresyon_Yuzdesi adında yeni bir sütuna atar.

AS subquery
İç sorguyu bir isimle etiketleyerek, dış sorguda bu iç sorguya daha kolay ve anlaşılır bir şekilde referans vermemizi sağlar.


ASC
tabloyu artan sırayla yazar.










