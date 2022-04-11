
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

-- Continent with the most Highest death
SELECT location, MAX(CAST(total_deaths AS int)) AS ContinentDeath
FROM Covid19..CovidDeath
WHERE continent is null
GROUP BY location
ORDER BY ContinentDeath DESC

-- Relation Between New Cases and New death
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From Covid19..CovidDeath
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2


-- Check the Vaccination data
SELECT *
FROM Covid19..CovidVaccinations

-- Joining the vaccination data with death data
SELECT *
FROM Covid19..CovidDeath dae
JOIN Covid19..CovidVaccinations vac
	ON dae.location = vac.location
	AND dae.date = vac.date


-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine
SELECT dae.continent, dae.location,dae.date, dae.population, vac.new_vaccinations
FROM Covid19..CovidDeath dae
JOIN Covid19..CovidVaccinations vac
	ON dae.location = vac.location
	AND dae.date = vac.date
WHERE dae.continent is not null
ORDER BY 2,3



-- Oder by location and date and sum day to day of vaccination.
Select dae.continent, dae.location, dae.date, dae.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dae.Location Order by dae.location, dae.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From Covid19..CovidDeath dae
Join Covid19..CovidVaccinations vac
	On dae.location = vac.location
	and dae.date = vac.date
where dae.continent is not null 
order by 2,3

-- Use the CTE method for calculate precent RollingPeopleVaccinated in a table
-- Also we can use the Temp Table method, but it's more comfotable for me...

with PopVsVac (continant, location, date, population, new_vaccination, RollingPeopleVaccinated)
AS
(
Select dae.continent, dae.location, dae.date, dae.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dae.Location Order by dae.location, dae.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From Covid19..CovidDeath dae
Join Covid19..CovidVaccinations vac
	On dae.location = vac.location
	and dae.date = vac.date
where dae.continent is not null 
--order by 2,3
)
SELECT *, (RollingPeopleVaccinated/population)*100
FROM PopVsVac


