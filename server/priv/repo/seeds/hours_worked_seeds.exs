alias ApiProject.Repo
alias ApiProject.HoursWorked

Repo.insert! %HoursWorked{
  date: ~N[2022-10-31 00:00:00],
  normal_hours: 7.5,
  night_hours: 0.0,
  overtime_hours: 0.0,
  expected_worked_hours: 7.5,
  user_id: 1
}

Repo.insert! %HoursWorked{
  date: ~N[2022-11-01 00:00:00],
  normal_hours: 7.5,
  night_hours: 0.0,
  overtime_hours: 1.0,
  expected_worked_hours: 7.5,
  user_id: 1
}