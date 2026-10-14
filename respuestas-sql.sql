--DIFICULTAD: Muy fácil:
--1- Devuelve todas las películas.

SELECT * FROM MOVIES 

--2- Devuelve todos los géneros existentes

SELECT * FROM GENRES 

--3- Devuelve la lista de todos los estudios de grabación que estén activos

SELECT * FROM STUDIOS WHERE STUDIO_ACTIVE=1

--4- Devuelve una lista de los 20 últimos miembros en anotarse a la plataforma

SELECT * FROM USERS ORDER BY USER_JOIN_DATE DESC LIMIT 20 

--38- Devuelve una lista de los 10 usuarios con más tiempo de antigüedad en la plataforma

SELECT * FROM USERS ORDER BY USER_JOIN_DATE ASC LIMIT 10

--39- Devuelve una lista con los nombres de los actores fallecidos.

SELECT ACTOR_NAME FROM ACTORS WHERE ACTOR_DEAD_DATE IS NOT NULL

--40- Devuelve una lista con todos los nombres de los directores que estén vivos.

SELECT DIRECTOR_NAME FROM DIRECTORS WHERE DIRECTOR_DEAD_DATE IS NULL

--41- Devuelve el nombre y precio de todas las suscripciones disponibles en la plataforma

SELECT PLAN_NAME, PLAN_PRICE FROM SUBSCRIPTIONS 

--42- Devuelve la cantidad total de películas registradas en la base de datos.

SELECT count(movie_id) FROM MOVIES

--43- Devuelve las 10 películas más largas registradas en la base de datos.

SELECT * FROM MOVIES ORDER BY MOVIE_DURATION DESC LIMIT 10


--DIFICULTAD: Fácil
--5- Devuelve las 20 duraciones de películas más frecuentes, ordenados de mayor a menor

SELECT movie_duration,COUNT(movie_id) AS "NUM_MOVIES" FROM MOVIES 
GROUP BY movie_duration 
ORDER BY movie_duration DESC LIMIT 20


--6- Devuelve las películas del año 2000 en adelante que empiecen por la letra A.

SELECT * FROM MOVIES m WHERE m.MOVIE_RELEASE_DATE >=DATE'2000-01-01'and m.MOVIE_NAME LIKE 'A%'

--7- Devuelve los actores nacidos un mes de Junio

SELECT ACTOR_NAME, ACTOR_BIRTH_DATE FROM ACTORS WHERE MONTH (ACTOR_BIRTH_DATE)=6

--8- Devuelve los actores nacidos cualquier mes que no sea Junio y que sigan vivos

SELECT * FROM ACTORS WHERE MONTH (ACTOR_BIRTH_DATE)<>6 AND ACTOR_DEAD_DATE IS NULL

--9- Devuelve el nombre y la edad de todos los directores menores o iguales de 50 años que estén vivos

SELECT DIRECTOR_NAME,DATEDIFF(YEAR, DIRECTOR_BIRTH_DATE, TODAY) AS "AGE" FROM DIRECTORS 
WHERE DATEDIFF(YEAR, DIRECTOR_BIRTH_DATE, TODAY)<=50 AND DIRECTOR_DEAD_DATE IS NULL

--10- Devuelve el nombre y la edad de todos los actores menores de 50 años que hayan fallecido

SELECT ACTOR_NAME,DATEDIFF(YEAR, ACTOR_BIRTH_DATE, ACTOR_DEAD_DATE) AS "AGE" FROM ACTORS 
WHERE DATEDIFF(YEAR, ACTOR_BIRTH_DATE, ACTOR_DEAD_DATE)<50 AND ACTOR_DEAD_DATE IS NOT NULL

--11- Devuelve el nombre de todos los directores menores o iguales de 40 años que estén vivos

SELECT DIRECTOR_NAME FROM DIRECTORS WHERE DATEDIFF(YEAR, DIRECTOR_BIRTH_DATE, TODAY)<=40 
AND DIRECTOR_DEAD_DATE IS NULL

--12- Indica la edad media de los directores vivos

SELECT AVG(DATEDIFF(YEAR, DIRECTOR_BIRTH_DATE, TODAY)) AS "AGE" FROM DIRECTORS 
WHERE DIRECTOR_DEAD_DATE IS NULL


--13- Indica la edad media de los actores que han fallecido

