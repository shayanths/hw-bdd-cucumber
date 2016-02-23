# Add a declarative step here for populating the DB with movies.
movie_index = 0
Given /the following movies exist/ do |movies_table|
  movie_index = 0
  movies_table.hashes.each do |movie|
    Movie.create(movie)
    movie_index = movie_index + 1
  end
end

# Make sure that one strcuc ing (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  # assert page.body =~ /#{e1}.+#{e2}/m
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  page.should have_css("table#movies tbody tr", :count=>movie_index.to_i)
end


# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.delete!("\"")
  if uncheck.nil?
    rating_list.split(',').each do |checked_value|
      check("ratings["+checked_value.strip+"]")
    end
  else
    rating_list.split(',').each do |field_value|
      uncheck("ratings["+field_value.strip+"]")
    end
  end
end


