AVG(Depression) AS Ortalama_Depresyon
% depression de�erleri 0 ve 1 lerden olu�tu�u i�in AVG(Depression) ortalama depresyonu hesaplar
%AS Ortalama_Depresyon  ise AVG(Depression) sonu�alar�n� Ortalama_Depresyon  sut�nuna yazar


COUNT(*) AS Toplam_Veri
% tablodaki toplam sat�r say�s�n� hesaplar ve sonucu Toplam_Veri ad�yla bir s�tun olarak d�nd�r�r.

AVG(Age) AS Ortalama_Ya�
AVG(Age) Age nin ortalams�n� bulur ve bu de�erleri AS Ortalama_Ya� ile Ortalama_Ya� sut�nuna ekler

FROM ['Student Depression Dataset$'] WHERE Depression=1
Depression=1 olan  Student Depression Dataset$ tablosundaki ��rencilere i�lem yapar.

    CASE
� � � � WHEN Age BETWEEN 18 AND 25 THEN '18-25'
� � � � WHEN Age BETWEEN 26 AND 30 THEN '26-30'
� � � � ELSE '30 �st�'
� � END AS Yasgrubu
yap�s� ya� 18 25 aras�nda olan ��rencileri 18-25 ,ya� 26 30 aras�nda olan ��rencileri 26-30,ya�� 30 �st�  olan ��rencileri 30 �st� olarak s�n�flar. ve bu sut�nun ismine Yasgrubu der.

SUM(Depression) AS DepresyondaOlanlar
Depresyonda_Olanlar ad�nda yeni bir s�tun olu�turur ve bu s�tuna, o gruptaki t�m ��rencilerin depresyon de�erlerinin toplam�n� atar.

ROUND(AVG(Depression),2) AS Ortalama_Depresyon_Skoru
Depresyo s�tunundaki de�erlerin ortalamas�n� al�r, bu ortalamay� iki ondal�k basama�a yuvarlar ve sonucu Ortalama_Depresyon_Skoru ad�nda yeni bir s�tun olarak g�sterir.

ROUND((SUM(Depression) / COUNT(*)) * 100, 2) AS Depresyon_Yuzdesi
Depresyon s�tunundaki de�erlerin toplam�n� alarak, bu toplam� sat�r say�s�na b�lerek ve sonucu y�zdeye �evirerek, depresyon y�zdesini hesaplar. Daha sonra bu de�eri iki ondal�k basama�a yuvarlar ve sonucu Depresyon_Yuzdesi ad�nda yeni bir s�tuna atar.

AS subquery
�� sorguyu bir isimle etiketleyerek, d�� sorguda bu i� sorguya daha kolay ve anla��l�r bir �ekilde referans vermemizi sa�lar.


ASC
tabloyu artan s�rayla yazar.










