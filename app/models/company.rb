require 'ostruct'
class Company < OpenStruct
  # to get company_path(company) to work
  def to_param
    _id
  end
end
