# class Openchain::SmartContractController < Openchain::AddressController
class Openchain::SmartContractController < NetworkController
  layout 'tabs'

  before_action :token, :breadcrumb

  QUERY = BitqueryGraphql::Client.parse <<-'GRAPHQL'
   query ( $token: String!){
                    tron{
                      transfers(
                        currency: {is: $token}
                        ) {
             currency {
                            address
                            symbol
                            tokenId
                            tokenType
                          }


                      }
                    }
                  }
  GRAPHQL

  def transfers
    render 'openchain/token/transfers'
  end

  def holders
    render 'openchain/token/holders'
  end

  def senders
    render 'openchain/trc20token/senders'
  end

  def receivers
    render 'openchain/trc20token/receivers'
  end

  def trades
    render 'openchain/trc20token/trades'
  end

  private

  def token
    @token = params[:address]
    # result = BitqueryGraphql::Client.query(QUERY, variables: { token: @token }).data.tron.transfers
    # @info = result.currency
  rescue Net::ReadTimeout => e
    Raven.capture_exception e
    sleep(1)
    retry
  end

  def breadcrumb
    action_name == 'show' ?
      @breadcrumbs.last[:name] = "#{t("tabs.#{controller_name}.#{action_name}.name")}: #{@token}" :
      @breadcrumbs[-2][:name] = "#{t("tabs.#{controller_name}.#{action_name}.name")}: #{@token}"
  end
  # def inflow
  #   render 'openchain/address/inflow'
  # end

  # def outflow
  #   render 'openchain/address/outflow'
  # end

  # def calls_contracts
  #   render 'openchain/address/calls_contracts'
  # end

  # def money_flow
  #   render 'openchain/address/money_flow'
  # end

  # private

  # def redirect_by_type
  #   if !(sc = @info.try(:smart_contract))
  #     change_controller! 'openchain/address'
  #   elsif sc.try(:currency)
  #     change_controller! 'openchain/trc20token'
  #   end
  # end

end