SELECT AVG(DATEDIFF(YEAR, ACTOR_BIRTH_DATE, ACTOR_DEAD_DATE)) AS "AGE" FROM ACTORS 
WHERE ACTOR_DEAD_DATE IS NOT NULL

--44- Devuelve la cantidad de películas accedidas por cada mes del año 2016

SELECT MONTH(uma.ACCESS_DATE) AS "MONTH",COUNT(UMA.ACCESS_ID) AS "TOTAL_ACESS"
FROM USER_MOVIE_ACCESS uma
WHERE YEAR(uma.ACCESS_DATE) = 2016
GROUP BY MONTH
ORDER BY MONTH

--DIFICULTAD: Media
--14- Devuelve el nombre de todas las películas y el nombre del estudio que las ha realizado

SELECT MOVIE_NAME, STUDIO_NAME FROM MOVIES
INNER JOIN STUDIOS on
	MOVIES.STUDIO_id = STUDIOS.STUDIO_ID

--15- Devuelve los miembros que accedieron al menos una película entre el año 2010 y el 2015
	
SELECT DISTINCT u.USER_NAME, u.USER_ID FROM USERS u
INNER JOIN USER_MOVIE_ACCESS uma ON
    u.USER_ID = Uma.USER_ID
WHERE YEAR(ACCESS_DATE) >= 2010
  AND YEAR(ACCESS_DATE) <= 2015;
	
--16- Devuelve cuantas películas hay de cada país.

SELECT n.NATIONALITY_NAME, COUNT(m.MOVIE_NAME) AS "Quantity" FROM MOVIES m
INNER JOIN NATIONALITIES n ON
    m.NATIONALITY_ID = n.NATIONALITY_ID
GROUP BY n.NATIONALITY_NAME     


--17- Devuelve todas las películas que hay de género documental

SELECT m.MOVIE_NAME FROM MOVIES m 
INNER JOIN GENRES g  ON m.GENRE_ID= g.GENRE_ID 
WHERE g.GENRE_NAME = 'Documentary'

--18- Devuelve todas las películas creadas por directores nacidos a partir de 1980 y que todavía están vivos.

SELECT m.MOVIE_NAME, d.DIRECTOR_NAME FROM MOVIES m 
INNER JOIN DIRECTORS d ON 
	m.director_id=d.director_id
WHERE YEAR (d.DIRECTOR_BIRTH_DATE)>1980 
AND d.DIRECTOR_DEAD_DATE IS NULL 	

--19- Indica si hay alguna coincidencia de nacimiento de ciudad (y si las hay, indicarlas) entre los miembros de la plataforma y los directores

SELECT u.USER_TOWN, u.USER_NAME, DIRECTOR_NAME FROM USERS u
INNER JOIN DIRECTORS d
ON u.USER_town = d.DIRECTOR_BIRTH_PLACE

--20- Devuelve el nombre y el año de todas las películas que han sido producidas por un estudio que actualmente no esté activo

SELECT m.MOVIE_NAME, YEAR(m.MOVIE_RELEASE_DATE) AS "Release_year" FROM MOVIES m
INNER JOIN STUDIOS s 
ON m.STUDIO_ID=S.STUDIO_ID
WHERE S.STUDIO_ACTIVE =0  --Podríamos poner también WHERE S.STUDIO_ACTIVE =FALSE
ORDER BY YEAR(m.MOVIE_RELEASE_DATE) ASC

--21- Devuelve una lista de las últimas 10 películas a las que se ha accedido

SELECT M.MOVIE_NAME,UMA.ACCESS_DATE  FROM MOVIES m
INNER JOIN USER_MOVIE_ACCESS uma ON 
m.MOVIE_ID=uma.MOVIE_ID 
ORDER BY UMA.ACCESS_DATE DESC LIMIT 10


--22- Indica cuántas películas ha realizado cada director antes de cumplir 41 años

SELECT d.DIRECTOR_NAME, COUNT(m.MOVIE_ID) AS "Movie amount" FROM DIRECTORS d
INNER JOIN MOVIES m ON 
d.DIRECTOR_ID = m.DIRECTOR_ID
WHERE DATEDIFF(YEAR, d.DIRECTOR_BIRTH_DATE, m.MOVIE_RELEASE_DATE )<41
GROUP BY d.DIRECTOR_NAME


--23- Indica cuál es la media de duración de las películas de cada director

