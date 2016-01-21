-- This code should delete a Theme tendría que también borrrar la
-- referencia de Clasification. MIrar cómo queda clasification después de borrar y 
-- meter las modificaciones que haga falta
DELETE FROM Theme
WHERE IdTheme=0;

DELETE FROM Publication
WHERE NPublisher IN (SELECT Name from Publisher);

-- Esto tendría que borrar la entrada de Clasification
DELETE FROM Publication
WHERE ISBN='B232';
