
--SELECT *
--FROM Covid19..CovidDeath
--ORDER BY 3,4

--SELECT *
--FROM Covid19..CovidVaccinations
--ORDER BY 3,4

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM Covid19..CovidDeath
ORDER BY 1,2