SELECT d.DIRECTOR_NAME, AVG(m.MOVIE_DURATION) AS "movie duration" FROM movies m
INNER JOIN directors d ON 
d.DIRECTOR_ID = m.DIRECTOR_ID
GROUP BY d.DIRECTOR_NAME

--24- Indica cuál es la el nombre y la duración mínima de las películas a las que se ha accedido en los últimos 2 años por los miembros del plataforma (La “fecha de ejecución” de esta consulta es el 25-01-2019)

SELECT m.MOVIE_NAME, m.MOVIE_DURATION  FROM MOVIES m   
INNER JOIN USER_MOVIE_ACCESS uma ON 
m.MOVIE_ID = uma.MOVIE_ID
WHERE DATEADD(YEAR,-2, DATE'2019-01-25')<uma.ACCESS_DATE 
ORDER BY m.movie_duration LIMIT 1


--25- Indica el número de películas que hayan hecho los directores durante las décadas de los 60, 70 y 80 que contengan la palabra “The” en cualquier parte del título

SELECT d.DIRECTOR_NAME, COUNT(m.movie_id) AS "Film number", GROUP_CONCAT(m.movie_name SEPARATOR ', ' ) AS "Movie name"  FROM MOVIES m
JOIN DIRECTORS d ON m.DIRECTOR_ID  = d.DIRECTOR_ID
WHERE YEAR (m.MOVIE_RELEASE_DATE)>=1960 
AND YEAR (m.MOVIE_RELEASE_DATE)<=1980
AND UPPER(m.MOVIE_NAME) LIKE '%THE%'
GROUP BY d.director_name 


--45- Devuelve los nombres de los usuarios que han accedido a más de 5 películas

SELECT u.USER_NAME, COUNT(USER_ID) AS "Number of movie accesses" FROM USERS u 
INNER JOIN USER_MOVIE_ACCESS uma ON 
u.USER_ID =uma.USER_ID 
GROUP BY u.USER_NAME 
HAVING COUNT(USER_ID)>5


--46- Devuelve la cantidad de películas en las que ha participado cada actor.

SELECT a.ACTOR_NAME, COUNT(MOVIE_ID) AS "movie amount" FROM ACTORS a
INNER JOIN MOVIES_ACTORS ma  ON 
a.ACTOR_ID =ma.ACTOR_ID 
GROUP BY a.ACTOR_NAME 

--47- Devuelve el número de películas accedidas por tipo de suscripción

SELECT s.plan_name, count(uma.movie_id) AS "movie amount" FROM USER_MOVIE_ACCESS uma 
INNER JOIN USERS u ON 
u.user_id=uma.USER_ID 
INNER JOIN subscriptions s ON 
uma.ACCESS_TYPE = s.SUBSCRIPTION_ID 
GROUP BY s.plan_name


--48- Devuelve el número de películas accedidas por cada usuario

SELECT u.USER_NAME, count(DISTINCT uma.movie_id) AS "Number of movie accesses" FROM USERS u
INNER JOIN USER_MOVIE_ACCESS uma   ON 
u.user_id=uma.USER_ID 
GROUP BY u.user_name


--49- Devuelve los nombres de los usuarios que solo han accedido a una película

SELECT u.USER_NAME, count(uma.movie_id) AS "Number of movie accesses" FROM USERS u
INNER JOIN USER_MOVIE_ACCESS uma   ON 
u.user_id=uma.USER_ID
GROUP BY u.user_name
HAVING count(uma.movie_id)=1

--DIFICULTAD: Difícil
--26- Lista nombre, nacionalidad y director de todas las películas

SELECT m.movie_name, d.director_name, n.NATIONALITY_NAME  FROM MOVIES m 
INNER JOIN DIRECTORS d ON m.director_id=d.director_id 
INNER JOIN NATIONALITIES n ON m.nationality_id=n.nationality_id

--27- Muestra las películas con los actores que han participado en cada una de ellas

SELECT m.MOVIE_NAME, m.MOVIE_ID, GROUP_CONCAT(a.ACTOR_NAME SEPARATOR ', ' ) AS "Actores y actrices" 
FROM MOVIES_ACTORS ma JOIN MOVIES m ON ma.MOVIE_ID = m.MOVIE_ID JOIN ACTORS a 
ON ma.ACTOR_ID = a.ACTOR_ID GROUP BY m.MOVIE_ID
 

