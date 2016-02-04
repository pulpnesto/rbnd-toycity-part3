class Product
	## Class and instance variables
	attr_reader :title, :price
	attr_accessor :stock
	@@products = []

	## Initialize product with title, price, and stock amount...then add to products array
	def initialize(options = {})
		@title = options[:title]
		@price = options[:price]
		@stock = options[:stock]
		add_product
	end

	## Method to return array of all products
	def self.all
		@@products
	end

	## Method to search product array, by title
	def self.find_by_title(title_to_search)
		@@products.each do |product|
			if product.title == title_to_search
				return product
			end
		end
	end

	## Method to return array of in-stock products.
	def self.in_stock
		in_stock_products = []
		in_stock_products = @@products.select {|product| product.in_stock? }
	end

	## Method to see if a product already exists in products array.
	def duplicate?
		check = []
		check = @@products.select{|product|	product.title == self.title}
		if check.empty?
			false
		else
			raise DuplicateProductError, "#{title} already exists."
		end
	end

	## Method to check if product is stocked
	def in_stock?
		@stock > 0
	end

	## Method to add stock to product
	def restock(amount)
		unless in_stock?
			@stock = amount
		end
	end

	## Method to print a list of customers who purchased a specific product.
	def list_customers_by_product
		transactions = Transaction.find_transactions_by_object(self)
		unless transactions.nil?
			puts "--------------------------------------------------------------------"
			puts "Customers who bought #{@title}   |  Price  |  Date"
			puts "--------------------------------------------------------------------"
			transactions.each do |transaction|
				puts "#{transaction.customer.name} | #{transaction.product.price} | #{transaction.date}"
			end
			puts ""
		end
	end

	private

		## Method to add a product to products array if it doesn't already exist.
		def add_product
			unless duplicate?
				@@products << self
			end
		end
end