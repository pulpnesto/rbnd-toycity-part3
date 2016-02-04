
## Class to indicate when a duplicate product is intialized
class DuplicateProductError < StandardError
end

## Class to indicate when a duplicate customer is intialized
class DuplicateCustomerError < StandardError
end

##  Class to indicate when a product is out of stock
class OutOfStockError < StandardError
end