class Kitt::AccessPoints::Users < Kitt::AccessPoints
  def initialize(search:)
    @url = "https://kitt.lewagon.com/api/v1/users?search=#{search}"
  end
end
