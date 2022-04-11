
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


-- Compare total cases VS Population
SELECT location, date, total_cases, population, (total_cases/population)*100 AS patients_precentage
FROM Covid19..CovidDeath
WHERE location LIKE '%states%'
ORDER BY 1,2

-- Countries with the highest infection rate compared to population
SELECT location, population, MAX(total_cases) AS HighestInfectionCount,  MAX((total_cases/population))*100 AS PrecentagePopulationInfected
FROM Covid19..CovidDeath
GROUP BY location, population
ORDER BY 4 DESC

-- Which Countries have the highest death compared to population 
SELECT location, population, MAX(CAST(total_deaths AS int)) AS HighestDeathCount,  MAX(CAST(total_deaths AS int)/population)*100 AS PrecentagePopulationDeath
FROM Covid19..CovidDeath
WHERE continent is not null
GROUP BY location, population
ORDER BY 4 DESC