--28- Indica cual es el nombre del director del que más películas se ha accedido

SELECT d.DIRECTOR_NAME,COUNT(uma.ACCESS_ID ) AS "RENTED_MOVIES" FROM USER_MOVIE_ACCESS uma
INNER JOIN MOVIES m 
    ON m.movie_id = uma.movie_id
INNER JOIN directors d
    ON m.director_id = d.DIRECTOR_ID
GROUP BY d.DIRECTOR_NAME
ORDER BY RENTED_MOVIES DESC LIMIT 1


--29- Indica cuantos premios han ganado cada uno de los estudios con las películas que han creado

SELECT s.studio_name, SUM(a.AWARD_WIN ) AS "Awards_win" FROM movies m
INNER JOIN studios s ON 
m.studio_id=s.STUDIO_ID 
INNER JOIN AWARDS a ON 
m.MOVIE_ID =a.MOVIE_ID 
GROUP BY s.STUDIO_ID


--30- Indica el número de premios a los que estuvo nominado un actor, pero que no ha conseguido (Si una película está nominada a un premio, su actor también lo está)

SELECT a.actor_name, sum(aw.AWARD_ALMOST_WIN) AS "ALMOST_WIN" FROM movies m
INNER JOIN AWARDS aw ON 
m.MOVIE_ID=aw.MOVIE_ID
INNER JOIN MOVIES_ACTORS ma  ON 
m.movie_id=ma.movie_ID 
INNER JOIN ACTORS a ON 
ma.ACTOR_ID=a.ACTOR_ID 
GROUP BY a.actor_name
ORDER BY ALMOST_WIN DESC

--31- Indica cuantos actores y directores hicieron películas para los estudios no activos

SELECT COUNT(DISTINCT ma.ACTOR_ID) AS "Número actores", COUNT(DISTINCT m.DIRECTOR_ID) AS "Número directores" FROM MOVIES m
INNER JOIN STUDIOS s ON 
s.STUDIO_ID=m.STUDIO_ID 
INNER JOIN MOVIES_ACTORS ma ON 
ma.MOVIE_ID =m.MOVIE_ID 
WHERE s.STUDIO_ACTIVE =FALSE

--32- Indica el nombre, ciudad, y teléfono de todos los miembros de la plataforma que hayan accedido películas que hayan sido nominadas a más de 150 premios y ganaran menos de 50

SELECT DISTINCT u.USER_NAME, u.USER_TOWN, u.USER_PHONE FROM USER_MOVIE_ACCESS uma
INNER JOIN awards a ON
uma.movie_id=a.MOVIE_ID
INNER JOIN USERS u ON 
uma.USER_ID=u.USER_ID 
WHERE A.AWARD_NOMINATION >150 AND a.AWARD_WIN <50

--Realizamos el ejericio anterior peor con una subconsulta:

SELECT DISTINCT u. USER_NAME, u.USER_TOWN, u. USER_PHONE FROM USERS u
INNER JOIN USER_MOVIE_ACCESS uma ON u. USER_ID = uma. USER_ID
WHERE uma. MOVIE_ID IN
(SELECT a.MOVIE_ID FROM AWARDS a WHERE a. AWARD_NOMINATION > 150 AND a. AWARD_WIN < 50)

--33- Comprueba si hay errores en la BD entre las películas y directores (un director muerto en el 76 no puede dirigir una película en el 88)
--Ya no encuentra nada porque en la pregunta 34. hemos actualizado la tabla.

SELECT D.DIRECTOR_NAME, D.DIRECTOR_DEAD_DATE, MAX(m.MOVIE_RELEASE_DATE ) AS "MOVIE_RELEASE_DATE" FROM DIRECTORS d
INNER JOIN MOVIES m ON 
d.DIRECTOR_ID = m.DIRECTOR_ID
WHERE m.MOVIE_RELEASE_DATE > d.DIRECTOR_DEAD_DATE
GROUP BY d.DIRECTOR_ID


--34- Utilizando la información de la sentencia anterior, modifica la fecha de defunción a un año más tarde del estreno de la película (mediante sentencia SQL)

--UPDATE <TABLE> SET <COLUMN> = <VALUE> WHERE <COLUMN>=<VALUE>

