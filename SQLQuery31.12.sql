% Bunun veri analizi ile ilgisi yok tabloyu aktarirken age sutünundaki  28.0 girilmiş yaslari 280 olarak yazıyordu, düzelttim.
UPDATE ['Student Depression Dataset$'] SET Age = LEFT(Age ,2) WHERE ID >=30;


% Her bir cinsiyetteki öðrencilerin ortalama depresyon seviyesi nedir?
% Depresyon veri setindeki cinsiyete göre depresyon seviyelerini analiz eder
SELECT Gender,
       AVG(Depression) AS Ortalama_Depresyon,
       COUNT(*) AS Toplam_Veri

FROM ['Student Depression Dataset$'] 
GROUP BY Gender;          

%Depresyonda olan öðrencilerin öðrencilerin ortalama yaþý ?

SELECT AVG(Age) AS Ortalama_Yaþ

FROM ['Student Depression Dataset$'] WHERE Depression=1;   

 
%yaþ gruplarýna göre sýnýflandýrarak, her yaþ grubunda kaç öðrenci olduðunu ve kaç öðrencinin depresyonda olduðunu belirler
%Her bir yaþ grubunda kaç öðrenci depresyondadýr? and Her bir yaþ grubunda kaç öðrenci bulunmaktadýr?
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


%öðrencileri cinsiyet ve yaþ gruplarýna göre sýnýflandýrarak, her grup için çeþitli istatistiksel ölçümleri hesaplar.
%Her bir cinsiyet ve yaþ grubunda depresyon seviyesi ortalamasý nedir,depresyon oraný nedir,kaç öðrenci depresyondadýr ?

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

%öðrencileri uyku süresi, çalýþma memnuniyeti ve akademik baský seviyelerine göre gruplandýrarak, her bir grup için depresyon ile ilgili bazý istatistikleri hesaplar.
%Uyku süresi, çalýþma memnuniyeti ve akademik baský, depresyon üzerinde nasýl bir etkisi vardýr? andFarklý uyku sürelerine, çalýþma memnuniyetine ve akademik baský seviyelerine sahip öðrenci gruplarýnda depresyon oranlarý nasýl farklýlýk göstermektedir? 
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

-- çok uyuyup çok çalýþma memnuiyeti olanlarýn deprasyona girme yüzdesi
%çalýþma memnuniyeti, akademik baský ve uyku süresinin etkileþimli olarak depresyon üzerindeki etkisini daha ayrýntýlý olarak inceleme

SELECT
    CASE
        WHEN [Sleep Duration] IN ('5-6 hours', 'Less than 5 hours') THEN 'Az Uyuyanlar'
        WHEN [Sleep Duration] = '7-8 hours' THEN 'Yeterli Uyuyanlar'
        WHEN [Sleep Duration] = 'More than 8 hours' THEN 'Çok Uyuyanlar'
        ELSE 'Bilinmeyen'
    END AS UykuKategorisi,
    [Study Satisfaction],
    [Academic Pressure],
    ROUND((SUM(Depression) / COUNT(*)) * 100, 2) AS Depresyon_Yuzdesi,
    SUM(Depression) AS ToplamDepresyon,
    COUNT(*) AS ToplamKisi
FROM ['Student Depression Dataset$']
WHERE [Study Satisfaction] >= 30 AND [Academic Pressure] >= 30
GROUP BY
    [Study Satisfaction],
    [Academic Pressure],
	CASE
        WHEN [Sleep Duration] IN ('5-6 hours', 'Less than 5 hours') THEN 'Az Uyuyanlar'
        WHEN [Sleep Duration] = '7-8 hours' THEN 'Yeterli Uyuyanlar'
        WHEN [Sleep Duration] = 'More than 8 hours' THEN 'Çok Uyuyanlar'
        ELSE 'Bilinmeyen'
    END
ORDER BY [Study Satisfaction] ASC;

-- UYKU DÜZENLEÝRNE GÖRE AZ çalýþma memnuiyeti olanlarýn deprasyona girme YÜZDESÝ
%Düþük çalýþma memnuniyeti yaþayan öðrencilerin (Study Satisfaction < 30) uyku süreleri ve depresyon durumu arasýndaki iliþkiyi analiz eder
%Düþük çalýþma memnuniyeti yaþayan öðrencilerin uyku süreleri ile depresyon oranlarý arasýnda nasýl bir iliþki vardýr?
%Düþük çalýþma memnuniyeti yaþayan öðrencilerin uyku süreleri ile depresyonu arasýndaki iliþkiyi daha detaylý incelemek için hangi uyku kategorisi daha dikkat çekicidir?

SELECT
    CASE
        WHEN [Sleep Duration] IN ('5-6 hours', 'Less than 5 hours') THEN 'Az Uyuyanlar'
        WHEN [Sleep Duration] = '7-8 hours' THEN 'Yeterli Uyuyanlar'
        WHEN [Sleep Duration] = 'More than 8 hours' THEN 'Çok Uyuyanlar'
        ELSE 'Bilinmeyen'
    END AS UykuKategorisi,
    [Study Satisfaction],
    ROUND((SUM(Depression) / COUNT(*)) * 100, 2) AS Depresyon_Yuzdesi,
    SUM(Depression) AS ToplamDepresyon,
    COUNT(*) AS ToplamKisi
