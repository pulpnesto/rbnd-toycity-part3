class Transaction
	## Class and instance variables
	attr_reader :customer, :product, :id, :date
	@@id = 1
	@@transactions = []

	## Initialize transaction with customer, product, id, and timestamp
	def initialize(customer_obj, product_obj)
		@customer = customer_obj
		@product = product_obj
		@id = @@id
		@@id += 1
		@product.stock -= 1
		@date = Time.now
		add_transaction
	end

	## Method to return array of all transactions.
	def self.all
		@@transactions
	end

	## Method to find a transaction, by id.
	def self.find(trans_id)
		@@transactions.each do |transaction|
			if transaction.id == trans_id
				return transaction
			end
		end
	end

	## Find transactions by object
	def self.find_transactions_by_object(object_to_search)
		transaction_array = []
		if object_to_search.class == Product
			transaction_array = @@transactions.select{|transaction| transaction.product == object_to_search}
		end
		if object_to_search.class == Customer
			transaction_array = @@transactions.select{|transaction| transaction.customer == object_to_search}
		end
		transaction_array
	end


	private

		## Method to add transaction to array of transactions.
		def add_transaction
			@@transactions << self
		end
end