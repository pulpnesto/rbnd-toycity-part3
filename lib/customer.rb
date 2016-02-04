class Customer

	## Class and instance variables
	attr_reader :name
	@@customers = []

	## Initialize customer with name and add to customers array
	def initialize(options = {})
		@name = options[:name]
		add_customer
	end

	## Method to return customers array
	def self.all
		@@customers
	end

	## Method to search customers array by user name
	def self.find_by_name(name_to_search)
		@@customers.each do |customer|
			if customer.name == name_to_search
				return customer
			end
		end
	end

	## Method to look for a duplicate user name
	def duplicate?
		check = []
		check = @@customers.select{|customer|	customer.name == self.name}
		if check.empty?
			false
		else
			raise DuplicateProductError, "#{name} already exists."
		end
	end

	## Method to purchase a product
	def purchase(product)
		if product.in_stock?
			Transaction.new(self, product)
		else
			raise OutOfStockError, "#{product.title} is out of stock."
		end
	end

	## Method to print all the products purchased by a particular user
	def list_products_purchased
		transactions = Transaction.find_transactions_by_object(self)
		unless transactions.nil?
			puts "--------------------------------------------------------------------"
			puts "Product(s) purchased by #{@name}   |  Price  |  Date"
			puts "--------------------------------------------------------------------"
			transactions.each do |transaction|
				puts "#{transaction.product.title} | #{transaction.product.price} | #{transaction.date}"
			end
			puts ""
		end
	end

private

		## Method to add customer to customer_array
		def add_customer
			unless duplicate?
				@@customers << self
			end
		end

end