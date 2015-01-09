module ClearAll
  puts 'in clear_all'
  Boss.delete_all
  Education.delete_all
  Experience.delete_all
  Job.delete_all
  LineItem.delete_all
  Rate.delete_all
  Review.delete_all
  Subordinate.delete_all
  Summary.delete_all
  User.delete_all
  Work.delete_all
end

