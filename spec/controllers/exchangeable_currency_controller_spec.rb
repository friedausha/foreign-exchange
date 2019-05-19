require 'rails_helper'
require 'factories/exchangeable_currencies_factory'

RSpec.describe ExchangeableCurrencyController do

  describe 'GET index' do
    let!(:currency) { FactoryBot.create(:exchangeable_currency) }
    context 'no filter from' do
      it 'renders json of currencies' do
        expect(ExchangeableCurrency).to receive(:all).and_return([currency])
        get :index
        expect(JSON.parse(response.body)).to eq([JSON.parse(currency.to_json)])
      end
    end

    context 'filter from' do
      it 'renders json of currencies' do
        expect(ExchangeableCurrency).to receive(:where).with(from: currency.from).and_return([currency])
        get :index, params: {from: currency.from}
        expect(JSON.parse(response.body)).to eq([JSON.parse(currency.to_json)])
      end
    end
  end

  describe 'GET show' do
    it 'renders current currency' do
      currency = FactoryBot.create(:exchangeable_currency)
      expect(ExchangeableCurrency).to receive(:find).with(currency.id.to_s).and_return(currency)
      get :show, params: { id: currency.id }

      expect(JSON.parse(response.body)).to eq(JSON.parse(currency.to_json))
    end
  end

  describe 'POST create' do
    it 'creates new exchangeable currency' do
      currency = FactoryBot.create(:exchangeable_currency)
      post :create, params: { exchangeable_currency: {from: currency.from, to: currency.to} }

      expect(JSON.parse(response.body)['from']).to eq(JSON.parse(currency.to_json)['from'])
      expect(JSON.parse(response.body)['to']).to eq(JSON.parse(currency.to_json)['to'])
      expect(response.status).to eq(200)
    end
  end

  describe 'DELETE destroy' do
    let!(:currency) { FactoryBot.create(:exchangeable_currency) }
    it 'delete certain currency' do
      expect{
        delete :destroy, params: {id: currency.id}
      }.to change(ExchangeableCurrency,:count).by(-1)
      expect(response.status).to eq(200)
    end
  end

  describe 'PATCH update' do
    it 'update currency' do
      currency = FactoryBot.create(:exchangeable_currency)
      patch :update, params: {id: currency.id, exchangeable_currency: {from: 'SGG'} }

      expect(ExchangeableCurrency.find(currency.id).from).to eq('SGG')
    end
  end
end
