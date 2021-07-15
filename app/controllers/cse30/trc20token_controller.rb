class Cse30::Trc20tokenController < Cse30::AddressController

  before_action :is_native

  def smart_contract
    render 'cse30/smart_contract/show'
  end

  def methods
    render 'cse30/smart_contract/methods'
  end

  def events
    render 'cse30/smart_contract/events'
  end

  def transactions
    render 'cse30/smart_contract/transactions'
  end

  def inflow
    render 'cse30/address/inflow'
  end

  def outflow
    render 'cse30/address/outflow'
  end

  def calls_contracts
    render 'cse30/address/calls_contracts'
  end

  private

  def is_native
    @token = params[:address]
    @native_token = native_token?
    @token_info = !@native_token && @info.smart_contract.currency
  end

  def native_token?
    @address == @network[:currency]
  end

  def redirect_by_type
    return if native_token?
    if !(sc = @info.try(:smart_contract))
      change_controller!  'cse30/address'
    elsif !sc.try(:currency)
      change_controller! 'cse30/smart_contract'
    end
  end

end
