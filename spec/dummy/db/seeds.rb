if Homeland::Section.count == 0
  Homeland::Section.create(:name => "Foo")
end

if Homeland::Node.count == 0
  Homeland::Node.create(:name => "Bar", :summary => "Foo bar.", :section => Homeland::Section.first)
end