UPDATE DIRECTORS d SET DIRECTOR_DEAD_DATE = (SELECT MAX(DATEADD(YEAR, 1, m.MOVIE_RELEASE_DATE)) FROM MOVIES m 
WHERE m.DIRECTOR_ID = d.DIRECTOR_ID AND m.MOVIE_RELEASE_DATE > d.DIRECTOR_DEAD_DATE) 
WHERE EXISTS (SELECT 1 FROM MOVIES m WHERE m.DIRECTOR_ID = d.DIRECTOR_ID AND m.MOVIE_RELEASE_DATE > d.DIRECTOR_DEAD_DATE);
 


--50- Devuelve todas las películas que hayan sido accedidas con un tipo de acceso correspondiente a un tipo de suscripción específico , "Standard plan".

SELECT m.movie_name FROM MOVIES m
INNER JOIN USER_MOVIE_ACCESS uma ON 
m.MOVIE_ID=uma.MOVIE_ID 
INNER JOIN USERS u ON
uma.USER_ID =u.USER_ID 
INNER JOIN SUBSCRIPTIONS s ON 
u.USER_SUBSCRIPTION_ID =s.SUBSCRIPTION_ID 
WHERE s.SUBSCRIPTION_ID = 2
GROUP BY m.MOVIE_NAME 

--51- Devuelve la cantidad total de premios ganados por cada director

SELECT d.DIRECTOR_NAME, sum(a.AWARD_WIN ) AS "Premios ganados" FROM movies m
INNER JOIN directors d ON 
m.director_id=d.director_id
INNER JOIN AWARDS a ON 
m.MOVIE_ID =a.MOVIE_ID 
GROUP BY d.DIRECTOR_NAME 


--52- Devuelve los usuarios que han accedido películas cuyo género sea "Comedia" y accedido mas de 5 veces.

--No lo corregimos en clase, preguntar si está bien, no tengo claro como comprobarlo

SELECT u.USER_NAME FROM MOVIES m
INNER JOIN USER_MOVIE_ACCESS uma ON 
uma.MOVIE_ID =m.MOVIE_ID 
INNER JOIN USERS u ON 
u.USER_ID =uma.USER_ID
INNER JOIN GENRES g ON 
g.GENRE_ID =m.GENRE_ID 
WHERE g.GENRE_NAME ='Comedy'
GROUP BY u.USER_NAME
HAVING COUNT(uma.ACCESS_ID)>5


--53- Devuelve la cantidad total de películas en las que un actor y un director han trabajado juntos más de una vez.

SELECT
    COUNT(m.MOVIE_ID) AS NUM_PELICULAS, d.DIRECTOR_ID, ma.ACTOR_ID FROM MOVIES m
INNER JOIN DIRECTORS d ON m.DIRECTOR_ID = d.DIRECTOR_ID
INNER JOIN MOVIES_ACTORS ma ON m.MOVIE_ID = ma.MOVIE_ID
GROUP BY d.DIRECTOR_ID, ma.ACTOR_ID
HAVING COUNT(m.MOVIE_ID) > 1


--54- Encuentra el director que ha trabajado con el mayor número de nacionalidades diferentes en sus películas.

SELECT d.director_name, count(m.NATIONALITY_ID) AS "NUMBER_NATIONALITIES" FROM directors d
INNER JOIN MOVIES m ON 
d.director_id=m.DIRECTOR_ID
GROUP BY d.director_name ORDER BY NUMBER_NATIONALITIES DESC LIMIT 1


--DIFICULTAD: Berserk mode 
--35- Indica cuál es el género favorito de cada uno de los directores cuando dirigen una película

WITH GENRE_COUNTS AS 

(SELECT d.DIRECTOR_ID, d.DIRECTOR_NAME, g.GENRE_ID, g.GENRE_NAME, COUNT(MOVIE_ID) AS NUM_MOVIES FROM MOVIES m 
INNER JOIN DIRECTORS d ON m.DIRECTOR_ID = d.DIRECTOR_ID 

INNER JOIN GENRES g ON m.GENRE_ID = g.GENRE_ID

GROUP BY d.DIRECTOR_ID, g.GENRE_ID),
 
MAX_GENRES AS (SELECT DIRECTOR_ID, MAX(NUM_MOVIES) AS MAX_MOVIES FROM GENRE_COUNTS

GROUP BY DIRECTOR_ID )
 
SELECT gc.DIRECTOR_NAME, GROUP_CONCAT(GENRE_NAME SEPARATOR ', ') AS FAVORITE_GENRE FROM GENRE_COUNTS gc 

