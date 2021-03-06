require 'rails_helper'

describe TransactionsController do
  let(:transaction_params) do
    {
      from_account_id: 1,
      to_account_id: 1,
      amount_cents: 100,
      amount_currency: 'RUB',
      key: :key,
      details: :details,
      date: Date.new
    }
  end

  before do
    transactions = double(insert: true, pagination_record_count: 1)
    transaction = double(id: 1, update: true, delete: true, to_hash: {}, amount: 100)

    allow(transactions).to receive(:all).and_return transactions
    allow(transactions).to receive(:paginate).and_return transactions
    allow(transactions).to receive(:reverse_order).and_return transactions
    allow(transactions).to receive(:eager).and_return transactions
    allow(transactions).to receive(:count).and_return 1
    allow(Openbill.service).to receive(:get_pending_webhooks_transactions).and_return transactions
    allow(Openbill.service).to receive(:transactions).and_return transactions
    allow(Openbill.service).to receive(:notify_transaction)
    allow(Openbill.service).to receive(:get_transaction).and_return transaction
    @request.env['HTTP_REFERER'] = 'http://new.example.com:3000/back'
  end

  it '#index' do
    get :index
    assert_response :success
  end

  it '#pending_webhooks' do
    get :pending_webhooks
    assert_response :success
  end

  it '#new' do
    get :new
    assert_response :success
  end

  it '#edit' do
    get :edit, id: 1
    assert_response :success
  end

  it '#create' do
    post :create, transaction: transaction_params
    assert_response :redirect
  end

  it '#update' do
    patch :update, id: 1, transaction: transaction_params
    assert_response :redirect
  end

  it '#destroy' do
    delete :destroy, id: 1
    assert_response :redirect
  end

  it '#notify' do
    get :notify, id: 1
    assert_response :redirect
  end
end
