class TaxCalculator

  attr_accessor :sal_tax, :deductions_array

  def initialize(sal_tax, deductions_array)
    @sal_tax = sal_tax
    @monthly_salary = sal_tax['monthly_salary']
    @deductions_array = deductions_array
  end

  def calculate_tax
    if @deductions_array.empty?
      @deduction = 0
    else
      @deduction = calculate_deduction
    end
    @tentative_package = (@monthly_salary * 12)
    @tax_bracket = @tentative_package - @deduction
    tax = check_tax_bracket
    @tot_tax = tax / 12
  end

  def calculate_deduction
    if @deductions_array.exists?{|element| element[:deduct_type] == "NPS"}
      deduct_limit = 200000
    else
      deduct_limit = 150000
    end
    @deduction = @deductions_array.inject(0) {|sum, hash| sum + hash[:deduct_amount]}
    if @deduction >= deduct_limit 
      @deduction = deduct_limit
    end
    @deduction
  end

  def check_tax_bracket
    if @tax_bracket > 0 && @tax_bracket <= 300000
      tax = 0
    elsif @tax_bracket > 300000 && @tax_bracket <= 600000
      tax = (@tax_bracket * 5) / 100
    elsif @tax_bracket > 600000 && @tax_bracket <= 900000
      tax = ((@tax_bracket * 10) / 100) + 15000
    elsif @tax_bracket > 900000 && @tax_bracket <= 1200000
      tax = ((@tax_bracket * 15) / 100) + 45000
    elsif @tax_bracket > 1200000 && @tax_bracket <= 1500000
      tax = ((@tax_bracket * 20) / 100) + 90000
    elsif @tax_bracket > 1500000
      tax = ((@tax_bracket * 30) / 100) + 150000
    else
      puts "INVALID"
    end
    tax
  end

end