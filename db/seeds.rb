require 'open-uri'
require 'nokogiri'

ALPHA = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]


 def make_symptoms
   ALPHA.each do |letter|
     Nokogiri::HTML(open("https://www.medicinenet.com/symptoms_and_signs/alpha_#{letter}.htm")).css(".AZ_results ul li").each do |i|
       Symptom.create(:name => i.css("a").text.downcase)
     end
   end
 end

 def make_medications
   ALPHA.each do |letter|
     Nokogiri::HTML(open("https://www.medicinenet.com/medications/alpha_#{letter}.htm")).css(".AZ_results ul li").each do |i|
       Medication.create(:name => i.css("a").text.downcase)
     end
   end
 end

make_symptoms
make_medications
