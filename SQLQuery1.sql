
--SELECT *
--FROM Covid19..CovidDeath
--ORDER BY 3,4

--SELECT *
--FROM Covid19..CovidVaccinations
--ORDER BY 3,4

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM Covid19..CovidDeath
ORDER BY 1,2

-- Compare total cases VS total death and find the precentage:

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS death_precentage
FROM Covid19..CovidDeath
WHERE location LIKE 'Turkey'
ORDER BY 1,2