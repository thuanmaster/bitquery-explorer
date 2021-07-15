class Cse30::SmartContractController < Cse30::AddressController

  def inflow
    render 'cse30/address/inflow'
  end

  def outflow
    render 'cse30/address/outflow'
  end

  def calls_contracts
    render 'cse30/address/calls_contracts'
  end

  def money_flow
    render 'cse30/address/money_flow'
  end

  private

  def redirect_by_type
    if !(sc = @info.try(:smart_contract))
      change_controller! 'cse30/address'
    elsif sc.try(:currency)
      change_controller! 'cse30/trc20token'
    end
  end

end
