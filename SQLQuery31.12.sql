% Bunun veri analizi ile ilgisi yok tabloyu aktar�rken age sut�nundaki 28.0 girilmi� ya�lar� 280 olarak yazm��t� d�zelttim
UPDATE ['Student Depression Dataset$'] SET Age = LEFT(Age ,2) WHERE �D >=30;


% Her bir cinsiyetteki ��rencilerin ortalama depresyon seviyesi nedir?
% Depresyon veri setindeki cinsiyete g�re depresyon seviyelerini analiz eder
SELECT Gender,
� � � �AVG(Depression) AS Ortalama_Depresyon,
� � � �COUNT(*) AS Toplam_Veri

FROM ['Student Depression Dataset$']�
GROUP BY Gender;� � � � � 

%Depresyonda olan ��rencilerin ��rencilerin ortalama ya�� ?

SELECT AVG(Age) AS Ortalama_Ya�

FROM ['Student Depression Dataset$'] WHERE Depression=1;� �

�
%ya� gruplar�na g�re s�n�fland�rarak, her ya� grubunda ka� ��renci oldu�unu ve ka� ��rencinin depresyonda oldu�unu belirler
%Her bir ya� grubunda ka� ��renci depresyondad�r? and Her bir ya� grubunda ka� ��renci bulunmaktad�r?
SELECT
   CASE
� � � � WHEN Age BETWEEN 18 AND 25 THEN '18-25'
� � � � WHEN Age BETWEEN 26 AND 30 THEN '26-30'
� � � � ELSE '30 �st�'
� � END AS Yasgrubu,

� � COUNT(*) AS ToplamOgrenci,
� � SUM(Depression) AS DepresyondaOlanlar

FROM ['Student Depression Dataset$']
GROUP BY 
    CASE
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 30 THEN '26-30'
        ELSE '30 �st�'
    END;


%��rencileri cinsiyet ve ya� gruplar�na g�re s�n�fland�rarak, her grup i�in �e�itli istatistiksel �l��mleri hesaplar.
%Her bir cinsiyet ve ya� grubunda depresyon seviyesi ortalamas� nedir,depresyon oran� nedir,ka� ��renci depresyondad�r ?

SELECT
� � Gender, Yas_grubu,
    ROUND(AVG(Depression),2) AS Ortalama_Depresyon_Skoru,
	ROUND((SUM(Depression) / COUNT(*)) * 100, 2) AS Depresyon_Yuzdesi,
	SUM(Depression) AS Depresyonda_Olanlar,
	COUNT(*) AS Toplam_Ogrenci
FROM (

� � SELECT *,
        CASE
� � � � � � WHEN Age BETWEEN 18 AND 25 THEN '18-25'
            WHEN Age BETWEEN 26 AND 30 THEN '26-30'
			ELSE '30 �st�'
� � � � END AS Yas_grubu
� � FROM ['Student Depression Dataset$']
) AS subquery

GROUP BY Gender, Yas_grubu
ORDER BY Gender, Yas_grubu;

%��rencileri uyku s�resi, �al��ma memnuniyeti ve akademik bask� seviyelerine g�re grupland�rarak, her bir grup i�in depresyon ile ilgili baz� istatistikleri hesaplar.
%Uyku s�resi, �al��ma memnuniyeti ve akademik bask�, depresyon �zerinde nas�l bir etkisi vard�r? andFarkl� uyku s�relerine, �al��ma memnuniyetine ve akademik bask� seviyelerine sahip ��renci gruplar�nda depresyon oranlar� nas�l farkl�l�k g�stermektedir? 
SELECT
    CASE
        WHEN [Sleep Duration] = '5-6 hours' OR [Sleep Duration] = 'Less than 5 hours' THEN 'Az Uyuyanlar'
        WHEN [Sleep Duration] = '7-8 hours' THEN 'Yeterli Uyuyanlar'
        WHEN [Sleep Duration] = 'More than 8 hours' THEN '�ok Uyuyanlar'
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
        WHEN [Sleep Duration] = 'More than 8 hours' THEN '�ok Uyuyanlar'
        ELSE 'Bilinmeyen'
    END;

