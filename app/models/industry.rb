require 'ostruct'
class Industry < OpenStruct
  # to get industry_path(industry) to work
  def to_param
    _id
  end
end

