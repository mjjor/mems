class CalcFractions < ActiveRecord::Base

validates params[:fractnum1], numericality: true
	{ message: "1st value is not a numeric entry" } 
validates params[:fractnum2], numericality: true 
	{ message: "2nd value is not a numeric entry" }
validates params[:fractnum3], numericality: true
	{ message: "3rd value is not a numeric entry" }
validates params[:fractnum4], numericality: true 
	{ message: "4th value is not a numeric entry" }
validates params[:fractnum5], numericality: true
	{ message: "5th value is not a numeric entry" }

end