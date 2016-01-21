-- Update theme description where ThemeID is 0
UPDATE Theme
SET Description="Esto es una nueva Description hahahah".
WHERE IdTheme=0

-- Update each theme that ID doesn't appear on classification
UPDATE Theme
SET Description="Nueva Description para el segundo tema"
WHERE IDTheme NOT IN (SELECT IDTheme FROM Clasification);