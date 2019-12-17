require 'nokogiri'
require 'pry'

# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text 
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("ul.project-meta span.location-name").text
# percent funded: project.css("ul.project-stats li.first.funded strong").text

def create_project_hash
  #Opens the file and reads it into a variable
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  #binding.pry 

  projects = {}

  kickstarter.css("li.project.grid_4").each do |project|
    my_title = project.css("h2.bbcard_name strong a").text
    my_image_link = project.css("div.project-thumbnail a img").attribute("src").value
    my_description = project.css("p.bbcard_blurb").text
    my_location = project.css("ul.project-meta span.location-name").text
    my_percent = project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i

    projects[my_title] = Hash.new
    projects[my_title][:image_link] = my_image_link
    projects[my_title][:description] = my_description
    projects[my_title][:location] = my_location
    projects[my_title][:percent_funded] = my_percent
  end #each
  projects
end

#create_project_hash 