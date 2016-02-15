SELECT LANGUAGE
FROM PUBLICATION
GROUP BY LANGUAGE
HAVING COUNT(LANGUAGE)>=2;


-- Update theme description where ThemeID is 0
UPDATE Theme
SET Description='Esto es una nueva Description hahahah'
WHERE IDTHEME=0;

-- Update each theme that ID doesn't appear on classification
UPDATE Theme
SET Description="Nueva Description para el segundo tema"
WHERE IDTheme NOT IN (SELECT IDTheme FROM Clasification);