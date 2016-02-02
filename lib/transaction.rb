class Transaction
	attr_reader :customer, :product, :id
	@@id = 1
	@@transactions = []

	def initialize(customer_obj, product_obj)
		@customer = customer_obj
		@product = product_obj
		@id = @@id
		@@id += 1
		@product.stock -= 1
		add_transaction
	end

	def self.all
		@@transactions
	end

	def self.find(trans_id)
		@@transactions.each do |transaction|
			if transaction.id == trans_id
				return transaction
			end
		end
	end

	private

		def add_transaction
			@@transactions << self
		end
end