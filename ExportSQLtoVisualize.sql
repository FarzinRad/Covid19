CREATE VIEW PercentPopulationVaccinated AS
Select dae.continent, dae.location, dae.date, dae.population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations as BIGINT)) OVER (Partition by dae.Location Order by dae.location, dae.Date) as RollingPeopleVaccinated
From Covid19..CovidDeath dae
Join Covid19..CovidVaccinations vac
	On dae.location = vac.location
	and dae.date = vac.date
where dae.continent is not null 
--order by 2,3