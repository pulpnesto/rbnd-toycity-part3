class Customer
	attr_reader :name
	@@customers = []

	def initialize(options = {})
		@name = options[:name]
		add_customer
	end

	def self.all
		@@customers
	end

	def self.find_by_name(name_to_search)
		@@customers.each do |customer|
			if customer.name == name_to_search
				return customer
			end
		end
	end

	def duplicate?
		check = []
		check = @@customers.select{|customer|	customer.name == self.name}
		if check.empty?
			false
		else
			raise DuplicateProductError, "#{name} already exists."
		end
	end

	def purchase(product)
		if product.in_stock?
			Transaction.new(self, product)
		else
			raise OutOfStockError, "#{product.title} is out of stock."
		end
	end

	def list_products_purchased
		transactions = Transaction.find_transactions_by_customer(self)
		unless transactions.empty?
			puts "Product(s) purchased by #{@name} |  Price  |  Date"
			puts "---------------------------------------------------------------"
			transactions.each do |transaction|
				puts "#{transaction.product.title} | #{transaction.product.price} | #{transaction.date}"
			end
		end
	end

private

		def add_customer
			unless duplicate?
				@@customers << self
			end
		end

end