-- �ok uyuyup �ok �al��ma memnuiyeti olanlar�n deprasyona girme y�zdesi
%�al��ma memnuniyeti, akademik bask� ve uyku s�resinin etkile�imli olarak depresyon �zerindeki etkisini daha ayr�nt�l� olarak inceleme

SELECT
    CASE
        WHEN [Sleep Duration] IN ('5-6 hours', 'Less than 5 hours') THEN 'Az Uyuyanlar'
        WHEN [Sleep Duration] = '7-8 hours' THEN 'Yeterli Uyuyanlar'
        WHEN [Sleep Duration] = 'More than 8 hours' THEN '�ok Uyuyanlar'
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
        WHEN [Sleep Duration] = 'More than 8 hours' THEN '�ok Uyuyanlar'
        ELSE 'Bilinmeyen'
    END
ORDER BY [Study Satisfaction] ASC;

-- UYKU D�ZENLE�RNE G�RE AZ �al��ma memnuiyeti olanlar�n deprasyona girme Y�ZDES�
%D���k �al��ma memnuniyeti ya�ayan ��rencilerin (Study Satisfaction < 30) uyku s�releri ve depresyon durumu aras�ndaki ili�kiyi analiz eder
%D���k �al��ma memnuniyeti ya�ayan ��rencilerin uyku s�releri ile depresyon oranlar� aras�nda nas�l bir ili�ki vard�r?
%D���k �al��ma memnuniyeti ya�ayan ��rencilerin uyku s�releri ile depresyonu aras�ndaki ili�kiyi daha detayl� incelemek i�in hangi uyku kategorisi daha dikkat �ekicidir?

SELECT
    CASE
        WHEN [Sleep Duration] IN ('5-6 hours', 'Less than 5 hours') THEN 'Az Uyuyanlar'
        WHEN [Sleep Duration] = '7-8 hours' THEN 'Yeterli Uyuyanlar'
        WHEN [Sleep Duration] = 'More than 8 hours' THEN '�ok Uyuyanlar'
        ELSE 'Bilinmeyen'
    END AS UykuKategorisi,
    [Study Satisfaction],
    ROUND((SUM(Depression) / COUNT(*)) * 100, 2) AS Depresyon_Yuzdesi,
    SUM(Depression) AS ToplamDepresyon,
    COUNT(*) AS ToplamKisi
FROM ['Student Depression Dataset$']
WHERE [Study Satisfaction] < 30
GROUP BY
� � CASE
� � � � WHEN [Sleep Duration] IN ('5-6 hours', 'Less than 5 hours') THEN 'Az Uyuyanlar'
� � � � WHEN [Sleep Duration] = '7-8 hours' THEN 'Yeterli Uyuyanlar'
� � � � WHEN [Sleep Duration] = 'More than 8 hours' THEN '�ok Uyuyanlar'
� � � � ELSE 'Bilinmeyen'
� � END,
� � [Study Satisfaction]
ORDER BY� [Study Satisfaction] ASC;


--- �ALI�MA SAATLER�NE G�RE DEPRESYONA G�RME Y�ZDES�
%��rencileri �al��ma/�al��ma saatlerine g�re �� kategoriye ay�rarak (Az,Orta,�ok) bu kategorilerdeki ��rencilerin depresyon oranlar�n� analiz eder
%Farkl� �al��ma/�al��ma saatlerine sahip ��renci gruplar�nda depresyon oranlar� nas�l farkl�l�k g�stermektedir?
%�al��ma/�al��ma saatleri ile depresyon aras�nda nas�l bir ili�ki vard�r?

SELECT
    CASE
        WHEN [Work/Study Hours] < 50 THEN 'Az'
        WHEN [Work/Study Hours] >= 50 AND [Work/Study Hours] < 100 THEN 'Orta' 
        WHEN [Work/Study Hours] >= 100 THEN '�ok'
        ELSE 'Bilinmeyen'
    END AS �al��ma_S�resi_Kategorisi,
    ROUND((SUM(Depression) / COUNT(*)) * 100, 2) AS Depresyon_Yuzdesi,
    SUM(Depression) AS Depresyonda_Olanlar,
    COUNT(*) AS Toplam_Ogrenci
