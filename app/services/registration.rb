class Registration
  attr_reader :user, :agency

  def initialize(user_params:, agency_params:)
    @user_params = user_params
    @agency_params = agency_params
    @success = false
  end

  def call
    ActiveRecord::Base.transaction do
      @user = User.new(@user_params)
      raise ActiveRecord::Rollback unless @user.save

      @agency = Agency.new(@agency_params)
      unless @agency.save
        merge_agency_errors
        raise ActiveRecord::Rollback
      end

      membership = Membership.new(user: @user, agency: @agency, role: :owner, status: :active)
      raise ActiveRecord::Rollback unless membership.save

      @success = true
    end
    self
  end

  def success?
    @success
  end

  private

  def merge_agency_errors
    @agency.errors.each do |error|
      @user.errors.add(:"agency_#{error.attribute}", error.message)
    end
  end
end
