class ComprasController < ApplicationController
  before_action :authenticate_user!

  def elegir_pro
    redirect_to compra_exitosa_path(plan: 'Pro'), notice: '¡Gracias por tu compra del plan Pro!'
  end

  def elegir_premium
    redirect_to compra_exitosa_path(plan: 'Premium'), notice: '¡Gracias por tu compra del plan Premium!'
  end

  def compra_exitosa
    @mensaje = flash[:notice]
    @plan = params[:plan]
  end
end
