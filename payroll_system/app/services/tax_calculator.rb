# frozen_string_literal: true

class TaxCalculator
  attr_accessor :sal_tax, :deductions_array

  def initialize(sal_tax, deductions_array)
    @sal_tax = sal_tax
    @monthly_salary = sal_tax['monthly_salary']
    @deductions_array = deductions_array
  end

  def calculate_tax
    @deduction = if @deductions_array.empty?
                   0
                 else
                   calculate_deduction
                 end
    @tentative_package = (@monthly_salary * 12)
    @tax_bracket = @tentative_package - @deduction
    tax = check_tax_bracket
    @tot_tax = tax / 12
  end

  def calculate_deduction
    deduct_limit = if @deductions_array.exists? { |element| element[:deduct_type] == 'NPS' }
                     200_000
                   else
                     150_000
                   end
    @deduction = @deductions_array.inject(0) { |sum, hash| sum + hash[:deduct_amount] }
    @deduction = deduct_limit if @deduction >= deduct_limit
    @deduction
  end

  def check_tax_bracket
    if @tax_bracket.positive? && @tax_bracket <= 300_000
      tax = 0
    elsif @tax_bracket > 300_000 && @tax_bracket <= 600_000
      tax = (@tax_bracket * 5) / 100
    elsif @tax_bracket > 600_000 && @tax_bracket <= 900_000
      tax = ((@tax_bracket * 10) / 100) + 15_000
    elsif @tax_bracket > 900_000 && @tax_bracket <= 1_200_000
      tax = ((@tax_bracket * 15) / 100) + 45_000
    elsif @tax_bracket > 1_200_000 && @tax_bracket <= 1_500_000
      tax = ((@tax_bracket * 20) / 100) + 90_000
    elsif @tax_bracket > 1_500_000
      tax = ((@tax_bracket * 30) / 100) + 150_000
    else
      puts 'INVALID'
    end
    tax
  end
end
