-- Query 1
SELECT TOP 201 DisplayName, Location, Reputation 
FROM Users
ORDER BY Reputation DESC;

-- Query 2
SELECT TOP 201 p.Title , u.DisplayName 
FROM Posts p
INNER JOIN Users AS u ON p.OwnerUserId = u.id
WHERE p.OwnerUserId IS NOT NULL AND p.Title IS NOT NULL;

-- Query 3
SELECT TOP 201 u.DisplayName, AVG(p.Score) AS AverageScore
FROM Posts p
INNER JOIN Users u ON p.OwnerUserId = u.Id
WHERE p.OwnerUserId IS NOT NULL
GROUP BY u.DisplayName
ORDER BY AverageScore DESC;

-- Query 4
SELECT u.DisplayName
FROM Users AS u
WHERE u.id IN (
    SELECT c.UserId
    FROM Comments AS c
    GROUP BY c.UserId
    HAVING COUNT(c.Id) > 100
);

-- Query 5
UPDATE Users
SET Location =  'Desconocido'
WHERE Location IS NULL OR Location = '';
PRINT 'La actualización se realizó correctamente.';
SELECT TOP 201 Id, DisplayName, Location
FROM Users
WHERE Location = 'Desconocido'

-- Query 6
DELETE Comments
FROM Comments
JOIN Users ON Comments.UserId = Users.Id
WHERE Users.Reputation < 100;

PRINT 'Número de comentarios eliminados: ' + CAST(@@ROWCOUNT AS NVARCHAR(10));

-- Query 7
SELECT TOP 201
	u.DisplayName,
	(SELECT COUNT(*) FROM Posts WHERE OwnerUserId = u.Id) AS TotalPosts,
	(SELECT COUNT(*) FROM Comments WHERE UserId = u.Id) AS TotalComments,
	(SELECT COUNT(*) FROM Badges WHERE UserId = u.Id) AS TotalComments
FROM
	Users u
ORDER BY
	TotalPosts DESC, u.DisplayName;

-- Query 8
SELECT TOP 10
    Title,
    Score
FROM Posts
ORDER BY Score DESC;

-- Query 9
SELECT TOP 5
    Text,
    CreationDate
FROM Comments
ORDER BY CreationDate DESC;