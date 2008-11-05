class Float
  def round_to(x)
    (self * 10**x).round.to_f / 10**x
  end
end
#who am i to argue with ducks?
class Fixnum
  def round_to(x)
    self
  end
end