FROM ['Student Depression Dataset$']
WHERE [Study Satisfaction] < 30
GROUP BY
    CASE
        WHEN [Sleep Duration] IN ('5-6 hours', 'Less than 5 hours') THEN 'Az Uyuyanlar'
        WHEN [Sleep Duration] = '7-8 hours' THEN 'Yeterli Uyuyanlar'
        WHEN [Sleep Duration] = 'More than 8 hours' THEN 'Çok Uyuyanlar'
        ELSE 'Bilinmeyen'
    END,
    [Study Satisfaction]
ORDER BY  [Study Satisfaction] ASC;


--- ÇALIÞMA SAATLERÝNE GÖRE DEPRESYONA GÝRME YÜZDESÝ
%öðrencileri çalýþma/çalýþma saatlerine göre üç kategoriye ayýrarak (Az,Orta,Çok) bu kategorilerdeki öðrencilerin depresyon oranlarýný analiz eder
%Farklý çalýþma/çalýþma saatlerine sahip öðrenci gruplarýnda depresyon oranlarý nasýl farklýlýk göstermektedir?
%Çalýþma/çalýþma saatleri ile depresyon arasýnda nasýl bir iliþki vardýr?

SELECT
    CASE
        WHEN [Work/Study Hours] < 50 THEN 'Az'
        WHEN [Work/Study Hours] >= 50 AND [Work/Study Hours] < 100 THEN 'Orta' 
        WHEN [Work/Study Hours] >= 100 THEN 'Çok'
        ELSE 'Bilinmeyen'
    END AS Çalýþma_Süresi_Kategorisi,
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
    END ;

%Öðrencilerin diyet alýþkanlýklarý ile depresyon arasýndaki iliþkiyi inceler.
%Hangi diyet kategorisindeki öðrencilerin depresyon riski daha yüksek?

SELECT
    CASE
	    WHEN [Dietary Habits] = 'Healthy' Then ' Saðlýklý'
		WHEN [Dietary Habits] ='Unhealthy' Then ' Saðlýksýz'
		WHEN [Dietary Habits] ='Moderate' Then ' Orta derece saðlýklý'
		ELSE 'Bilinmeyen'
	END AS Diyet_Kategorisi,
	ROUND((SUM(Depression) / COUNT(*)) * 100, 2) AS Depresyon_Yuzdesi,
    SUM(Depression) AS Depresyonda_Olanlar,
    COUNT(*) AS Toplam_Ogrenci
FROM ['Student Depression Dataset$']
GROUP BY 
    CASE
	    WHEN [Dietary Habits] ='Healthy' Then ' Saðlýklý'
		WHEN [Dietary Habits] ='Unhealthy' Then ' Saðlýksýz'
		WHEN [Dietary Habits] ='Moderate' Then ' Orta derece saðlýklý'
		ELSE 'Bilinmeyen'
	END;


%depresyona giren öðrencilerin intihar etme düþüncesi olmasýyla iliþkisi var mý?

SELECT
    Depression,
	COUNT(*) AS Toplam_Ogrenci,
    SUM(CASE WHEN [Have you ever had suicidal thoughts ?] = 'Yes' THEN 1 ELSE 0 END) AS Ýntihar_Dusunenler,
    ROUND((SUM(CASE WHEN [Have you ever had suicidal thoughts ?] = 'Yes' THEN 1 ELSE 0 END) * 1.0 / COUNT(*)) * 100, 3) AS Ýntihar_Olasiligi
FROM ['Student Depression Dataset$']
WHERE Depression=1 
GROUP BY Depression;

%intihar etme düþüncesi olan öðrencilerin ortalama yaþý kaçtýr?
SELECT
    ROUND(AVG(CASE WHEN [Have you ever had suicidal thoughts ?] = 'Yes' THEN Age END),2) AS Ýntihar_Dusunenlerin_Ortalama_Yasi
FROM
    ['Student Depression Dataset$'];




%intihar etme düþüncesi olan öðrencilerin hangi yaþ gruplarýnda bu düþünce daha çok vardýr ?

SELECT
    CASE 
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 30 THEN '26-30'
		ELSE '30 Üstü'
    END AS Yas_grubu,
    
    SUM(CASE WHEN [Have you ever had suicidal thoughts ?]= 'Yes' THEN 1 ELSE 0 END) AS Ýntihar_Dusunenler,
	COUNT(*) AS Toplam_Ogrenci
FROM
    ['Student Depression Dataset$']
GROUP BY
    CASE 
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 30 THEN '26-30'
		ELSE '30 Üstü'
    END;

% intihar etmeyi düþünmüþ öðrencilerin akademik baský ile iliþkisi
SELECT
    [Academic Pressure],
    COUNT(*) AS Toplam_Ogrenci,
    SUM(CASE WHEN [Have you ever had suicidal thoughts ?] = 'Yes'  THEN 1 ELSE 0 END) AS Ýntihar_Dusunenler,
	ROUND((SUM(CASE WHEN  [Have you ever had suicidal thoughts ?] = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) AS Ýntiharý_Düþünme_Yuzdesi
FROM
     ['Student Depression Dataset$']
GROUP BY
    [Academic Pressure];