FROM ['Student Depression Dataset$']
GROUP BY�
    CASE
        WHEN [Work/Study Hours] < 50 THEN 'Az'
        WHEN [Work/Study Hours] >= 50 AND [Work/Study Hours] < 100 THEN 'Orta' 
        WHEN [Work/Study Hours] >= 100 THEN '�ok'
        ELSE 'Bilinmeyen'
    END ;

%��rencilerin diyet al��kanl�klar� ile depresyon aras�ndaki ili�kiyi inceler.
%Hangi diyet kategorisindeki ��rencilerin depresyon riski daha y�ksek?

SELECT
    CASE
	    WHEN [Dietary Habits] = 'Healthy' Then ' Sa�l�kl�'
		WHEN [Dietary Habits] ='Unhealthy' Then ' Sa�l�ks�z'
		WHEN [Dietary Habits] ='Moderate' Then ' Orta derece sa�l�kl�'
		ELSE 'Bilinmeyen'
	END AS Diyet_Kategorisi,
	ROUND((SUM(Depression) / COUNT(*)) * 100, 2) AS Depresyon_Yuzdesi,
    SUM(Depression) AS Depresyonda_Olanlar,
    COUNT(*) AS Toplam_Ogrenci
FROM ['Student Depression Dataset$']
GROUP BY 
    CASE
	    WHEN [Dietary Habits] ='Healthy' Then ' Sa�l�kl�'
		WHEN [Dietary Habits] ='Unhealthy' Then ' Sa�l�ks�z'
		WHEN [Dietary Habits] ='Moderate' Then ' Orta derece sa�l�kl�'
		ELSE 'Bilinmeyen'
	END;


%depresyona giren ��rencilerin intihar etme d���ncesi olmas�yla ili�kisi var m�?

SELECT
    Depression,
	COUNT(*) AS Toplam_Ogrenci,
    SUM(CASE WHEN [Have you ever had suicidal thoughts ?] = 'Yes' THEN 1 ELSE 0 END) AS �ntihar_Dusunenler,
    ROUND((SUM(CASE WHEN [Have you ever had suicidal thoughts ?] = 'Yes' THEN 1 ELSE 0 END) * 1.0 / COUNT(*)) * 100, 3) AS �ntihar_Olasiligi
FROM ['Student Depression Dataset$']
WHERE Depression=1 
GROUP BY Depression;

%intihar etme d���ncesi olan ��rencilerin ortalama ya�� ka�t�r?
SELECT
    ROUND(AVG(CASE WHEN [Have you ever had suicidal thoughts ?] = 'Yes' THEN Age END),2) AS �ntihar_Dusunenlerin_Ortalama_Yasi
FROM
    ['Student Depression Dataset$'];




%intihar etme d���ncesi olan ��rencilerin hangi ya� gruplar�nda bu d���nce daha �ok vard�r ?

SELECT
    CASE 
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 30 THEN '26-30'
		ELSE '30 �st�'
� � END AS Yas_grubu,
    
    SUM(CASE WHEN [Have you ever had suicidal thoughts ?]= 'Yes' THEN 1 ELSE 0 END) AS �ntihar_Dusunenler,
	COUNT(*) AS Toplam_Ogrenci
FROM
    ['Student Depression Dataset$']
GROUP BY
    CASE 
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 30 THEN '26-30'
		ELSE '30 �st�'
� � END;

% intihar etmeyi d���nm�� ��rencilerin akademik bask� ile ili�kisi
SELECT
    [Academic Pressure],
    COUNT(*) AS Toplam_Ogrenci,
    SUM(CASE WHEN [Have you ever had suicidal thoughts ?] = 'Yes'  THEN 1 ELSE 0 END) AS �ntihar_Dusunenler,
	ROUND((SUM(CASE WHEN  [Have you ever had suicidal thoughts ?] = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)), 2) AS �ntihar�_D���nme_Yuzdesi
FROM
     ['Student Depression Dataset$']
GROUP BY
    [Academic Pressure];





