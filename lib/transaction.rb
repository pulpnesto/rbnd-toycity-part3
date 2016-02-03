class Transaction
	attr_reader :customer, :product, :id, :date
	@@id = 1
	@@transactions = []

	def initialize(customer_obj, product_obj)
		@customer = customer_obj
		@product = product_obj
		@id = @@id
		@@id += 1
		@product.stock -= 1
		@date = Time.now
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

	## Find transactions by customer
	def self.find_transactions_by_customer(customer_to_search)
		transaction_array = @@transactions.select{|transaction| transaction.customer == customer_to_search}
	end

	private

		def add_transaction
			@@transactions << self
		end
end