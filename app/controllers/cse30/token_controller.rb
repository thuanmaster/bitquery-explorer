class Cse30::TokenController < NetworkController
  layout 'tabs'

  before_action :token, :breadcrumb

  # QUERY = BitqueryGraphql::Client.parse <<-'GRAPHQL'
  #  query ( $token: String!){
  #                   tron{
  #                     transfers(
  #                       currency: {is: $token}
  #                       ) {
  #            currency {
  #                           address
  #                           symbol
  #                           tokenId
  #                           tokenType
  #                         }


  #                     }
  #                   }
  #                 }
  # GRAPHQL

  def transfers
    render 'cse30/token/transfers'
  end

  def holders
    render 'cse30/token/holders'
  end

  def senders
    render 'cse30/trc20token/senders'
  end

  def receivers
    render 'cse30/trc20token/receivers'
  end

  def trades
    render 'cse30/trc20token/trades'
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
end