INNER JOIN MAX_GENRES mg ON gc.DIRECTOR_ID = mg.DIRECTOR_ID AND gc.NUM_MOVIES = mg.MAX_MOVIES

GROUP BY gc.DIRECTOR_NAME;
 


--36- Indica cuál es la nacionalidad favorita de cada uno de los estudios en la producción de las películas


WITH NATIONALITY_COUNTS AS 

(SELECT s.STUDIO_ID, s.studio_name, n.NATIONALITY_NAME, COUNT(m.NATIONALITY_ID ) AS NUM_MOVIES FROM MOVIES m 
INNER JOIN STUDIOS s ON m.STUDIO_ID =s.STUDIO_ID 

INNER JOIN NATIONALITIES n  ON m.NATIONALITY_ID =n.NATIONALITY_ID 

GROUP BY s.STUDIO_ID, n.nationality_name),
 
MAX_NATIONALITIES AS (SELECT studio_ID, MAX(NUM_MOVIES) AS MAX_MOVIES FROM NATIONALITY_COUNTS

GROUP BY studio_id )
 
SELECT nc.studio_id, nc.STUDIO_NAME,GROUP_CONCAT(NATIONALITY_NAME SEPARATOR ', ') AS FAVORITE_NATIONALITY FROM NATIONALITY_COUNTS nc

INNER JOIN MAX_NATIONALITIES mn ON nc.STUDIO_ID = mn.STUDIO_ID AND nc.NUM_MOVIES = mn.MAX_MOVIES

GROUP BY nc.STUDIO_ID, nc.STUDIO_NAME;



--37- Indica cuál fue la primera película a la que accedieron los miembros de la plataforma cuyos teléfonos tengan como último dígito el ID de alguna nacionalidad
WITH PHONE_DIGIT AS
  (SELECT USER_NAME,
          USER_ID,
          SUBSTR(USER_PHONE, LENGTH(USER_PHONE), 1) AS LAST_NUMBER
   FROM USERS),
     USER_NAT AS
  (SELECT N.NATIONALITY_ID,
          M.USER_NAME,
          M.USER_ID
   FROM NATIONALITIES N
   INNER JOIN PHONE_DIGIT M ON N.NATIONALITY_ID = M.LAST_NUMBER),
     MOVIE_ACCESS AS
  (SELECT UN.NATIONALITY_ID,
          UN.USER_NAME,
          UMA.USER_ID,
          UMA.MOVIE_ID,
          UMA.ACCESS_DATE
   FROM USER_NAT UN
   INNER JOIN USER_MOVIE_ACCESS UMA ON UN.USER_ID = UMA.USER_ID),
     MIN_ACCESS AS
  (SELECT USER_ID,
          MIN(ACCESS_DATE) AS ACCESS_DATE
   FROM MOVIE_ACCESS
   GROUP BY USER_ID)
SELECT MOA.USER_NAME,
       M.MOVIE_NAME
FROM MOVIE_ACCESS MOA
INNER JOIN MIN_ACCESS MIA ON MOA.ACCESS_DATE = MIA.ACCESS_DATE
AND MOA.USER_ID = MIA.USER_ID
INNER JOIN MOVIES M ON MOA.MOVIE_ID = M.MOVIE_ID

--55- Indica cuáles son los estudios que han producido más películas en cada década y cuantas han realizado.

WITH MOVIE_DECADE AS
  (SELECT S.STUDIO_NAME,
          (YEAR(M.MOVIE_RELEASE_DATE) / 10) * 10 AS DECADE,
          COUNT(*) AS TOTAL_MOVIES
   FROM MOVIES M
   JOIN STUDIOS S ON M.STUDIO_ID = S.STUDIO_ID
   GROUP BY S.STUDIO_NAME,
            DECADE),
     MAX_DECADE AS
  (SELECT DECADE,
          MAX(TOTAL_MOVIES) AS MAX_MOVIES
   FROM MOVIE_DECADE
   GROUP BY DECADE)
SELECT MD.STUDIO_NAME,
       MD.DECADE,
       MD.TOTAL_MOVIES
FROM MOVIE_DECADE MD
JOIN MAX_DECADE MMD ON MD.DECADE = MMD.DECADE
AND MD.TOTAL_MOVIES = MMD.MAX_MOVIES
ORDER BY MD.DECADE;
tiene menú contextual