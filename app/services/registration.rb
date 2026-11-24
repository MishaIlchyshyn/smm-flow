class Registration
  attr_reader :user, :agency

  def initialize(user_params:)
    @user_params = user_params
    @success = false
  end

  def call
    @user = User.new(@user_params)
    @agency = @user.build_agency(name: "#{@user.full_name}'s agency")
    @success = @user.save
    self
  end

  def success?
    @success
  end
end
