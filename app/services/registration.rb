class Registration
  attr_reader :user, :agency

  def initialize(user_params:)
    @user_params = user_params
    @success = false
  end

  def call
    ActiveRecord::Base.transaction do
      create_user!
      create_agency!
      assign_agency_owner!

      @success = true
    end
    self
  end

  def success?
    @success
  end

  private

  def create_user!
    @user = User.new(@user_params)
    raise ActiveRecord::Rollback unless @user.save
  end

  def create_agency!
    @agency = Agency.new(name: "#{@user.full_name}'s agency")
    return if @agency.save

    merge_agency_errors
    raise ActiveRecord::Rollback
  end

  def assign_agency_owner!
    membership = Membership.new(user:, agency:, role: :owner, status: :active)
    raise ActiveRecord::Rollback unless membership.save
  end

  def merge_agency_errors
    @agency.errors.each do |error|
      @user.errors.add(:base, error.full_message)
    end
  end
end
