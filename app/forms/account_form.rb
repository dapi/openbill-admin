class AccountForm < FormBase
  include Virtus.model

  attribute :id, String
  attribute :key, String
  attribute :category_id, String
  attribute :amount_currency, String
  attribute :meta, AccountMeta
  attribute :details, String

  validates :key, :category_id, presence: true

  def to_hash
    {
      **attributes.except(:id, :meta).select { |k, v| v.present? },
      meta: meta
    }
  end

  def to_model
    self
  end

  def to_param
    id
  end

  def persisted?
    id.present?
  end

  def model_name
    ActiveModel::Name.new(self, nil, 'Account')
  end
end
