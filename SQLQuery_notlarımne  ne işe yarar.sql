AVG(Depression) AS Ortalama_Depresyon
% depression deðerleri 0 ve 1 lerden oluþtuðu için AVG(Depression) ortalama depresyonu hesaplar
%AS Ortalama_Depresyon  ise AVG(Depression) sonuçalarýný Ortalama_Depresyon  sutünuna yazar


COUNT(*) AS Toplam_Veri
% tablodaki toplam satýr sayýsýný hesaplar ve sonucu Toplam_Veri adýyla bir sütun olarak döndürür.

AVG(Age) AS Ortalama_Yaþ
AVG(Age) Age nin ortalamsýný bulur ve bu deðerleri AS Ortalama_Yaþ ile Ortalama_Yaþ sutünuna ekler

FROM ['Student Depression Dataset$'] WHERE Depression=1
Depression=1 olan  Student Depression Dataset$ tablosundaki öðrencilere iþlem yapar.

    CASE
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 30 THEN '26-30'
        ELSE '30 Üstü'
    END AS Yasgrubu
yapýsý yaþ 18 25 arasýnda olan öðrencileri 18-25 ,yaþ 26 30 arasýnda olan öðrencileri 26-30,yaþý 30 üstü  olan öðrencileri 30 Üstü olarak sýnýflar. ve bu sutünun ismine Yasgrubu der.

SUM(Depression) AS DepresyondaOlanlar
Depresyonda_Olanlar adýnda yeni bir sütun oluþturur ve bu sütuna, o gruptaki tüm öðrencilerin depresyon deðerlerinin toplamýný atar.

ROUND(AVG(Depression),2) AS Ortalama_Depresyon_Skoru
Depresyo sütunundaki deðerlerin ortalamasýný alýr, bu ortalamayý iki ondalýk basamaða yuvarlar ve sonucu Ortalama_Depresyon_Skoru adýnda yeni bir sütun olarak gösterir.

ROUND((SUM(Depression) / COUNT(*)) * 100, 2) AS Depresyon_Yuzdesi
Depresyon sütunundaki deðerlerin toplamýný alarak, bu toplamý satýr sayýsýna bölerek ve sonucu yüzdeye çevirerek, depresyon yüzdesini hesaplar. Daha sonra bu deðeri iki ondalýk basamaða yuvarlar ve sonucu Depresyon_Yuzdesi adýnda yeni bir sütuna atar.

AS subquery
Ýç sorguyu bir isimle etiketleyerek, dýþ sorguda bu iç sorguya daha kolay ve anlaþýlýr bir þekilde referans vermemizi saðlar.


ASC
tabloyu artan sýrayla yazar.










